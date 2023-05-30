<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
	
		function confirmDel() {
			if (confirm('<bean:message bundle="pageResources" key="page.worldOperation.alertInfo.delActivity"/>')){
				window.location.href='delActivity.do?activityId=${requestScope.activity.activityId }';
			}
			return false;
		}
	</script>
	
</head>

<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.activity }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.activity }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.activityId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.gameName"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.gameName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.activityName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.activity.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		<form action="showSynchronizationActivity.do">
			<input type="hidden" name="activityId">
			<input type="hidden" name="activityName">
			<input type="hidden" name="gameId">
			<input type="hidden" name="gameName">
		</form>		
		<script language="javascript">
			function showSynchronizationActivity(activityId,activityName,gameId,gameName){
				var frm = document.forms[0];
				frm.activityId.value = activityId;
				frm.activityName.value = activityName;
				frm.gameId.value = gameId;
				frm.gameName.value = gameName;
				frm.submit();
			}
		</script>
		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/></td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.dictionary.game.gameName"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></td>
				</tr>
				<c:if test="${not empty requestScope.synGames }">
				<c:forEach items="${requestScope.synGames}" var="synGame">
				<tr height="23px">
						<td align="center" class="t_border_l">
							${synGame.gameName }
						</td>
						<td align="center" class="t_border_l">&nbsp;
							<c:if test="${empty synedGames[synGame.gameId] or synedGames[synGame.gameId] == 0}">
								<a href="#" onclick="showSynchronizationActivity('${activity.activityId}','${activity.activityName}','${synGame.gameId}','${synGame.gameName}')"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/></a>
							</c:if>
						 	<c:if test="${not empty synedGames[synGame.gameId] && synedGames[synGame.gameId] == 1}">
								<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.isSychro"/>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  			<tr>
  				<td align="left"><a href="#" onclick="window.location.href='showAddRelationGames.do';"><bean:message bundle="pageResources" key="page.common.configRelationGames"/></a></td>
  			</tr>
  		</table>
		<br />
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</c:if>
	</body>
</html>