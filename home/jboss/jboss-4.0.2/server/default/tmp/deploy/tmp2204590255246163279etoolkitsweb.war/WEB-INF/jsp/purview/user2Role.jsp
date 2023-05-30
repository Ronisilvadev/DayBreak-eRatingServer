<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
	</head>

	<body bgcolor="#ffffff">
	<form action="modifyUserRole.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" ></td>
			</tr>
			<tr>
				<td align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.user2Role.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.roleList }">
			<c:forEach items="${requestScope.roleList}" var="roleInfo">
			<!-- GM管理员将看不到 客服管理员创建的角色，反之亦然 -->
			<c:if test="${roleInfo.roleLv eq currentUser.userLv}">
				<tr height="23px" class="ffffff">
					<td class="t_border_l t_border_r">
					<input type="checkbox" name="roleId" value="${roleInfo.roleId}"
						<c:forEach items="${requestScope.userRoleList}" var="userRoleInfo">
							<c:if test="${roleInfo.roleId == userRoleInfo.roleId}">checked</c:if>
						</c:forEach>
					/>
					<a href="showRole2Resource.do?roleId=${roleInfo.roleId }">
						${roleInfo.roleName}
					</a>
					</td>
				</tr>
			</c:if>
			</c:forEach>
			</c:if>
			<tr height="30px">
				<td align="center" class="t_border">
					<input type="hidden" name="operId" value="${userInfo.operId}" />&nbsp;&nbsp;
					<input type="hidden" name="roleIdScope" value="${requestScope.roleIdScope}" />&nbsp;&nbsp;
					<input type="hidden" name="operType" value="${requestScope.operType}" />&nbsp;&nbsp;
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.save"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);"/>	
				</td>
			</tr>
		</table>
	</form>
	</body>
</html>