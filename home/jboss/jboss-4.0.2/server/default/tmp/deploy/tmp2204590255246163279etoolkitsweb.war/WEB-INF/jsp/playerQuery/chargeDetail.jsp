<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">		
		function exportData(){
			document.forms[0].action = "exportChargeOrderData.do";
			document.forms[0].submit();
		}
		function exportAllData(){
			document.forms[0].all.value="true" ;
			exportData () ;
		}
		function gotoPage(obj){
			document.forms[0].action = "getChargeDetail.do";
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="getChargeDetail.do" method="post" onsubmit="return validateChargeDetailForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="beginTime" value="<fmt:formatDate value="${beginTime }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="endTime" value="<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				 </td>
			</tr>
			<c:if test="${requestScope.OWNER_TYPE == 2}">
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.chargeOrderCode"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 <table cellpadding="0" cellspacing="0" border="0">
				 <tr>
				 	<!-- 
				 	<td>
				 	<textarea rows="5" cols="20" name="chargeCode"></textarea>
				 	</td>
				 	<td>
				 	<bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.chargeOrderCodeTip"/>
				 	</td>
				 	 -->
				 	 
				 	 <td>
				 	 	<input type="text" name="chargeCode"/>
				 	 </td>
				 </tr>
				 </table>
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gameId"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetailId"/></td>
				<c:if test="${requestScope.OWNER_TYPE == 2}">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeOrderCode"/></td>
				</c:if>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeAmount"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="chargeDetail">
			<tr height="23px">
				<td align="center" class="t_border_l">
					${chargeDetail.gameId }-
					<c:forEach items="${requestScope.gameMap}" var="gamePojo" varStatus="gameStatus">
						<c:if test="${chargeDetail.gameId==gamePojo.key}">
							<c:out value="${gamePojo.value}"></c:out>
						</c:if>
					</c:forEach>
				</td>
				<td align="center" class="t_border_l">${chargeDetail.chargeDetailId }</td>
				<c:if test="${requestScope.OWNER_TYPE == 2}">
				<td align="center" class="t_border_l">&nbsp;${chargeDetail.chargeOrderCode }</td>
				</c:if>
				<td align="center" class="t_border_l">&nbsp;<fmt:formatDate value="${chargeDetail.chargeTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align="center" class="t_border_l">&nbsp;${chargeDetail.chargeAmount }</td>
				<td align="center" class="t_border_l">&nbsp;${chargeDetail.passportName }</td>
				<td align="center" class="t_border_r">&nbsp;${chargeDetail.ratingId }</td>				
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="getChargeDetail.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="beginTime" value="${beginTime}"/>
					<input type="hidden" name="endTime" value="${endTime}"/>
					<input type="hidden" name="chargeCode" value="${chargeCode }"/>
					<input type="hidden" name="all" value="false"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.export"/>" onclick="exportData()"/>
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showChargeDetail.do'"/>
		</div>
	</c:if>
</body>
</html>