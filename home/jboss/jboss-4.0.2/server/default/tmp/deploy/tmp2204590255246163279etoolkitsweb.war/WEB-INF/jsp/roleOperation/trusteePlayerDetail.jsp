<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>

</head>

<body bgcolor="#ffffff">
	<form action="unTrusteePlayer.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="8"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="8"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayerDetail.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.roleOperation.common.logID"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.roleOperation.common.gatewayid"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.roleOperation.common.state"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.roleOperation.freezePlayerDetail.executeTime"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.trusteePlayerDetailList}" var="trusteePlayerDetail" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					${trusteePlayerDetail.logId}
				</td>
				<td align="center" class="t_border_l">
					${trusteePlayerDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					<gmweb:trusteeState2Text state="${trusteePlayerDetail.state}" />
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${trusteePlayerDetail.trusteeTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${trusteePlayerDetail.restoreTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="8">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.back"/> " onclick="window.location.href='getTrusteePlayerInfo.do?playerName=${requestScope.playerName }'"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.remove"/>" <c:if test="${requestScope.count < 1}">disabled</c:if> />
					<input type="hidden" name="playerName" value="${requestScope.playerName }" />
					<input type="hidden" name="playerId" value="${requestScope.playerId }" />
					<input type="hidden" name="logId" value="${requestScope.logId }" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>