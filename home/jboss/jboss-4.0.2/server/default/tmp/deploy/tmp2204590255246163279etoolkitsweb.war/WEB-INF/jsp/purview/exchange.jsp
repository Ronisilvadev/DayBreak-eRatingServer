<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script language="javascript">
			String.prototype.trim=function(){ 
				return this.replace(/(^\s*)|(\s*$)/g, ""); 
			} 
			
			function check(obj){
				if ( document.forms[0].passportName.value.trim() == "" || document.forms[0].passportName.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.purview.errors.passportName"/>');
					  document.forms[0].passportName.focus();
					  return false;
				}
				if ( document.forms[0].realName.value.trim() == "" || document.forms[0].realName.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.purview.errors.realName"/>');
					  document.forms[0].realName.focus();
					  return false;
				}
				if ( document.forms[0].email.value.trim() == "" || document.forms[0].email.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.purview.errors.email"/>');
					  document.forms[0].email.focus();
					  return false;
				}
				return true;

			}
			
			
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="exchangeUser.do" method="post" onsubmit="return check(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.exchange.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l"  align="right"><bean:message bundle="pageResources" key="page.purview.exchange.passport"/>：</td>
				<td class="t_border_r">
                	${userInfo.passportName }
                	<input name="operId" type="hidden" value="${userInfo.operId }" />
                	<input name="userLv" type="hidden" value="${userInfo.userLv }" />
                	<input name="superiorOper" type="hidden" value="${userInfo.superiorOper }" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l"  align="right"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>：</td>
				<td class="t_border_r">
                	<input name="passportName" type="text" /> *
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.realName"/>：</td>
				<td class="t_border_r"><input name="realName" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.email"/>：</td>
				<td class="t_border_r"><input name="email" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.exchange.submit"/>"/>&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
		</table>
	</form>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>