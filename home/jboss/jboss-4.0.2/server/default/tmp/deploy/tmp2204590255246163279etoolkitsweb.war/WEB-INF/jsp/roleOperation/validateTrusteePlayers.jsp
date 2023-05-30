<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
</head>


<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.playerInfoList }">
	<form action="trusteePlayers.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="3" align="center" ></td>
			</tr>
			<tr>
				<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.passport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.ID"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.playerState"/></td>
			</tr>
		<c:forEach items="${requestScope.playerInfoList}" var="playerInfo">
			<tr height="23px">
					<td align="center" class="t_border_l"><c:out value="${playerInfo.playerName}"/></td>
					<td align="center" class="t_border_l">
						<c:if test="${playerInfo.playerId == 0}">
							<font color="red"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.unKnowPassport"/></font>
						</c:if>
						<c:if test="${playerInfo.playerId != 0}">
							${playerInfo.playerId } 
						</c:if>
					</td>
					<td align="center" class="t_border_r">
						<c:if test="${fn:contains(playerInfo.strPlayerState, 2)}">
							<font color="red"><gmweb:playerState2Text state="${playerInfo.strPlayerState}"/> </font>
						</c:if>
						<c:if test="${!fn:contains(playerInfo.strPlayerState, 2)}">
							<gmweb:playerState2Text state="${playerInfo.strPlayerState}"/>
						</c:if>
						&nbsp;
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
		  	<td colspan="3" align="center" class="border_top">
				<strong><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.freezeInfo"/></strong>
			</td>
		</tr>
		</table>
		<div align="center">
			<input name="playerNames" type="hidden" value="${requestScope.playerNames }" />
			<input name="password" type="hidden" value="${requestScope.password }" />
			<input name="adminPassword" type="hidden" value="${requestScope.adminPassword }" />
			<input name="allowIp" type="hidden" value="${requestScope.allowIp }" />
			<input name="trusteeType" type="hidden" value="${requestScope.trusteeType }" />
			<input name="reason" type="hidden" value="${requestScope.reason }" />
			<input type="button" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.back"/> " onclick="history.back();"/>&nbsp;&nbsp;
			<input name="search" type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.submitExecute"/>" />
		</div>
	</form>
	</c:if>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	</body>
</html>