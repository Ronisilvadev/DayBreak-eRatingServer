<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>		
		<html:javascript formName="/modifyUserPwd"/>
	</head>

	<body bgcolor="#ffffff">
	<html:form action="modifyUserPwd.do" method="post" onsubmit="return validateUserForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.userPwdModify.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>：</td>
				<td class="t_border_r">
                	${userInfo.passportName }
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.oldPassword"/>：</td>
				<td class="t_border_r"><input name="oldPassword" type="password" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.newPassword"/>：</td>
				<td class="t_border_r"><input name="newPassword" type="password" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.newPasswordAgain"/>：</td>
				<td class="t_border_r"><input name="newPasswordAgain" type="password" /> *</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="operId" type="hidden" value="${userInfo.operId }" />
					<input name="passportName" type="hidden" value="${userInfo.passportName }" />
					<input name="submit" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>"/>&nbsp;&nbsp;
					<input name="submit" type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;					
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