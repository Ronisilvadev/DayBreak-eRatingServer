<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/addGateway"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="addGateway.do" method="post" onsubmit="return validateGatewayForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.dictionaryConfig.addGateway.title"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gameId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${gameId}
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId2"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayId" type="text" value="${requestScope.gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayProvider"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayProvider">
				 		<option value="1" <c:if test="${ requestScope.gatewayProvider == 1}">selected</c:if>><bean:message bundle="pageResources" key="page.common.dianxin"/></option>
				  		<option value="2" <c:if test="${ requestScope.gatewayProvider == 2}">selected</c:if>><bean:message bundle="pageResources" key="page.common.wangtong"/></option>
				  		<option value="3" <c:if test="${ requestScope.gatewayProvider == 3}">selected</c:if>><bean:message bundle="pageResources" key="page.common.shuangxian"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayName" type="text" value="${requestScope.gatewayName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayUrl"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayUrl" type="text" value="${requestScope.gatewayUrl }" />
				 	<strong><bean:message bundle="pageResources" key="page.common.urlDesc"/></strong>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="gameId" type="hidden" value="${requestScope.gameId}" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.save"/>" />
				</td>
			</tr>
		</table>
	</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>