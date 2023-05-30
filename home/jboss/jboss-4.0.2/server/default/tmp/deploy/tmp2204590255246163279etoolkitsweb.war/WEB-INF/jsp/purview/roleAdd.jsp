<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script language="javascript">
			
			function changeAction(obj){
				obj.action = "modifyRole.do";
				obj.method = "post";
				if (validateRoleForm(obj)){
					obj.submit();
					return true;
				}
				return false;
			}
			
		</script>
		<html:javascript formName="/addRole"/>
	</head>
	
	<body bgcolor="#ffffff">
		<html:form action="addRole.do" method="post" onsubmit="return validateRoleForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
        	<c:if test="${empty requestScope.roleInfo }">

			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.roleAdd.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.roleName"/>：</td>
				<td class="t_border_r"><input name="roleName" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.roleDesc"/>：</td>
				<td class="t_border_r"><input name="roleDesc" type="text" /></td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>

			</c:if>
						
			<c:if test="${not empty requestScope.roleInfo }">
			
			<tr>
				<td colspan="2" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.purview.roleModify.title"/>
				</td>
			</tr>
			<tr>
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.roleName"/>：</td>
				<td class="t_border_r"><input name="roleName" type="text" value="${roleInfo.roleName }" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.roleDesc"/>：</td>
				<td class="t_border_r"><input name="roleDesc" type="text" value="${roleInfo.roleDesc }" /></td>
			</tr>
			<tr height="30px">
					<td colspan="2" align="center" class="t_border">
					<input name="roleId" type="hidden" value="${roleInfo.roleId }" />
					<input name="oldRoleName" type="hidden" value="${roleInfo.roleName }" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.submit"/>" onclick="return changeAction(document.forms[0]);"/>&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
		
			</c:if>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>
