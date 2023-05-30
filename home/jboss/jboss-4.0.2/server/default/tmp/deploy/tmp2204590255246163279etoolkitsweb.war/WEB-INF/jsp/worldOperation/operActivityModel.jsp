<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/addActivityModel"/>
	<script type="text/javascript">
		
	</script>
</head>


<body bgcolor="#ffffff">
	<html:form action="updateActivityModel.do" method="post" onsubmit="return validateUpdateActivityModelForm(this);" >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
				<input type="hidden" name=version value="${requestScope.version }" />
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
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityName"/>：
				 </td>
				 <td class="t_border_r" align="left">${serial.activityName}
				 <!--	<input name="activityName" type="text"  value="${serial.activityName}"/>-->
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType"/>：
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
					
				 	
				 </td>
			</tr>
			<c:if test="${serial.activityType eq 3}">
			<tr id="gatewayIdTr" height="30px" >
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:updateGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" sourceGatewayList="${requestScope.sourceGatewayList}" showAllGateway="1" />
				 </td>
			</tr>
			</c:if >			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.beginTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="beginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>-->
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.endTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="endTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>-->
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.giftBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="giftBeginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.giftBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>-->
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.giftEndTimeD }" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="giftEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.giftEndTimeD }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>-->
				 </td>
			</tr>
			<c:if test="${serial.activityType eq 3}">
			<tr id="roleBeginTimeTr" height="30px" >
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.roleBeginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="roleBeginTime" readonly type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.roleBeginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>-->

				 </td>
			</tr>
			
			<tr id="roleEndTimeTr" height="30px" >
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left"><fmt:formatDate value="${serial.roleEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				 <!--	<input name="roleEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${serial.roleEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 -->
				 </td>
			</tr>
			</c:if>
			<tr height="30px" >
				<td width="35%" class="t_border_l" align="right">					
					<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/>:
				</td>
				 <td class="t_border_r" align="left">&nbsp;
				 <c:if test="${serial.state eq 0}">
				 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskUnbegin"/>
				 </c:if>
				 <c:if test="${serial.state eq 1}">
				 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskbegin"/>
				 	<br/>
				 	<font color="red" >
				 	<!--  	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.beginTips"/>-->
				 	</font>
				 </c:if>
				 <c:if test="${serial.state eq 2}"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.taskend"/>
				 	
				 	<font color="red">
				 	<!--<bean:message bundle="pageResources" key="page.worldOperation.activityModel.endTips"/>-->
				 	</font>
				 </c:if>				 
				 	
				 </td>
			</tr>
			
			
			
			
			
				<tr  height="30px" >
				<td  class="t_border_r" align="center" colspan="2">&nbsp;
				
				 </td>
				 
			</tr>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<!--
						<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.activityModel.submitUpdate"/>" 
						 <c:if test="${serial.state eq 1}">
					 	disabled
					 </c:if>
						 />&nbsp;&nbsp;
					-->	
					 <!--<input type="reset" value="<bean:message bundle="pageResources" key="page.common.getBack"/>" />-->	&nbsp;&nbsp;
					 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityModel.do?version=${requestScope.version}'"/>
				 <c:if test="${0 == serial.state    }">
						 <input type="button" value=" <bean:message bundle="pageResources" key="page.common.del"/> " onclick="if(confirm('<bean:message bundle="pageResources" key="page.purview.common.confirmDel"/>'))window.location.href='delActivityModel.do?activityId=${serial.activityId}&oper=1&version=${requestScope.version}'"/>
				 </c:if>	
						
					
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
				
					
					 <!--<c:if test="${0 == serial.state  or 2 == serial.state  }"> </c:if> -->
					 <c:if test="${0 == serial.state }">
						 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.start"/> " onclick="if(confirm('<bean:message bundle="pageResources" key="page.worldOperation.activityModel.beginTaskTips"/>'))window.location.href='operActivity.do?activityId=${serial.activityId}&oper=1&version=${requestScope.version}'"/>
					 </c:if>
					 <c:if test="${1 == serial.state }">
					 	<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.stop"/> " onclick="if(confirm('<bean:message bundle="pageResources" key="page.worldOperation.activityModel.endTaskTips"/>'))window.location.href='operActivity.do?activityId=${serial.activityId}&oper=2&version=${requestScope.version}'"/>
					 </c:if>
					 <input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.serialCode.setPkg"/> " onclick="window.location.href='showSetPackage.do?activityId=${serial.activityId}&activityType=${serial.activityType}&version=${requestScope.version}'"/>
					 
					<!--	
					<c:if test="${serial.activityType eq 1 }">					
						<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityModel.configMute"/>" onclick="window.location.href='showMute1ActivityModel.do?activityId=${serial.activityId}'"/>
					</c:if>
					-->
					
				</td>
			</tr>
		</table>
		</html:form>
		<!--  
		<div align="center" width="90%">
			
			<b>提交修改、配置礼品、配置互斥都需要先关闭活动，重新开启时需要重设活动结束时间</b>
			
			
			
		</div>
		-->
		<div align="center">
			
			
			<br />
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
			
			
		</div>

	</body>
</html>