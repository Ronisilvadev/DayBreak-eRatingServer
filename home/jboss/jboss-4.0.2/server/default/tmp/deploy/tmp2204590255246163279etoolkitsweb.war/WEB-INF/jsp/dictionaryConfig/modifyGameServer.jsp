<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/modifyGameServer"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="modifyGameServer.do" method="post" onsubmit="return validateGameServerForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.dictionaryConfig.modifyGameServer.title"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gameId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gameId}
				 	<input name="gameId" type="hidden" value="${requestScope.gameId}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId2"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gatewayId }
				 	<input name="gatewayId" type="hidden" value="${requestScope.gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.serverId2"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.serverId }
				 	<input name="serverId" type="hidden" value="${requestScope.serverId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.serverName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="serverName" type="text" value="${requestScope.serverName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.groupId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="groupId">
						<option value="0" <c:if test="${ requestScope.groupId == 0}">selected</c:if>><bean:message bundle="pageResources" key="page.common.commonServer"/></option>
						<option value="1" <c:if test="${ requestScope.groupId == 1}">selected</c:if>><bean:message bundle="pageResources" key="page.common.dcServer"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.serverUrl"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="serverUrl" type="text" value="${requestScope.serverUrl }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.save"/>" />
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