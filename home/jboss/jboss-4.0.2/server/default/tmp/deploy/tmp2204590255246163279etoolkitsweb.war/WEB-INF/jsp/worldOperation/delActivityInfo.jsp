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
		<form action="delActivityInfo.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="10"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="10"><bean:message bundle="pageResources" key="page.worldOperation.delActivityInfo.title"/> </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" colspan="5"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left" colspan="5">
				 	<select name="gatewayId" style="width:200px">
				 		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td align="center" class="t_border" colspan="10">
					<input type="hidden" name="activeIDs" value="${activeIDs }" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit"/>" /> 
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>