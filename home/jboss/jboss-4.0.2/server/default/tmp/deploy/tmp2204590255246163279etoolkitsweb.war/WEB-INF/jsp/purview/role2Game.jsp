<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>		
	</head>
	
	<body bgcolor="#ffffff">
		<html:form action="insertRoleGame.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
			<input type="hidden" name="roleId" value="${roleInfo.roleId}"/>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.role2game.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.roleName"/>：</td>
				<td class="t_border_r">${roleInfo.roleName}</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.login.game"/>：</td>
				<td class="t_border_r">
				<select name="gameId">
					<c:forEach items="${requestScope.gameList}" var="game">
						<option value="${game.gameId }" >${game.gameName }</option>
					</c:forEach>
				</select>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</table>	
		</html:form>
		<br>
		<br>		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">			
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.purview.roleManage.roleName"/></td>				
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.login.game"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>				
			</tr>
			<c:if test="${not empty requestScope.roleGameList }">
			<c:forEach items="${requestScope.roleGameList}" var="roleGame">
			<tr height="30px">
				<td align="center" class="t_border_r">${roleInfo.roleName}</td>
				<td align="center" class="t_border_r">${roleGame.gameName}</td>
				<td align="center" class="t_border_r">
				<a onclick="return confirm('<bean:message bundle="pageResources" key="page.purview.deleteConfirm"/>')" href="deleteRoleGame.do?roleId=${roleInfo.roleId}&gameId=${roleGame.gameId}"><bean:message bundle="pageResources" key="page.common.delete"/></a>
				</td>
			</tr>
			</c:forEach>
			</c:if>
			<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				&nbsp;
			</td>
		</tr>
		</table>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>

