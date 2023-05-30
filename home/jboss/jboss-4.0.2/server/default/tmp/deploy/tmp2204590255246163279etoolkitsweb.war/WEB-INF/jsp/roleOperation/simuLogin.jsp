<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/func.js"></script>
	<title></title>
	<html:javascript formName="/simuLogin"/>
</head>

<body bgcolor="#ffffff">
		<html:form action="simuLogin.do" method="post" onsubmit="return validateSimuLoginForm(this);">
		<c:if test="${empty result }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.simuLogin.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="userName" type="text" style="width:230px" /> 
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.server"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="serverId" type="text" style="width:230px" /> 
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</c:if>
		<c:if test="${not empty result }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td align="center" height="30PX"></td>
				</tr>
				<tr>
					<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.simuLogin.title"/></td>
				</tr>
				<tr height="30px">
					<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.simuLogin.info"/>：
					 </td>
					 <td class="t_border_r" align="left">
					 	${result } 
					 </td>
				</tr>
				<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="button" onclick="javascript:history.go(-1);" value="<bean:message bundle="pageResources" key="page.common.back"/>" />
				</td>
			</tr>
			</table>
		</c:if>
	</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>