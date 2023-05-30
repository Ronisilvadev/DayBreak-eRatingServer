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
			
	</script>
</head>


<body bgcolor="#ffffff">

	<form action="kickRole.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryRole2Oper.kickRole" /></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName" />
				 </td>
				 <td class="t_border_r" align="left">
				 	${roleName }
				 	<input name="roleName" type="hidden" value="${roleName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atPassport" />
				 </td>
				 <td class="t_border_r" align="left">
				 	${playerName }
				 	<input name="playerName" type="hidden" value="${playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atGateway" />
				 </td>
				 <td class="t_border_r" align="left">
				 	${gatewayId }
				 	<input name="gatewayId" type="hidden" value="${gatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.atServer" />
				 </td>
				 <td class="t_border_r" align="left">
				 	${serverId }
				 	<input name="serverId" type="hidden" value="${serverId }" />
				 </td>
			</tr>
				<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason" />
				 </td>
				 <td class="t_border_r" align="left">
				 	<SELECT name="reason">
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason1" />' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.kickRole.reason1 />' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason1" /></option>
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason2" />' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.kickRole.reason2 />' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason2" /></option>
						<option value='<bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason3" />' <c:if test="${requestScope.reason == '<bean:message bundle=pageResources key=page.roleOperation.kickRole.reason3 />' }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.kickRole.reason3" /></option>	
					</SELECT>
				 </td>
			</tr>
			<!-- 
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.kickTime" />
				 </td>
				 <td class="t_border_r" align="left">
				 	<gmweb:createPunishTimeOption name="lastSecond" checkedValue="${requestScope.lastSecond}" />
				 </td>
			</tr>
			 -->
			<input name="lastSecond" type="hidden" value="0"/>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.kickRole.remark" />
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="50" rows="10" name="description" >${requestScope.description}</textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="roleId" type="hidden" value="${requestScope.roleId }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.kickRole.kick" /> " />
				</td>
			</tr>
		</table>
	</form>
	
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="11" align="center" ></td>
				</tr>
				<tr>
					<td colspan="11" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo6"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.role"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.service"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.kickTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.planFreezetime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.reason"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.kickOper"/></td>
					<!-- <td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.resumeOper"/></td> -->
				</tr>
				<c:if test="${not empty requestScope.kickOffLogList }">
				<c:forEach items="${requestScope.kickOffLogList}" var="kickOffLog" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${kickOffLog.passportName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${kickOffLog.roleName }"/></td>
					<td align="center" class="t_border_l">${kickOffLog.gatewayId }</td>
					<td align="center" class="t_border_l">
						<c:if test="${kickOffLog.state == 1 }">
							<bean:message bundle="pageResources" key="page.roleOperation.common.kicking"/>
						</c:if>
						<c:if test="${kickOffLog.state == 2 }">
							<bean:message bundle="pageResources" key="page.roleOperation.common.kickresume"/>
						</c:if>
					</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${ kickOffLog.kickOffTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l"><fmt:formatNumber value="${kickOffLog.lastSeconds / 60 }" pattern="0"/></td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${kickOffLog.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
					<td align="center" class="t_border_l">${kickOffLog.reason }</td>
					<td align="center" class="t_border_l">${kickOffLog.operatorName }</td>
					<!-- 
					<td align="center" class="t_border_r">
						<c:if test="${kickOffLog.state == 1 }">
							<a href="unKickRole.do?logId=${kickOffLog.logId }&gatewayId=${kickOffLog.gatewayId }&serverId=${kickOffLog.serverId }&roleId=${requestScope.roleId }&playerName=${kickOffLog.passportName }"><bean:message bundle="pageResources" key="page.roleOperation.common.endKick"/></a>
						</c:if>
						<c:if test="${kickOffLog.state == 2 }">
							${kickOffLog.restoreOperName }
						</c:if>
					</td>
					 -->
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="11" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
	</body>
</html>