<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/modifyTrusteeIp"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="modifyTrusteeIp.do" method="post" onsubmit="return validateTrusteeIpForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.dictionaryConfig.trusteeIp.title"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gameId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gameId}
				 	<input name="gameId" type="hidden" value="${requestScope.gameId}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.ipDesc"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="ipName" type="text" value="${requestScope.ipName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">Ip：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="ip" type="text" value="${requestScope.ip }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="ipId" type="hidden" value="${requestScope.ipId}" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.save"/>" />
				</td>
			</tr>
		</table>
	</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>