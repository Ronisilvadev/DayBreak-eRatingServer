<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
	</head>

	<body bgcolor="#ffffff">
	<html:form action="modifyUser.do">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.userModify.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>：</td>
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
                	${userInfo.passportName }
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.realName"/>：</td>
				<td class="t_border_b"><input name="realName" type="text" value="${userInfo.realName }" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.email"/>：</td>
				<td class="t_border_b"><input name="email" type="text"  value="${userInfo.email }" /> *</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="operId" type="hidden" value="${userInfo.operId }" />
					<input name="submit" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>"/>&nbsp;&nbsp;
					<input name="submit" type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
		</table>
	</html:form>
	</body>
</html>