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
				}
				
				else {
					  return true;
				}
			}
			
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="endPlayerFightState.do" method="post" >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" ></td>
			</tr>
			<tr>
				<td align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo11"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo12"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_r">
					<input type="hidden" name="roleName" value="${requestScope.roleName }" />
					<input type="hidden" name="roleId" value="${requestScope.roleId }" />
					<input type="hidden" name="gatewayId" value="${requestScope.gatewayId }" />
					<input type="hidden" name="serverId" value="${requestScope.serverId }" />
					<input type="hidden" name="playerName" value="${requestScope.playerName }" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.endFightState.endState"/>"/>
				</td>
			</tr>	
			
			<tr height="5px">
				<td align="center" class="border_top">&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</table>
	</form>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="12" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo13"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.role"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.service"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.operTime"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>
				</tr>
				<c:if test="${not empty requestScope.endPlayerFightStateLogList }">
				<c:forEach items="${requestScope.endPlayerFightStateLogList}" var="endPlayerFightStateLog" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${endPlayerFightStateLog.passportName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${endPlayerFightStateLog.roleName }"/></td>
					<td align="center" class="t_border_l">${endPlayerFightStateLog.gatewayId }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${endPlayerFightStateLog.operateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_r">${endPlayerFightStateLog.operatorName }</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
		
		<div align="center">
			<input type="button" onClick="window.location.href='showQueryEndPlayerFightState.do'" value="<bean:message bundle="pageResources" key="page.roleOperation.common.backToQuery"/>"/>
		</div>
	</body>
</html>