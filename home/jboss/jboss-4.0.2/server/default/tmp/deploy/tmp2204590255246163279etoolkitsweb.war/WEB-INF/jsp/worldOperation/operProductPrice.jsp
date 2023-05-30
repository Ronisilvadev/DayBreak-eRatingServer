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

</head>


<body bgcolor="#ffffff">
	<form action="sendProductPrice.do" method="post">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.operProductPrice.title"/>
				</td>
			</tr>
		<tr height="30px">
			<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<select name="gatewayId" style="width:200px">
						<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.common.allGateway"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input type="hidden" name="priceId" value="${ requestScope.priceId}" />
					<input type="hidden" name="productCode" value="${ requestScope.productCode}" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="history.go(-1);"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<strong><font color="red"><bean:message bundle="pageResources" key="page.worldOperation.operProductPrice.ps"/></font></strong>
		</div>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>