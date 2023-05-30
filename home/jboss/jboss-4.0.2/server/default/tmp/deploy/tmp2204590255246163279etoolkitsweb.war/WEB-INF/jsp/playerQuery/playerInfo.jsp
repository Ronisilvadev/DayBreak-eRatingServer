<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	
	<script type="text/javaScript">
	String.prototype.trim=function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	} 
	function check(){
		var playerName = document.getElementById('playerName').value;
		var playerId = document.getElementById('playerId').value;
		var roleName = document.getElementById('roleName').value;
		var roleId = document.getElementById('roleId').value;
		var sum = playerName.trim() + playerId.trim() + roleName.trim() + roleId.trim();
		if(sum.length>0){
			return true;
		}else{
			alert('<bean:message bundle="pageResources" key="page.playerQuery.playerinfo.submit"/>');
			return false;
		}
	}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.playerInfo }">
		<html:form action="getPlayerInfo.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.title"/> </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="center" colspan="2">
					<bean:message bundle="pageResources" key="page.playerQuery.playerinfo.queryType"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td class="t_border_r" align="left">
					<input name="playerName" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passportID"/></td>
				<td class="t_border_r" align="left">
					<input name="playerId" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/></td>
				<td class="t_border_r" align="left">
					<input name="roleName" type="text" style="width:200px" />
				</td>
			</tr><tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleID"/></td>
				<td class="t_border_r" align="left">
					<input name="roleId" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/></td>
				<td class="t_border_r" align="left">
					<select name="gatewayId" style="width:200px">
						<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
					<bean:message bundle="pageResources" key="page.playerQuery.playerinfo.queryInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.playerInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.playerInfo"/>
				</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.ID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.type"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.playerInfoValidate"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.tuiguangID"/></td>

				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.kuozhanFlag"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/></td>
			</tr>
			<tr height="23px">
					<td align="center" class="t_border_l">${playerInfo.playerId }</td>
					<td align="center" class="t_border_l">
						<gmweb:playerType2Text playerType="${playerInfo.playerType}" />&nbsp;
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
		<tr height="30px">
			  	<td colspan="6" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="14" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "${playerName }" <bean:message bundle="pageResources" key="page.playerQuery.playerinfo.roleInfo"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gameId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.ID"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.roleName"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.gateway"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.country"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.sex"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.occuptationTotal.job"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.lv"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.createTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.roleFirstLoginIP"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.delTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.logoutTime"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.onlineTime"/></td>
				</tr>
				<c:if test="${not empty requestScope.roleInfoList }">
				<c:forEach items="${requestScope.roleInfoList}" var="roleInfo">
				<tr height="23px">
						<td align="center" class="t_border_l">
							${roleInfo.gameId }-
							<c:forEach items="${requestScope.gameMap}" var="gamePojo" varStatus="gameStatus">
								<c:if test="${roleInfo.gameId==gamePojo.key}">
									<c:out value="${gamePojo.value}"></c:out>
								</c:if>
							</c:forEach>
						</td>
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
						<td align="center" class="t_border_l">&nbsp;${roleInfo.firstLoginIp }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${roleInfo.deleteTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${roleInfo.lastLogoutTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_r"><gmweb:second2Text second="${roleInfo.totalOnlineSecond }" /></td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
					  	<td colspan="14" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
				</table>
	
				<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center" ></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo1"/> "${playerName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo4"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.logID"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.freezeTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.planFreezetime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.reason"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.freezeOper"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.unFreezeOper"/></td>
				</tr>
				
				<c:if test="${not empty requestScope.freezeLogList }">
				<c:forEach items="${requestScope.freezeLogList}" var="freezeLog">
				<tr height="23px">
					<td align="center" class="t_border_l">${freezeLog.logId }</td>
					<td align="center" class="t_border_l"><gmweb:freezeState2Text state="${freezeLog.state }" /></td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${ freezeLog.freezeTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l"><fmt:formatNumber value="${freezeLog.lastSeconds / 60 }" pattern="0"/></td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${freezeLog.unFreezeTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
					<td align="center" class="t_border_l">${freezeLog.reason }</td>
					<td align="center" class="t_border_l">${freezeLog.operatorName }</td>
					<td align="center" class="t_border_r">${freezeLog.unFreezeOperName }&nbsp;</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="9" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
			</table>

				<div align="center">
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryPlayerInfo.do'"/>
				</div>
	</c:if>
	</body>
</html>