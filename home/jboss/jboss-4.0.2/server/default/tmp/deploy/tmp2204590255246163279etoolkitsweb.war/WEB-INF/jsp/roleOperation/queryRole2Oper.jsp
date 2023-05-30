<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javaScript">
		function check(){
		
			if ( document.forms[0].keyWord.value == "" || document.forms[0].keyWord.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.roleName" />');
				  document.forms[0].keyWord.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
		
		function gotoPage(obj){
			obj.submit();
		}
			
		</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<form action="getRole2Oper.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<c:if test="${requestScope.oper == 'kickRole'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.kickRole" /> 
					</c:if>
					<c:if test="${requestScope.oper == 'kickRole2'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.kickRole" />
					</c:if>
					<c:if test="${requestScope.oper == 'shutUp'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.shutUp" />
					</c:if>
					<c:if test="${requestScope.oper == 'moveRole'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.moveRole" />
					</c:if>
					<c:if test="${requestScope.oper == 'endTask'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.endTask" />
					</c:if>
					<c:if test="${requestScope.oper == 'endPlayerFightState'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.endPlayerFightState" />
					</c:if>
					<c:if test="${requestScope.oper == 'restoreSanYuan'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.restoreSanYuan" />
					</c:if>
					<c:if test="${requestScope.oper == 'cleanPackage'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.cleanPackage" />
					</c:if>
					<c:if test="${requestScope.oper == 'operationDetail'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.operationDetail" />
					</c:if>
					<c:if test="${requestScope.oper == 'goodsHistoryFromNPC'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.goodsHistoryFromNPC" />
					</c:if>
					<c:if test="${requestScope.oper == 'goodsHistoryToNPC'}">
							<bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.goodsHistoryToNPC" />
					</c:if>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.gatewayID" /></td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				 		<option value="0" selected>0 - <bean:message bundle="pageResources" key="page.roleOperation.common.allServer" /></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>&nbsp;
					<c:if test="${empty requestScope.gatewayList}">
						<bean:message bundle="pageResources" key="page.roleOperation.showQueryShutUpRole.nothasGateway"/>
					</c:if>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName" /></td>
				 <td class="t_border_r" align="left">
				 	<input name="keyWord" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.queryType"/></td>
				<td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.roleOperation.common.blurQuery"/><input type="radio" name="selectFlag" value="0" checked /><bean:message bundle="pageResources" key="page.roleOperation.common.queryRemark"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 	<bean:message bundle="pageResources" key="page.roleOperation.common.exactitudeQuery"/><input type="radio" name="selectFlag" value="1" /> 
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head">${requestScope.title}</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.roleName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.createGateway"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.roleState"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.atPassport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.playerState"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="roleInfo4Oper" varStatus="status">
			<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${roleInfo4Oper.roleName }"/></td>
					<td align="center" class="t_border_l">${roleInfo4Oper.gatewayId}</td>
					<td align="center" class="t_border_l">
						<gmweb:roleState2Text roleState="${roleInfo4Oper.roleState }" />
					</td>
					<td align="center" class="t_border_l"><c:out value="${roleInfo4Oper.playerName }"/></td>
					<td align="center" class="t_border_l">
						<gmweb:gatewayId2Text gatewayId="${roleInfo4Oper.playerState }" />
					</td>
					<td align="center" class="t_border_r">
					<c:if test="${roleInfo4Oper.playerState != 0}">
						<c:if test="${requestScope.oper == 'kickRole'}">
							<a href="showKickRole.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'kickRole2'}">
							<a href="showKickRole2.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'shutUp'}">
							<a href="showShutUpRole.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'moveRole'}">
							<a href="showMoveRole.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.move"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'endTask'}">
							<a href="showEndTask.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.task"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'endPlayerFightState'}">
							<a href="showEndPlayerFightState.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'restoreSanYuan'}">
							<a href="showRestoreSanYuan.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'cleanPackage'}">
							<a href="showCleanPackage.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'operationDetail'}">
							<a href="showOperationDetail.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'goodsHistoryFromNPC'}">
							<a href="showGoodsHistoryFromNPC.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'goodsHistoryToNPC'}">
							<a href="showGoodsHistoryToNPC.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
						</c:if>
					</c:if>
					<c:if test="${roleInfo4Oper.playerState == 0}">
						<c:if test="${requestScope.oper == 'kickRole'}">
							<a href="operOfflineRole.do?oper=showKickRole&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'kickRole2'}">
							<a href="operOfflineRole.do?oper=showKickRole2&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'shutUp'}">
							<a href="operOfflineRole.do?oper=showShutUpRole&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
							<!--<bean:message bundle="pageResources" key="page.roleOperation.common.noOper"/>-->
						</c:if>
						<c:if test="${requestScope.oper == 'moveRole'}">
							<a href="operOfflineRole.do?oper=showMoveRole&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
							<!--<bean:message bundle="pageResources" key="page.roleOperation.common.noOper"/>-->
						</c:if>
						<c:if test="${requestScope.oper == 'endTask'}">
							<a href="operOfflineRole.do?oper=showEndTask&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
							<!--<bean:message bundle="pageResources" key="page.roleOperation.common.noOper"/>-->
						</c:if>
						<c:if test="${requestScope.oper == 'endPlayerFightState'}">
							<a href="operOfflineRole.do?oper=showEndPlayerFightState&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'restoreSanYuan'}">
							<bean:message bundle="pageResources" key="page.roleOperation.common.noOper"/>
						</c:if>
						<c:if test="${requestScope.oper == 'cleanPackage'}">
							<a href="operOfflineRole.do?oper=showCleanPackage&roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }"><bean:message bundle="pageResources" key="page.roleOperation.common.selfOper"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'operationDetail'}">
							<a href="showOperationDetail.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'goodsHistoryFromNPC'}">
							<a href="showGoodsHistoryFromNPC.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
						</c:if>
						<c:if test="${requestScope.oper == 'goodsHistoryToNPC'}">
							<a href="showGoodsHistoryToNPC.do?roleId=${roleInfo4Oper.roleId }&gatewayId=${roleInfo4Oper.gatewayId }&serverId=${roleInfo4Oper.serverId }&playerName=${roleInfo4Oper.playerName }"><bean:message bundle="pageResources" key="page.roleOperation.common.queryInfo"/></a>
					</c:if>
					</c:if>
					</td>
				</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="getRole2Oper.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="keyWord" value="${keyWord}"/>	
					<input type="hidden" name="oper" value="${requestScope.oper}"/>
					<input type="hidden" name="gatewayId" value="${requestScope.gatewayId}"/>
					<input type="hidden" name="selectFlag" value="${requestScope.selectFlag }"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
</body>
</html>