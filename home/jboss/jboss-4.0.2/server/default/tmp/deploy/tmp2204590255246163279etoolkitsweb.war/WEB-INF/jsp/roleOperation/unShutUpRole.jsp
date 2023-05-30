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
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.reason"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				if ( document.forms[0].reason.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.reasonLimit"/>');
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
	<form action="unShutUpRole.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.unShutUpRole.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.unShutUpRole.channel"/>
				 </td>
				 <td class="t_border_r" align="left">
					<select name="channel">
				  		<c:forEach items="${requestScope.channelList}" var="channel">
				  			<option value="${channel.code }" <c:if test="${requestScope.channelCode == channel.code}">selected</c:if>>${channel.name }</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.showUnTrusteePlayer.reason"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="reason" ></textarea>
				  	<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="logId" type="hidden" value="${strLogId }" />
					<input name="gatewayId" type="hidden" value="${strGatewayId }" />
					<input name="playerName" type="hidden" value="${playerName }" />
					<input name="roleId" type="hidden" value="${strRoleId }" />
					<input name="serverId" type="hidden" value="${strServerId }" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.unShutUpRole.unShutUp"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>