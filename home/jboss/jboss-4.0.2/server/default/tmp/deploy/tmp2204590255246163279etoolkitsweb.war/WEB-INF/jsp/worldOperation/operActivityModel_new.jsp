<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	
	<html:javascript formName="/updateActivityModel"/>
	<script type="text/javascript">
		
	</script>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>			
	</div>
	<html:form action="updateActivityModel.do" method="post" onsubmit="return validateUpdateActivityModelForm(this);" >
		
		<input type="hidden" name="version" value="new" />	
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.activityModel"/> </td>
			</tr>
			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 ${serial.activityId}
				 <input name="activityId" type="hidden" value="${serial.activityId}"/>
				 <input name="activityType" type="hidden" value="${serial.activityType}"/>
				 	&nbsp;
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityName" type="text"  value="${serial.activityName}"/>&nbsp
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.activityNameTip"/></span>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	 <input name="activityType" type="hidden" value="${serial.activityType}"/>
				 	<c:if test="${serial.activityType eq 1}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/>
					</c:if >
					<c:if test="${serial.activityType eq 3}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/>
					</c:if >
					<c:if test="${serial.activityType eq 5}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/>
					</c:if >
					<c:if test="${serial.activityType eq 6}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/>
					</c:if >
					<c:if test="${serial.activityType eq 7}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/>
					</c:if >
					<c:if test="${serial.activityType eq 8}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType8"/>
					</c:if >	
					<c:if test="${serial.activityType eq 9}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType9"/>
					</c:if >
					<c:if test="${serial.activityType eq 10}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType10"/>
					</c:if >
					<c:if test="${serial.activityType eq 11}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType11"/>
					</c:if >
					<c:if test="${serial.activityType eq 12}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType12"/>
					</c:if >
					<c:if test="${serial.activityType eq 14}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType14"/>
					</c:if >
					<c:if test="${serial.activityType eq 15}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType15"/>
					</c:if >
					<c:if test="${serial.activityType eq 16}">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType16"/>
					</c:if >			 	
				 </td>
			</tr>
			<c:if test="${serial.activityType eq 3}">
			<tr id="gatewayIdTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:updateGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" sourceGatewayList="${requestScope.sourceGatewayList}" showAllGateway="1" />
				 </td>
			</tr>
			</c:if >
			<c:if test="${serial.activityType eq 1}">
			<tr id="gatewayIdTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:updateGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" sourceGatewayList="${requestScope.sourceGatewayList}" showAllGateway="1" />
				 </td>
			</tr>	
			</c:if>
			<c:if test="${serial.activityType eq 8}">
			<tr id="gatewayIdTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:updateGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" sourceGatewayList="${requestScope.sourceGatewayList}" showAllGateway="1" />
				 </td>
			</tr>	
			</c:if>
			<c:if test="${serial.activityType eq 9}">
			<tr id="gatewayIdTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:updateGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" sourceGatewayList="${requestScope.sourceGatewayList}" showAllGateway="1" />
				 </td>
			</tr>	
			</c:if>		
			<c:if test="${serial.activityType eq 5}">
				<input type="hidden" name="gatewayId" value="0"/>
			</c:if>
			<c:if test="${serial.activityType eq 6}">
				<input type="hidden" name="gatewayId" value="0"/>
			</c:if>
			<c:if test="${serial.activityType eq 7}">
				<input type="hidden" name="gatewayId" value="0"/>
			</c:if>
						
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.beginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.endTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="giftBeginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.giftBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="giftEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.giftEndTimeD }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<c:if test="${serial.activityType eq 3}">
			<tr id="roleBeginTimeTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleBeginTime" readonly type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.roleBeginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>

				 </td>
			</tr>
			
			<tr id="roleEndTimeTr" height="30px" >
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.roleEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>

				 </td>
			</tr>
			</c:if>
			<tr height="30px" >
				<td class="t_border_l" align="right">					
					<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/>
				</td>
				 <td class="t_border_r" align="left">
					 <c:if test="${serial.state eq 0}">
					 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskUnbegin"/>
					 </c:if>
					 <c:if test="${serial.state eq 1}">
					 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskbegin"/>
					 </c:if>
					 <c:if test="${serial.state eq 2}">
					 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskend"/>
					 </c:if>					 	
				 </td>
			</tr>

			<c:if test="${serial.state eq 1}">
				<tr height="30px">
			 		<td class="t_border" colspan="2" align="center">
			 			<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.beginTips"/></span>
			 		</td>
			 	</tr>
			 </c:if>
			 <c:if test="${serial.state eq 2}">	
			 	<tr height="30px">
			 		<td class="t_border" colspan="2" align="center">			 	
			 			<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.endTips"/></span>		
			 		</td>
			 	</tr>		 	
			 </c:if>	

						
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.activityModel.submitUpdate"/>" 
					 <c:if test="${serial.state eq 1}">
					 	disabled="disabled"
					 </c:if>
					 />&nbsp;
					 				 
					 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityModel.do?version=new'"/>
					 <c:if test="${0 == serial.state }">
							 <input type="button" value=" <bean:message bundle="pageResources" key="page.common.del"/> " onclick="if(confirm('<bean:message bundle="pageResources" key="page.purview.common.confirmDel"/>'))window.location.href='delActivityModel.do?activityId=${serial.activityId}&oper=1&version=new'"/>
					 </c:if>							
					
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">				
					
					 <c:if test="${0 == serial.state  or 2 == serial.state  }">
						 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.start"/> " onclick="window.location.href='operActivity.do?activityId=${serial.activityId}&oper=1&version=new'"/>
					 </c:if>
					 <c:if test="${1 == serial.state }">
					 	<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.stop"/> " onclick="window.location.href='operActivity.do?activityId=${serial.activityId}&oper=2&version=new'"/>
					 </c:if>
					 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.serialCode.setPkg"/> "
					 	<c:if test="${serial.state eq 1}">
					 		disabled="disabled"
					 	</c:if> 
					 	onclick="window.location.href='showSetPackage.do?activityId=${serial.activityId}&activityType=${serial.activityType}&version=new'"/>
											
					<c:if test="${serial.activityType eq 1 }">					
						<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityModel.configMute"/>" onclick="window.location.href='showMute1ActivityModel.do?activityId=${serial.activityId}&version=new'"/>
					</c:if>
					
				</td>
			</tr>
		</table>
	</html:form>
</body>
</html>