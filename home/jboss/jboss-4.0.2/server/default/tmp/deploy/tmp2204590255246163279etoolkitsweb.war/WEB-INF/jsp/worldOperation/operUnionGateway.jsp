<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>
	<title></title>
	

	
</head>

<body bgcolor="#ffffff">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.unionGateway"/></td>
			</tr>
			<c:if test="${not empty requestScope.unionGateway }">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGatewayId"/>
				 </td>
				<td align="center" class="t_border_r">${requestScope.unionGateway.oldGatewayId }&nbsp;</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGatewayName"/>
				 </td>
				<td align="center" class="t_border_r">${requestScope.unionGateway.oldGatewayName }&nbsp;</td>
			</tr><tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGatewayId"/>
				 </td>
				<td align="center" class="t_border_r">${requestScope.unionGateway.newGatewayId }&nbsp;</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGatewayName"/>
				 </td>
				<td align="center" class="t_border_r">${requestScope.unionGateway.newGatewayName }&nbsp;</td>
			</tr>
						
			
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGateway.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGateway.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;
				${result.state} 
					<c:if test="${requestScope.unionGateway.state eq -1}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statenotRun"/>
					</c:if>
					<c:if test="${requestScope.unionGateway.state eq 0}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.stateRunning"/>
					</c:if>
					<c:if test="${requestScope.unionGateway.state eq 1}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.StateOver"/>
					</c:if>
					<c:if test="${requestScope.unionGateway.state eq 2}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.StateAbnormal"/>
					</c:if>
					</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;${requestScope.unionGateway.operator}&nbsp;</td>
			</tr>
			
			
			
			
			
			
			
			
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>

		<div align="center">
			<!-- 返回 -->
			<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="window.location.href='showUnionGatewayList.do?taskId=${requestScope.unionGateway.taskId}'" />&nbsp;&nbsp;
			<!-- 未执行状态 -->
			<c:if test="${requestScope.unionGateway.state==-1 }">				
			
			    <input type="button" id="exeTask" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exeTask"/>" onclick="document.getElementById('deleteTask').disabled=true;window.location.href='exeUnionGateway.do?oldGatewayId=${requestScope.unionGateway.oldGatewayId}&newGatewayId=${requestScope.unionGateway.newGatewayId}'" />&nbsp;&nbsp;
				<input type="button" id="deleteTask" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.deleteTask"/>" onclick="document.getElementById('exeTask').disabled=true;window.location.href='delUnionGateway.do?oldGatewayId=${requestScope.unionGateway.oldGatewayId}&newGatewayId=${requestScope.unionGateway.newGatewayId}'" />&nbsp;&nbsp;
			</c:if>
			<!-- 正在执行状态 -->
			<c:if test="${requestScope.unionGateway.state==0 }">				
				<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.openTask"/>" onclick="window.location.href='openUnionGateway.do?ajaxRequest=0&oldGatewayId=${requestScope.unionGateway.oldGatewayId}&newGatewayId=${requestScope.unionGateway.newGatewayId}'" />&nbsp;&nbsp;
			</c:if>
			<!-- 正常结束 -->
			<c:if test="${requestScope.unionGateway.state==1 }">				
			</c:if>
			<!-- 异常结束 -->
			<c:if test="${requestScope.unionGateway.state==2 }">
				<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.reExeTask"/>" onclick="window.location.href='exeUnionGateway.do?oldGatewayId=${requestScope.unionGateway.oldGatewayId}&newGatewayId=${requestScope.unionGateway.newGatewayId}'" />&nbsp;&nbsp;		
			</c:if>		
			
		</div>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg}</font>
	</div>	
	</body>
</html>