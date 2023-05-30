<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>	
	<script type="text/javascript">
		function nextPage(curPage){
			if(isNum(curPage)){
				document.getElementById('curPage').value=curPage;
				document.forms[0].submit();
			}else{
				alert('<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.errPage"/>');
			}
		}
		
		function gotoPage(obj){
			document.forms[0].action = "getFundExchange.do";
			obj.submit();
		}
	</script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">	
		<form action="getFundExchange.do" method="post" onsubmit="return validateFundExchangeForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.title"/></td>
			</tr>
			<tr>
			<td width="35%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.exchangeType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="exchangeType" type="radio" checked value='1' ><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.exchangeType.bargainor"/>
					<input name="exchangeType" type="radio" value='2'><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.exchangeType.purchaser"/>
				 	
				 </td>
			</tr>					
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="passportName">
				 </td>
			</tr>				
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="startTime" value="<fmt:formatDate value="${startTime }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="endTime" value="<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="page" value="1" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_r">
				<c:choose>				
				<c:when test="${ requestScope.exchangeType == 1}">
				<bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.dstPassportName"/>
				</c:when>
				<c:otherwise>
				<bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.srcPassportName"/>
				</c:otherwise>
				</c:choose>
				</td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.exchangeTime"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.userFundExchange.amount"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.list}" var="userFundExchangePOJO">
			<tr height="23px">
				<td align="center" class="t_border_r">${userFundExchangePOJO.passportName }</td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${userFundExchangePOJO.exchangeTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align="center" class="t_border_r">&nbsp;${userFundExchangePOJO.amount }</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="getRoleLog.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="startTime" value="${startTime}"/>
					<input type="hidden" name="endTime" value="${endTime}"/>
					<input type="hidden" name="passportName" value="${passportName }"/>
					<input type="hidden" name="exchangeType" value="${exchangeType }"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> "  onclick="history.go(-1);"/>
		</div>	
	</c:if>
	
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>