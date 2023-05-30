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
			
				if ( document.forms[0].playerName.value == "" || document.forms[0].playerName.value  == null){
					if( document.forms[0].roleName.value == "" || document.forms[0].roleName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.playerQuery.playerinfo.submit"/>');
					  document.forms[0].playerName.focus();
					  return false;
					}
				}
				else {
					  return true;
				}
			}
			
	</script>
	
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.playerInfo }">
		<form action="getTrusteePlayerInfo.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.title"/></td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="center" colspan="2">
					<bean:message bundle="pageResources" key="page.playerQuery.playerinfo.queryType"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/></td>
				<td class="t_border_r" align="left">
					<input name="playerName" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName"/></td>
				<td class="t_border_r" align="left">
					<input name="roleName" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.gatewayID"/></td>
				<td class="t_border_r" align="left">
					<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
					<bean:message bundle="pageResources" key="page.roleOperation.common.roleNameQuery"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit"/>" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.common.historyQuery"/>" onclick="window.location.href='getHistoryInfo.do?flag=trustee'"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.playerInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo1"/> "${playerName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo2"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.ID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.type"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.regestInfo"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.extendID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.extendFlag"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
			</tr>
			<tr height="23px">
					<td align="center" class="t_border_l">${playerInfo.playerId }</td>
					<td align="center" class="t_border_l">
						<gmweb:playerType2Text playerType="${playerInfo.playerType}" />
					</td>
					<td align="center" class="t_border_l">
						<gmweb:idVerifyFlag2Text idVerifyFlag="${playerInfo.idVerifyFlag}" />
					</td>
					<td align="center" class="t_border_l">
						<gmweb:promoterId2Text promoterId="${playerInfo.promoterId}" />
					</td>
					<td align="center" class="t_border_l">
						<gmweb:playerFlag2Text playerFlag="${playerInfo.playerFlag}" />
					</td>
					<td align="center" class="t_border_r">
						<gmweb:playerState2Text state="${playerInfo.strPlayerState}"/>
					</td>
				</tr>
			<tr height="10px">
			  	<td colspan="6" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<c:if test="${isTrustee }">
				<input type="button" onclick="window.location.href='showUnTrusteePlayer.do?playerName=${playerName }&playerId=${playerInfo.playerId }&logId=${requestScope.logId }'" value="<bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.unTrustee"/>" />
			</c:if>
			<c:if test="${!isTrustee }">
				<input type="button" onclick="window.location.href='showTrusteePlayer.do?playerName=${playerName }&playerId=${playerInfo.playerId }'" value="<bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trustee"/>" />
			</c:if>
			<br>
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<c:if test="${not empty requestScope.roleInfoList }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo1"/> "${playerName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo3"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.ID"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.roleName"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.createGateway"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.country"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.sex"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.group"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.level"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.createTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.delTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.logoutTime"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.onlineTime"/></td>
				</tr>
				<c:forEach items="${requestScope.roleInfoList}" var="roleInfo">
				<tr height="23px">
						<td align="center" class="t_border_l">${roleInfo.roleId }</td>
						<td align="center" class="t_border_l"><c:out value="${roleInfo.roleName}"/></td>
						<td align="center" class="t_border_l">${roleInfo.gatewayId }</td>
						<td align="center" class="t_border_l">
							<gmweb:roleOccupationAndNation2Text key="${roleInfo.nationalityId }" valueMap="${requestScope.leagueMap }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:roleGender2Text roleGender="${roleInfo.roleGender }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:roleOccupationAndNation2Text key="${roleInfo.roleOccupation }" valueMap="${requestScope.occupationMap }" />
						</td>
						<td align="center" class="t_border_l">${roleInfo.roleLevel }</td>
						<td align="center" class="t_border_l">
							<gmweb:roleState2Text roleState="${roleInfo.roleState }" />
						</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${ roleInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${roleInfo.deleteTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${roleInfo.lastLogoutTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_r"><gmweb:second2Text second="${roleInfo.totalOnlineSecond }" /></td>
					</tr>
				</c:forEach>
				<tr height="30px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		</c:if>
		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center" ></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo1"/> "${playerName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo14"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.logID"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeType"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.reason"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeOper"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.resumeOper"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.amplyInfo"/></td>
				</tr>
				
				<c:if test="${not empty requestScope.trusteeLogList }">
				<c:forEach items="${requestScope.trusteeLogList}" var="trusteeLog">
				<tr height="23px">
					<td align="center" class="t_border_l">${trusteeLog.logId }</td>
					<td align="center" class="t_border_l">
						<gmweb:trusteeState2Text state="${trusteeLog.state }" />
					</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${ trusteeLog.trusteeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${trusteeLog.restoreTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
					<td align="center" class="t_border_l">
						<c:if test="${trusteeLog.trusteeType == 1 }"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.loginTrustee"/></c:if>
						<c:if test="${trusteeLog.trusteeType == 2 }"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.allTrustee"/></c:if>
					</td>
					<td align="center" class="t_border_l">${trusteeLog.reason }</td>
					<td align="center" class="t_border_l">${trusteeLog.operatorName }</td>
					<td align="center" class="t_border_l">${trusteeLog.restoreOperName }&nbsp;</td>
					<td align="center" class="t_border_r">
						<a href="getTrusteePlayerDetail.do?logId=${trusteeLog.logId }&playerName=${requestScope.playerName }&playerId=${playerInfo.playerId }"><bean:message bundle="pageResources" key="page.roleOperation.common.amplyInfo"/></a>
					</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="9" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
		<div align="center">
			<input type="button" onclick="window.location.href='showQueryTrusteePlayer.do'" value="<bean:message bundle="pageResources" key="page.roleOperation.common.backToQuery"/>"/>
		</div>
	</c:if>
	</body>
</html>