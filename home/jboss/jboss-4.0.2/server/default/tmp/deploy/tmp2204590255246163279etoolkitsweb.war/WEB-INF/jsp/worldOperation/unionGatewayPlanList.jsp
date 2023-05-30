<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javaScript">		
		</script>
	</head>

	<body bgcolor="#ffffff">
		
	<form action="showAddUnionGatewayPlan.do" method="post" name="pageForm">
	
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="9" align="center" ></td>
			</tr>
			<tr>
				<td colspan="9" align="center" class="t_head">
				
				 <!-- <bean:message bundle="pageResources" key="page.worldOperation.unionGateway.gatewayTaskList"/>-->
				 
				 		<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.gatewayTaskList"/>
				</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				
				
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.planName"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.insertTime"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakeStatus"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exeStatus"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exeOperator"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag1"/></td>
				
			</tr>		
			
			
	<c:if test="${not empty requestScope.unionGatewayPlanList}">
		<c:forEach items="${requestScope.unionGatewayPlanList}" var="result" varStatus="recordRank" >
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="15%" align="center" class="t_border_l">&nbsp;
					${result.taskName} 
				</td>
				<td width="15%" align="center" class="t_border_l">					
					
					&nbsp;<fmt:formatDate value="${result.insertTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
				</td>				
				<td width="15%" align="center" class="t_border_l">&nbsp;
								
										<c:if test="${result.backStatus==-1 }">
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusUnbake"/>
										</c:if>
										<!-- 正在执行状态 -->
										<c:if test="${result.backStatus==0 }">				
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusBaking"/>
										</c:if>
										<!-- 正常结束 -->
										<c:if test="${result.backStatus==1 }">	
										   					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakedOK"/>	
										</c:if>
										<!-- 异常结束 -->
										<c:if test="${result.backStatus==2 }">
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakedError"/>
										</c:if>
				</td>	
				<td width="15%" align="center" class="t_border_l">&nbsp;
								
										<c:if test="${result.exeStatus==-1 }">
												<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusUnexe"/>
										</c:if>
										<!-- 正在执行状态 -->
										<c:if test="${result.exeStatus==0 }">				
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusExeing"/>
										</c:if>
										<!-- 正常结束 -->
										<c:if test="${result.exeStatus==1 }">	
										   					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exedOK"/>		
										</c:if>
										<!-- 异常结束 -->
										<c:if test="${result.exeStatus==2 }">
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exedError"/>
										</c:if>
				</td>	
				<td width="15%" align="center" class="t_border_l">&nbsp;
					${result.exeOperator}
				</td>	
				
				<td width="25%" align="center" class="t_border_r">&nbsp;
					<a href="#" onclick="javascript:document.location.href='showOperUnionGatewayPlan.do?taskId=${result.taskId}';">
						<bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag1"/>
					</a>	
					<a href="#" onclick="javascript:document.location.href='showModifyOperUnionGatewayPlan.do?taskId=${result.taskId}';">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.modifyName"/>
					</a>
					<a href="#" onclick="javascript:document.location.href='deleteUnionGatewayPlan.do?taskId=${result.taskId}';">
						<bean:message bundle="pageResources" key="page.common.delete"/>
					</a>
					<a href="#" onclick="javascript:document.location.href='sychronousUnionGatewayPlan.do?taskName=${result.taskName}';">
						<bean:message bundle="pageResources" key="page.worldOperation.sychronousUnionGatewayPlan"/>
					</a>
				</td>	
			
			</tr>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.unionGatewayPlanList}">
					<td colspan="9" align="center" class="t_border">					
						<bean:message bundle="pageResources" key="page.common.queryGotNoResults"/>	
					</td>
	</c:if>

			<tr height="30px">
				<td colspan="9" align="center" class="t_border">					
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.addNewPlan"/>"/>&nbsp;&nbsp; 
						
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
