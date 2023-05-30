<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>
	<title></title>
	<script type="text/javascript">	
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<form action="showAddUnionGateway.do" method="post" name="pageForm">
	
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="9" align="center" ></td>
			</tr>
			<tr>
				<td colspan="9" align="center" class="t_head">
				
				 <bean:message bundle="pageResources" key="page.worldOperation.unionGateway.gatewayList"/>
				</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				
				<td width="8%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGatewayId"/></td>
				<td width="8%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGatewayName"/></td>
				<td width="10%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGatewayId"/></td>
				<td width="10%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGatewayName"/></td>
				<td width="10%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/></td>
				<td width="10%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/></td>
				<td width="19%" align="center" class="t_border_l"> <bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>	
				<td width="19%" align="center" class="t_border_r"> <bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag1"/></td>				
			</tr>		
			
			
	<c:if test="${not empty requestScope.unionGatewayList}">
		<c:forEach items="${requestScope.unionGatewayList}" var="result" varStatus="recordRank" >
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					${result.oldGatewayId} 
				</td>
				<td width="10%" align="center" class="t_border_l">					
					<c:if test="${fn:length(result.oldGatewayName)>15}">
						${fn:substring(result.oldGatewayName,0,15)} ...
					</c:if>
					<c:if test="${fn:length(result.oldGatewayName)<=15}">
						${result.oldGatewayName}
					</c:if>
				</td>
				<td width="10%" align="center" class="t_border_l">
					${result.newGatewayId} 
				</td>
				<td width="10%" align="center" class="t_border_l">					
					
					<c:if test="${fn:length(result.newGatewayName)>15}">
						${fn:substring(result.newGatewayName,0,15)} ...
					</c:if>
					<c:if test="${fn:length(result.newGatewayName)<=15}">
						${result.newGatewayName}
					</c:if>
				</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;
					 
					<fmt:formatDate value="${result.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;
					
					<fmt:formatDate value="${result.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;
					
					<c:if test="${result.state eq -1}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statenotRun"/>
					</c:if>
					<c:if test="${result.state eq 0}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.stateRunning"/>
					</c:if>
					<c:if test="${result.state eq 1}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.StateOver"/>
					</c:if>
					<c:if test="${result.state eq 2}">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.StateAbnormal"/>
					</c:if>
					
				</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;
					${result.operator} 
				</td>
				
				<td width="10%" align="center" class="t_border_r">&nbsp;
					
					<a href="#" onclick="javascript:document.location.href='showOperUnionGateway.do?oldGatewayId=${result.oldGatewayId}&newGatewayId=${result.newGatewayId}';">
						<bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag1"/>
					</a>				
					
				</td>
				
			
			</tr>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.unionGatewayList}">
					<td colspan="9" align="center" class="t_border">					
						<bean:message bundle="pageResources" key="page.common.queryGotNoResults"/>	
					</td>
	</c:if>

			<tr height="30px">
				<td colspan="9" align="center" class="t_border">					
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.addNewTask"/>"/>&nbsp;&nbsp; 
					<input type="button"  value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="window.location.href='showOperUnionGatewayPlan.do?taskId=${requestScope.taskId}'" />&nbsp;&nbsp;
					<input type="button"  value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.stopUnion"/>" onclick="window.location.href='stopUnionGateway.do?taskId=${requestScope.taskId}'" />&nbsp;&nbsp;
					<input name="taskId" type="hidden" value="${requestScope.taskId}"/>&nbsp;&nbsp; 	
				</td>
			</tr>
			
	
		</table>
		
		</form>
		
		
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg}</font>
		</div>
	
	</body>
</html>
