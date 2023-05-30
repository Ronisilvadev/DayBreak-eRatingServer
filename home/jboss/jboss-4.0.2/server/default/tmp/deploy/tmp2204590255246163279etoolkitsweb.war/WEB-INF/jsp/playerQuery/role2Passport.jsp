<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/role2Passport"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.passports && empty requestScope.errRole}">
		<html:form action="role2Passport.do" method="post" onsubmit="return validateRole2PassportForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="gatewayId" style="width:150px">
						<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.roles"/>：
				 </td>
				 <td class="t_border_1" align="left">
				 	<textarea rows="10" cols="40" name="roles"></textarea>
				 </td>
				 <td class="t_border_r" align="left">
				 	<bean:message bundle="pageResources" key="page.playerQuery.role2Passport.rolesInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.passports}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.passports"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<textarea rows="10" cols="40" name="roles">${passports }</textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${not empty requestScope.errRole}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.errRole"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.role2Passport.roles"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<textarea rows="10" cols="40" name="roles">${errRole }</textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
				</td>
			</tr>
		</table>
	</c:if>
</body>
</html>