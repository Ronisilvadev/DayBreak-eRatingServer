<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>
  <head>
    
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script language="javascript">
		function  ontheload() {
			
			var arr= document.getElementsByName ("gameid") ;
			for (var i = 0 ; i < arr.length; i++){
				if(arr[i].checked){
					document.getElementById("sub").disabled = false ;
					break ;
				}
			}
		}
		function checkAll (frm) {
			var arr_element = document.getElementsByName("gameid") ;
		
			if(window.event.srcElement.value=='<bean:message bundle="pageResources" key="page.common.selectAll"/>'){
   					for(var i = 0 ; i < arr_element.length ;i++){
   						arr_element[i].checked = true ;
   					}
   					window.event.srcElement.value='<bean:message bundle="pageResources" key="page.common.cancel" />' ;
   					document.getElementById("sub").disabled = false ;	
   				}else{
   					for(var i = 0 ; i < arr_element.length ;i++)
   						arr_element[i].checked = false ;
   					window.event.srcElement.value='<bean:message bundle="pageResources" key="page.common.selectAll" />' ;
   					document.getElementById("sub").disabled = true ;
   				}
		
		}
		function uncheck(frm){
			var arr_element = document.getElementsByName("gameid") ;
			var te = 0 ;
			for(var i = 0 ; i < arr_element.length ; i ++)
			{
				if(!arr_element[i].checked){
					te++ ;
				}
			}
			if(te ==arr_element.length){
				document.getElementById("sub").disabled = true ;
				document.getElementById("selectAll").value='<bean:message bundle="pageResources" key="page.common.selectAll" />' ;
				return ;
			}
			document.getElementById("sub").disabled = false ;
			document.getElementById("selectAll").value='<bean:message bundle="pageResources" key="page.common.cancel" />' ;
			
		}
		
	</script>
  </head>
  <body  bgcolor="#ffffff" onload="ontheload();">
  		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center"></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.dictionaryConfig.gameServerConfig.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td width="10%" align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gameId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayId2"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.serverId2"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.serverName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.groupId"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.common.serverUrl"/>
					</td>
					
				</tr>
				<c:if test="${not empty requestScope.gameServerList }">
				<c:forEach items="${requestScope.gameServerList}" var="gameServer" varStatus="status">
					<tr height="23px" >
						<td width="10%"  align="center" <c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_l"</c:if>>
							${gameServer.gameId }
							<input name="gameId${status.index + 1 }" type="hidden" value="${gameServer.gameId }"  />
						</td>
						<td align="center" <c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_l"</c:if>>
							${gameServer.gatewayId }
							<input name="gatewayId${status.index + 1 }" type="hidden" value="${gameServer.gatewayId }" />
						</td>
						<td align="center" <c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_l"</c:if>>
							${gameServer.serverId }
							<input name="serverId${status.index + 1 }" type="hidden" value="${gameServer.serverId }" />
						</td>
						<td align="center" <c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_l"</c:if>>
							${gameServer.serverName }
						</td>
						<td align="center" <c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_l"</c:if>>
							<c:if test="${gameServer.groupId == 1 }">
								<bean:message bundle="pageResources" key="page.common.dcServer"/>
							</c:if>
							<c:if test="${gameServer.groupId == 0 }">
								<bean:message bundle="pageResources" key="page.common.commonServer"/>
							</c:if>
						</td>
						<td align="center"<c:if test="${status.last }">class="t_border"</c:if> <c:if test="${not status.last }">class="t_border_r"</c:if>>
							${gameServer.serverUrl }
						</td>
					</tr>
				</c:forEach>
				</c:if>
		</table>
		<div align="center">
			<font color="red">${msg }</font>
		</div>
  		<form action="synGameServer.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
					<td colspan="9" align="center"></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.common.synGame.title"/>
					</td>
				</tr>
			<tr height="23px" class="h_CDE4F6"><td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.dictionary.game.gameName"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.syn.lastOperTime"/></td></tr>
			<c:forEach var="tempGame" items="${games}">
			<tr height="23px">
				<td align="center" class="t_border_l"><input type="checkbox" name="gameid" value="${tempGame.gameId }" onclick="uncheck(document.forms[0]);" <c:if test="${not empty synOpered[tempGame.gameId]}">checked</c:if>/></td>
				<td align="center" class="t_border_l">${tempGame.gameName }</td>
				<td align="center" class="t_border_r"><c:if test="${not empty synOpered[tempGame.gameId]}">${synOpered[tempGame.gameId]}</c:if><c:if test="${empty synOpered[tempGame.gameId]}"><bean:message bundle="pageResources" key="page.common.syn.havenoOper"/></c:if></td>
			</tr>
			</c:forEach>
			<tr height="30px">
				<td colspan="9" align="center" class="t_border">
					<input id="selectAll" name="selectAll" type="button"  value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onClick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input type="submit" id="sub" value = "<bean:message bundle="pageResources" key="page.common.synGame.syn"/> " disabled="true" />
				</td>
			</tr>
		</table>
		</form>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  			<tr>
  				<td align="left"><a href="#" onclick="window.location.href='showAddRelationGames.do';"><bean:message bundle="pageResources" key="page.common.configRelationGames"/></a></td>
  			</tr>
  		</table>
  </body>
</html>
