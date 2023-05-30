<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>

	<script type="text/javaScript">
			
			function check(){
			
				if ( document.forms[0].description.value == "" || document.forms[0].description.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remark"/>');
					  document.forms[0].description.focus();
					  return false;
				}else if ( document.forms[0].description.value.length > 512){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remarkLimit"/>');
						document.forms[0].description.focus();
						return false;
				}
				
				else {
					   return confirm('<bean:message bundle="pageResources" key="page.roleOperation.delRole.alert"/>');
				}
			}
			
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="delRole.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryDelRole.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${requestScope.roleInfo.roleName }"/>
				 	<input name="roleName" type="hidden" value="${requestScope.roleInfo.roleName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atPassport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${requestScope.roleInfo.playerName }"/>
				 	<input name="playerName" type="hidden" value="${requestScope.roleInfo.playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atGateway"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.roleInfo.gatewayId }
				 	<input name="gatewayId" type="hidden" value="${requestScope.roleInfo.gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.roleState"/>
				 </td>
				 <td class="t_border_r" align="left">
					 <gmweb:roleState2Text roleState="${requestScope.roleInfo.roleState }" />
				 	<input name="roleState" type="hidden" value="${requestScope.roleInfo.roleState }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.roleLv"/>
				 </td>
				 <td class="t_border_r" align="left">
					 ${requestScope.roleInfo.roleLevel }
				 	<input name="roleLevel" type="hidden" value="${requestScope.roleInfo.roleLevel }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.roleExp"/>
				 </td>
				 <td class="t_border_r" align="left">
					 ${requestScope.roleInfo.experience }
				 	<input name="experience" type="hidden" value="${requestScope.roleInfo.experience }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.createTime"/>
				 </td>
				 <td class="t_border_r" align="left">
					 <fmt:formatDate value="${requestScope.roleInfo.create_time}" pattern="yyyy-MM-dd HH:mm:ss"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.onlineTime"/>
				 </td>
				 <td class="t_border_r" align="left">
					${requestScope.roleInfo.total_online_second}
				 	<input name="total_online_second" type="hidden" value="${requestScope.roleInfo.total_online_second }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.delRole.delReason"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<SELECT name="reason">
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.delRole.playerPlan"/>' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.delRole.playerPlan/>' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.delRole.playerPlan"/></option>
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.delRole.other"/>' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.delRole.other/>' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.delRole.other"/></option>
					</SELECT>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.remark"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="description" >${requestScope.description}</textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="roleId" type="hidden" value="${requestScope.roleInfo.roleId }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.delRole.del"/> " />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.back"/> " onclick="window.location.href='showQueryDelRole.do'"/>
				</td>
			</tr>
		</table>
	</form>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	</body>
</html>