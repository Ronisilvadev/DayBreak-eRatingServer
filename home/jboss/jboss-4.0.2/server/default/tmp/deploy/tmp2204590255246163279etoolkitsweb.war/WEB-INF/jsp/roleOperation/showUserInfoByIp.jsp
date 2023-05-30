<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
	<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
		<script type="text/javaScript">
   			function check () {
   				var re =  /^(((1?\d?\d|(2([0-4]\d|5[0-5])))|(\*))\.){3}((1?\d?\d|(2([0-4]\d|5[0-5])))|(\*))$/ ;
   				var val = document.getElementById("ip").value ;
				var flag = re.test(val) ;
				if(!flag && val!='0'){
					window.alert('<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.ipFormatError" />') ;
					return false ;
				}
   			}
   			function unCheck () {
   				var players = document.getElementsByName ('PlayerId') ;
   				for(var i = 0 ; i < players.length ;i++){
   					if (players[i].checked){
   						document.getElementById("free").disabled=false ;
   						return ;
   					}
   				}
   				document.getElementById("free").disabled=true ;
   				return ;
   			}
   			function selectAllPlayerID (){
   				var players = document.getElementsByName ('PlayerId') ;
   				if(players==null || players.length==0){
   					return ;
   				}
   				if(window.event.srcElement.value=='<bean:message bundle="pageResources" key="page.common.selectAll"/>'){
   					for(var i = 0 ; i < players.length ;i++)
   						players[i].checked = true ;
   					window.event.srcElement.value='<bean:message bundle="pageResources" key="page.common.cancel" />' ;
   						document.getElementById("free").disabled=false ;	
   				}else{
   					for(var i = 0 ; i < players.length ;i++)
   						players[i].checked = false ;
   					window.event.srcElement.value='<bean:message bundle="pageResources" key="page.common.selectAll" />' ;
   					document.getElementById("free").disabled=true ;
   				}
   			}
   			function submitFree () {
   				var players = document.getElementsByName('PlayerId') ;
   				var params  = "" ;
   				for(var i = 0 ; i < players.length ;i++){
   					if(players[i].checked){
   						if(i>0){
   							params+="\r\n" ;
   						}
   						params += players[i].value ;
   					}
   				}
   				if(params==""){
   					window.alert('<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.noSelectPlayer" />') ;
   					return  false;
   					}
   				document.getElementById('accounts').value=params ;
   				return true ;
   			}
   			function nextPage(val){
   				document.getElementById("page").value = val ;
   				document.forms[0].submit() ;
   			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<c:if test="${empty requestScope.data and empty requestScope.columnName}">
			<form action="userInfoByIp.do" method="post"
				onsubmit="return check();">
				<table width="90%" border="0" cellpadding="0" cellspacing="0"
					align="center">
					<tr>
						<td align="center" height="30PX"></td>
					</tr>
					<tr>
						<td align="center" class="t_head" colspan="2">
							<bean:message bundle="pageResources"
								key="page.roleOperation.showUserInfoByIp.title" />
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources" key="page.common.gatewayId" />
						</td>
						<td class="t_border_r" align="left">
							<select name="gatewayId" style="width: 200px">
								<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
								<c:forEach var="target" items="${requestScope.gatewayList}">
									<option value="${target.gatewayId }">
										${target.gatewayId} - ${target.gatewayName }
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.showUserInfoByIp.ip" />
						</td>
						<td class="t_border_r" align="left">
							<input type="text" name="ip" id="ip" style="width: 200px" />
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.showUserInfoByIp.startTime" />
						</td>
						<td class="t_border_r" align="left">
							<input type="text" name="start_time" readonly="readonly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" style="width: 200px" />
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.showUserInfoByIp.endTime" />
						</td>
						<td class="t_border_r" align="left">
							<input type="text" name="end_time" style="width: 200px"  readonly="readonly"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'});" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.showUserInfoByIp.type" />
						</td>
						<td class="t_border_r" align="left">
							<select name="type" style="width: 200px">
								<option value="0">
									<bean:message bundle="pageResources"
										key="page.roleOperation.showUserInfoByIp.type.online" />
								</option>
								<option value="1">
									<bean:message bundle="pageResources"
										key="page.roleOperation.showUserInfoByIp.type.offline" />
								</option>
							</select>
						</td>
					</tr>
					<tr height="30px">
						<td class="t_border_r" style="border-bottom: #AEAEB0 1px solid;"
							align="center" colspan="2">
							<input type="submit"
								value="<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.userInfoByIp"/>" />
						</td>
					</tr>
				</table>
				<div align="center"><font color="red">${msg }</font></div>
			</form>
		</c:if>
		<c:if test="${not empty requestScope.data or not empty requestScope.columnName}">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr height="30px">
					<td colspan="11" align="center"></td>
				</tr>
				<tr>
					<td colspan="11" align="center" class="t_head">
						<bean:message bundle="pageResources"
							key="page.roleOperation.showUserInfoByIp.userInfoByIpInfo.title" />
					</td>
				</tr>
				<tr height="30px" class="h_CDE4F6">
					<c:if test="${commonUser.ip != flag}">
						<td align="center"  class="t_border_l">
								&nbsp;
						</td>
					</c:if>
					<c:forEach var="desc" items="${columnName}" varStatus="colstate">
						<c:if test="${colstate.last}">
							<td align="center" class="t_border_r">
								${desc }
							</td>
						</c:if>
						<c:if test="${not colstate.last}">
							<td align="center" class="t_border_l">
								${desc }
							</td>
						</c:if>
					</c:forEach>
				</tr>
					
				<c:forEach var="target" items="${data}" varStatus="rowState">
						<tr height="30px">
							<c:forEach var="desc" items="${target.data}" varStatus="colstate">
								<c:if test="${commonUser.ip != flag and colstate.first}">
									<td align="center"  class="t_border_l" <c:if test="${rowState.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
										<input type="checkbox" name="PlayerId" value="${target.data[1] }" onclick="unCheck () ;"/>
									</td>
								</c:if>
								<c:if test="${colstate.last}">
									<td align="center" class="t_border_r" <c:if test="${rowState.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
										${desc }
									</td>
								</c:if>
								<c:if test="${not colstate.last}">
									<td align="center" class="t_border_l" <c:if test="${rowState.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
										${desc }
									</td>
								</c:if>
							</c:forEach>
						</tr>
				</c:forEach>
				<!--<tr height="30px">
			 	<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="20">
				<form action="userInfoByIp.do" method="post">
					<input type="hidden" name="gatewayId" value="${commonUser.gatewayId }"/>
					<input type="hidden" name="ip" value="${commonUser.ip }"/>
					<input type="hidden" name="page" id="page" value="${commonUser.page }"/>
					<input type="hidden" name="type" value="${commonUser.type }"/>
					<input type="hidden" name="start_time" value="${commonUser.startTime }"/>
					<input type="hidden" name="end_time" value="${commonUser.endTime }"/>
					<c:if test="${commonUser.page>1 }"><a href="#" onclick="nextPage('${commonUser.page }'); return false;"><bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="#" onclick="nextPage(document.getElementById('toPage').value); return false;">GO</a>
					<a href="#" onclick="nextPage('${commonUser.page+1 }'); return false;"><bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.cur"/>${commonUser.page}<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.page"/>&nbsp;&nbsp;&nbsp;
				</form>
				</td>
			</tr>	 -->	
		</table>
			<div align="center"><font color="red">${msg }</font></div>
		<div align="center">
			<c:if test="${commonUser.ip != flag}">
			<form action="showFastFreezeAccount.do" method="post" onsubmit="return submitFree () ;"><input type="hidden" name="oper" value="freeze"/><input type="hidden" name="freezeType" value="2"/><input type="hidden" name="accounts" id="accounts" value=""/>
			<table cellpadding="0" cellspacing="0" border="0" width="90%" align="center">
			<tr>
			<td align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onclick="selectAllPlayerID();"/>
				
					<input type="submit" id="free" value="<bean:message bundle="pageResources" key="page.roleOperation.showUserInfoByIp.freeUser"/> " disabled="disabled"/>
				
			</c:if>
			
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);"/>
			</td>
			</tr>
			</table>
			</form>
		</div>
		</c:if>
	</body>
</html>
