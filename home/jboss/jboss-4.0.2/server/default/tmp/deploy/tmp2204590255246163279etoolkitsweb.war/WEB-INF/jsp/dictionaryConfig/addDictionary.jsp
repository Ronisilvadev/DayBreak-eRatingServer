<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/addLeague"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="${requestScope.action }.do" method="post" onsubmit="return validateDictionaryConfigForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">${requestScope.title }</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gameId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gameId}
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">${requestScope.codeDesc }：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="code" type="text" value="${requestScope.code }" />&nbsp;
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">${requestScope.nameDesc }：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="name" type="text" value="${requestScope.name }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="codeDesc" type="hidden" value="${requestScope.codeDesc }" />
					<input name="nameDesc" type="hidden" value="${requestScope.nameDesc }" />
					<input name="title" type="hidden" value="${requestScope.title }" />
					<input name="action" type="hidden" value="${requestScope.action }" />
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