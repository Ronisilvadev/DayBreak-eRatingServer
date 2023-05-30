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
				}else if ( document.forms[0].description.value.length > 512){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remarkLimit"/>');
						document.forms[0].description.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
			
			function changeMoveType(){
				var sceneCode = document.getElementById("sceneCode");
				var moveTarget = document.getElementById("moveTarget");
				if (document.forms[0].moveType.value == '0' || document.forms[0].moveType.value == '2' || document.forms[0].moveType.value == '3'){
					sceneCode.style.display = "none";
					moveTarget.style.display  = "";
				}else{
					sceneCode.style.display = "";
					moveTarget.style.display  = "none";
				}
			}
			
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="moveRole.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.moveRole" /></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName" />
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${roleName }"/>
				 	<input name="roleName" type="hidden" value="${roleName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atPassport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${playerName }"/>
				 	<input name="playerName" type="hidden" value="${playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atGateway"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${gatewayId }
				 	<input name="gatewayId" type="hidden" value="${gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atServer"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${serverId }
				 	<input name="serverId" type="hidden" value="${serverId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.reason"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="reason">
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.moveRole.reason1"/>' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.moveRole.reason1/>' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.reason1"/></option>
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.moveRole.reason2"/>' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.moveRole.reason2/>' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.reason2"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="moveType" onchange="changeMoveType()">
						<option value='0' <c:if test="${requestScope.moveType == 0 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveType1"/></option>
						<option value='1' <c:if test="${requestScope.moveType == 1 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveType2"/></option>
						<option value='2' <c:if test="${requestScope.moveType == 2 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveType3"/></option>
						<option value='3' <c:if test="${requestScope.moveType == 3 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveType4"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.aim"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<select name="sceneCode" id="sceneCode">
				  		<c:forEach items="${requestScope.sceneList}" var="scene">
				  			<option value="${scene.code }" <c:if test="${requestScope.sceneCode == scene.code}">selected</c:if>>${scene.name }</option>
				  		</c:forEach>
					</select>
					<input name="moveTarget" id="moveTarget" type="text" />
					<bean:message bundle="pageResources" key="page.roleOperation.moveRole.remark"/>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.remark"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="description" >${requestScope.description}</textarea>
				  	<bean:message bundle="pageResources" key="page.roleOperation.error.remarkLimit"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="roleId" type="hidden" value="${requestScope.roleId }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.move"/> " />
				</td>
			</tr>
		</table>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		</form>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center" ></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo7"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.role"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.service"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.moveTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.aimArea"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.reason"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>
				</tr>
				<c:if test="${not empty requestScope.moveLogList }">
				<c:forEach items="${requestScope.moveLogList}" var="moveLog" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${moveLog.passportName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${moveLog.roleName }"/></td>
					<td align="center" class="t_border_l">${moveLog.gatewayId }</td>
					<td align="center" class="t_border_l">
						<c:if test="${moveLog.state == 1 }">
							<bean:message bundle="pageResources" key="page.roleOperation.common.success"/>
						</c:if>
						<c:if test="${moveLog.state == 2 }">
							<bean:message bundle="pageResources" key="page.roleOperation.common.error"/>
						</c:if>
						<c:if test="${moveLog.state == 0 }">
							<bean:message bundle="pageResources" key="page.roleOperation.common.error"/>
						</c:if>
					</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${ moveLog.moveTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">${moveLog.sceneName }</td>
					<td align="center" class="t_border_l">${moveLog.reason }</td>
					<td align="center" class="t_border_r">${moveLog.operatorName }</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="9" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
		<script type="text/javaScript">
			changeMoveType();
		</script>
	</body>
</html>