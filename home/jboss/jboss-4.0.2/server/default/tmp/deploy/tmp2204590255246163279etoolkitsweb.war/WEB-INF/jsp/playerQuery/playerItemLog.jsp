<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/getLogPlayerItems"/>
	<html:javascript formName="/modifyItemName"/>
	<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="getLogPlayerItems.do" method="post" onsubmit="return validateGetLogPlayerItemsForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerItemLog.title"/> </td>
			</tr>
			<c:if test="${not empty requestScope.internal}">
				<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.game"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gameId" style="width:200px">
				 	<c:forEach var="game" items="${requestScope.games}">
				 		<option value="${game.gameId }" <c:if test="${game.gameId == sessionScope.gameId }">selected</c:if>>${game.gameName }</option>
				 	</c:forEach>
				 	</select>
				 	<input type="hidden" value="${internal }" name="internal"></input>
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="playerName" type="text" style="width:200px" value="${requestScope.playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.itemCode"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemCode" type="text" style="width:200px" value="${requestScope.itemCode }" />
				 	<bean:message bundle="pageResources" key="page.common.ableNull"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "${playerName }" <bean:message bundle="pageResources" key="page.playerQuery.playerItemLog.playerItemLog"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.gateway"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.huodongNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.num"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.operationTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.operationType"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.code"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.itemNum"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="logPlayerItem">
			<tr height="23px">
					<td align="center" class="t_border_l">${logPlayerItem.gatewayId }</td>
					<td align="center" class="t_border_l" >${logPlayerItem.activityId }</td>
					<td align="center" class="t_border_l">${logPlayerItem.itemNum }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${logPlayerItem.operTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">
						<gmweb:itemOperType2Text operType="${logPlayerItem.operType }" />		
					</td>
					<td align="center" class="t_border_l">${logPlayerItem.playerItemCode }</td>
					<td align="center" class="t_border_r">
						<html:form action="modifyItemName.do" method="post" onsubmit="return validateModifyItemNameForm(this);">
							<input name="itemName" type="text" value="${logPlayerItem.playerItemName }" />
							<input name="playerItemCode" type="hidden" value="${logPlayerItem.playerItemCode }" />
							<input name="comeFromAction" type="hidden" value="/getLogPlayerItems.do?playerName=${playerName }&itemCode=${logPlayerItem.playerItemCode }&beginDate=<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/><c:if test="${not empty internal}">&internal=${internal }</c:if><c:if test="${not empty requestScope.gameId}">&gameId=${requestScope.gameId }</c:if>" />
							<input type="hidden" name="beginDate" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
							<input type="hidden" name="endDate" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
							<input type="hidden" name="playerName" value="${playerName}"/>
							<input type="hidden" name="page" value="${requestScope.pageInfo.currentPage}"/>
							<input type="submit" value="<bean:message bundle="pageResources" key="page.common.modify"/>" />
						</html:form>
					</td>
				</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="getLogPlayerItems.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />		
					<input type="hidden" name="beginDate" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="endDate" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="playerName" value="${playerName}"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showLogPlayerItems.do<c:if test="${not empty internal}">?internal=${internal }</c:if>'"/>
		</div>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
</body>
</html>