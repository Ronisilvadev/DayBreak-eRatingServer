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
			
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remark"/>');
					  document.forms[0].reason.focus();
					  return false;
				}else if ( document.forms[0].reason.value.length > 512){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remarkLimit"/>');
						document.forms[0].reason.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
			
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="cleanPackage.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.cleanPackage"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${roleName }
				 	<input name="roleName" type="hidden" value="${roleName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atPassport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${playerName }
				 	<input name=playerName type="hidden" value="${playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atGateway"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${gatewayId }
				 	<input name="gatewayId" type="hidden" value="${gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atServer"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${serverId }
				 	<input name="serverId" type="hidden" value="${serverId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.cleanPackage.packageName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="pkgName" type="test" value="${pkgName }" />
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.cleanPackage.cleanPackageDetail"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="50" rows="10" name="reason" >${requestScope.reason}</textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="roleId" type="hidden" value="${requestScope.roleId }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.cleanPackage.clean"/> " />
				</td>
			</tr>
		</table>
	</form>

		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="7" align="center" ></td>
				</tr>
				<tr>
					<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo15"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.role"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.service"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.cleanPackage.cleanTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.reason"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>
				</tr>
				<c:if test="${not empty requestScope.cleanPackageLogList }">
				<c:forEach items="${requestScope.cleanPackageLogList}" var="pkg" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l">${pkg.passportName }</td>
					<td align="center" class="t_border_l">${pkg.roleName }</td>
					<td align="center" class="t_border_l">${pkg.gatewayId }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${ pkg.operateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">${pkg.reason }</td>
					<td align="center" class="t_border_r">${pkg.operatorName }</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="7" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
	</body>
</html>