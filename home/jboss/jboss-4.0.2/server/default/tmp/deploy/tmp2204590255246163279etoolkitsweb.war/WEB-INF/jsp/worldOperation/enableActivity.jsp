<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>

</head>

<body bgcolor="#ffffff">
		<form action="enableActivity.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"> 
				<c:if test="${state=='temp'}"><bean:message bundle="pageResources" key="page.worldOperation.enableActivity.title1"/></c:if>
				<c:if test="${opFlag=='start'}"><bean:message bundle="pageResources" key="page.worldOperation.enableActivity.title2"/></c:if>
				<c:if test="${opFlag=='stop'}"><bean:message bundle="pageResources" key="page.worldOperation.enableActivity.title3"/></c:if>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left" >
				 	<select name="gatewayId" style="width:200px">
				 		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td align="center" class="t_border" colspan="2">
					<input type="hidden" name="opFlag" value="${opFlag }" />
					<input type="hidden" name="state" value="${state }" />
					<input type="hidden" name="activeID" value="${activeID }" />
					<input type="hidden" name="enable" value="${enable }" />					
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" /> 
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>