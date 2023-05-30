<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/queryRoleTitle"/>
	<html:javascript formName="/changeRoleTitle"/>
	<script type="text/javascript">
	function  check(roleTitle){
		document.getElementById('roleTitle').value=roleTitle;
		document.forms[0].submit();
	}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.gatewayList }">
		<html:form action="queryRoleTitle.do" method="post" onsubmit="return validateQueryRoleTitleForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.role"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="roleName" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</html:form>
	</c:if>
	<c:if test="${empty requestScope.gatewayList && requestScope.roleTitleType=='queryRoleTitle'}">
	<form action="showChangeRoleTitle.do" method="post">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="4" align="center" ></td>
		</tr>
		<tr>
			<td colspan="4" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.title"/> </td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.roleID"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.rorletitle"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>
		</tr>
		<c:forEach items="${requestScope.roleTitleList }" var="roleTitle">
			<tr height="23px">
			<td align="center" class="t_border_l">${roleId }</td>
			<td align="center" class="t_border_l"><c:out value="${roleName}"/></td>
			<td align="center" class="t_border_l">${roleTitle }</td>
			<td align="center" class="t_border_r"><a onmouseover="this.style.cursor='hand'" onclick="check('${roleTitle }');" ><bean:message bundle="pageResources" key="page.common.modify"/></a></td>
		</tr>
		</c:forEach>
		<tr height="5px">
			<td colspan="4" class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" >
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryRoleTitle.do'">
				<input type="hidden" name="gatewayId" value="${gatewayId }"/>
				<input type="hidden" name="roleId" value="${roleId }"/>
				<input type="hidden" name="roleName" value="${roleName }"/>
				<input type="hidden" id="roleTitle" name="roleTitle"/>
			</td>
		</tr>
	</table>
	</form>
	</c:if>
	<c:if test="${empty requestScope.gatewayList && requestScope.roleTitleType=='changeRoleTitle'}">
		<html:form action="changeRoleTitle.do" method="post" onsubmit="return validateChangeRoleTitleForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.titleType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="titleType" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleTitle.level"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="level" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="hidden" name="roleId" value="${roleId }"/>
					<input type="hidden" name="roleName" value="${roleName }"/>
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.modify"/>" />
				</td>
			</tr>
		</table>
	</html:form>
	</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>