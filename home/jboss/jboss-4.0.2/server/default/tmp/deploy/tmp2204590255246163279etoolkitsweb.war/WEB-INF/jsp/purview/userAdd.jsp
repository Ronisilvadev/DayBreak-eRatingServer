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
				obj.action = "modifyUser.do";
				obj.method = "post";
				if (validateUserForm(obj)){
					obj.submit();
					return true;
				}
				return false;
			}
			
			
		</script>
		<html:javascript formName="/addUser"/>
	</head>

	<body bgcolor="#ffffff">
		<html:form action="addUser.do" method="post" onsubmit="return validateUserForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
        	<c:if test="${empty requestScope.userInfo }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.userAdd.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>：</td>
				<td class="t_border_r"><input name="passportName" type="text" /> *</td>
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
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.userLevel"/></td>
				<td class="t_border_r">
					<input name="userLv" type="radio" value="0" checked /><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicer"/>
					<c:if test="${userInfo.userLv eq 30}">
						${requestScope.userInfo.userLv}
						<input name="userLv" type="radio" value="20" /><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdmin"/> (<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdminTips"/>${requestScope.servicerAdminNum})
					</c:if>
				</td>
			</tr>
			
			
			
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<c:if test="${currentUserInfo.userLv != '1' }">
					<input name="userLv" type="hidden" value="0" />
					</c:if>
					<input name="submit" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />&nbsp;&nbsp;
					<input name="submit" type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			
			</c:if>
			
			<c:if test="${not empty requestScope.userInfo }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.userModify.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l"  align="right"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>：</td>
				<td class="t_border_r">
                	${userInfo.passportName }
                	<input name="passportName" type="hidden" value="${userInfo.passportName }" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.realName"/>：</td>
				<td class="t_border_r"><input name="realName" type="text" value="${userInfo.realName }" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.email"/>：</td>
				<td class="t_border_r"><input name="email" type="text" value="${userInfo.email }" /> *</td>
			</tr>
			 
			 
			 
			 
			 
			 
			 
			 
			 <tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.userLevel"/>&nbsp;</td>
				<td class="t_border_r">
							<!-- 普通用户 -->					
							<c:if test="${userInfo.userLv <10}">
									<input name="userLv" type="hidden" value="0"  />
									<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicer"/>
							</c:if>
							<!-- 客服管理员 -->					
							<c:if test="${userInfo.userLv eq 20}">
									<input name="userLv" type="radio" value="20"/>
									<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdmin"/>
							</c:if>
							(<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.changeUserLevelTips"/>)
							 
						
					
					
					
					<c:if test="${userInfo.userLv eq 30}">
						<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.gameAdmin"/>									
					</c:if>
				</td>
			</tr>
			
			
			
			
			
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="operId" type="hidden" value="${userInfo.operId }" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.submit"/>" onclick="changeAction(document.forms[0]);" />&nbsp;&nbsp;
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