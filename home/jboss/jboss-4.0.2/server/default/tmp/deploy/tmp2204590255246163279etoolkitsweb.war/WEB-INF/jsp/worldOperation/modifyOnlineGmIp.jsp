<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script language="javascript">
			
			function check(){
			
				if ( document.forms[0].loginIp.value == "" || document.forms[0].loginIp.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.IP"/>');
					  document.forms[0].loginIp.focus();
					  return false;
				}
				
				if ( document.forms[0].loginIp.value.length > 1024){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.IPLength"/>');
					  document.forms[0].loginIp.focus();
					  return false;
				}
				if (!/^\d+$/.test(document.forms[0].acountType.value)){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.type"/>');
					  document.forms[0].acountType.focus();
					  return false;
				}
				
			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="modifyOnlineGmIp.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.modifyOnlineGmIp.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.passportName"/></td>
				<td class="t_border_r">
                	${onlineGm.passportName }
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.modifyOnlineGmIp.IP"/></td>
				<td class="t_border_r">
				 	<textarea name="loginIp" rows=8 cols=35 size="10240" >${onlineGm.loginIp }</textarea>
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.modifyOnlineGmIp.IPInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.modifyOnlineGmIp.Type"/></td>
				<td class="t_border_r">
					<input name="acountType" value="${onlineGm.acountType}"/>
				 	<bean:message bundle="pageResources" key="page.worldOperation.modifyOnlineGmIp.TypeInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="gmId" type="hidden" value="${onlineGm.gmId }" />
					<input name="passportName" type="hidden" value="${onlineGm.passportName }" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.worldOperation.common.restart"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>" onclick="window.location.href='showOnlineGm.do'" />
				</td>
			</tr>
			
		</table>
	</form>
	</body>
</html>