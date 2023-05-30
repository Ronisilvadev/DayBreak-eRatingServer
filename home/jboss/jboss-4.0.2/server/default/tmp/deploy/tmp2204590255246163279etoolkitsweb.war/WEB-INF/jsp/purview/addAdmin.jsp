<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/addAdmin"/>
	</head>
	<body bgcolor="#ffffff">
		<html:form action="addAdmin.do" method="get" onsubmit="return validateAdminForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.adminAdd.title"/></td>
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
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.login.game"/>：</td>
				<td class="t_border_r">
					<select name="gameId">
						
						<c:forEach var="targetGame" items="${requestScope.gamelist}">
							<option value="${targetGame.gameId}">
								${targetGame.gameId }-${targetGame.gameName }
							</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="center" class="t_border_l"  style="border-bottom:#AEAEB0 1px solid;padding-left:50px">&nbsp;</td>
				<td style="border-right:#AEAEB0 1px solid;border-top:#AEAEB0 1px solid;border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left">
					<input name="submit" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />&nbsp;&nbsp;
					<input name="submit" type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
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
	
