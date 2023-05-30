<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/getPlayerChargeDetail"/>
	<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="getPlayerChargeDetail.do" method="post" onsubmit="return validateGetPlayerChargeDetailForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.title"/> </td>
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
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "${playerName }" <bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.info"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.gateway"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.money"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.moneyType"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.Date"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderId"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.type"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="chargeDetail">
			<tr height="23px">
				<td align="center" class="t_border_l">
					<c:if test="${not empty chargeDetail.ratingName }">
						${chargeDetail.ratingName}
					</c:if>
					<c:if test="${empty chargeDetail.ratingName }">
						<c:if test="${chargeDetail.ratingId == 0}">
							<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.nofenqu"/>
						</c:if>
						<c:if test="${chargeDetail.ratingId != 0}">
							${chargeDetail.ratingId}
						</c:if>
					</c:if>
				</td>
				<c:if test="${not empty requestScope.moneyRate}">
					<td align="center" class="t_border_l">
					<c:forEach items="${requestScope.moneyRate}" var="test">
					<gmweb:subjectId2Text3 chargeAmount="${chargeDetail.chargeAmount}" subjectId="${chargeDetail.subjectId }" charge_rate="${test.charge_rate}" moneyType="${test.money_type}" />
					</c:forEach>
                  </td>
				<td align="center" class="t_border_l">
					<gmweb:subjectId2Text2 subjectId="${chargeDetail.subjectId }" />
				</td>
                  
                </c:if>
				<c:if test="${empty requestScope.moneyRate}">
					<td align="center" class="t_border_l">${chargeDetail.chargeAmount}</td>
				<td align="center" class="t_border_l">
					<gmweb:subjectId2Text subjectId="${chargeDetail.subjectId }" />
				</td>
				</c:if>
				<td align="center" class="t_border_l"><fmt:formatDate value="${chargeDetail.chargeTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align="center" class="t_border_l">${chargeDetail.chargeDetailId }</td>
				<td align="center" class="t_border_r">
					<c:if test="${chargeDetail.chargeType == 1}">
						<c:if test="${chargeDetail.chargeAmount >= 0}">
							<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.chongzhi"/>
						</c:if>
						<c:if test="${chargeDetail.chargeAmount <0}">
							<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.chexiao"/>
						</c:if>
					</c:if>
					<c:if test="${chargeDetail.chargeType == 2}">
						<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.lingyong"/>
					</c:if>
					<c:if test="${chargeDetail.chargeType == 3}">
						<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.zhuanzhang"/>
					</c:if>
				</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="getPlayerChargeDetail.do" method="post">
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
			<strong><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.chongzhiheji"/>：<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.jin"/>：${requestScope.chargeJinQuan}，<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.yin"/>：${requestScope.chargeYinQuan}；<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.lingyongheji"/>：<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.jin"/>：${requestScope.useJinQuan}，<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.yin"/>：${requestScope.useYinQuan}；<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.zhuanzhangheji"/>：<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.jin"/>：${requestScope.transJinQuan}，<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.yin"/>：${requestScope.transYinQuan} </strong>
		</div>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showQueryPlayerChargeDetail.do<c:if test="${not empty internal}">?internal=${internal }</c:if>'"/>
		</div>
	</c:if>
</body>
</html>