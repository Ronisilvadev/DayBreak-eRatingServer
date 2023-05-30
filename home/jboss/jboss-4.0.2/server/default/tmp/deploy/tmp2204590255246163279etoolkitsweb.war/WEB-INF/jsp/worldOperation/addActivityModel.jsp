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
		function displayRoleTime(){
			var actType = document.getElementById('activityType').value; 
			if(actType == 3){
				roleBeginTimeTr.style.display = "";
				roleEndTimeTr.style.display = "";
				gatewayIdTr.style.display = "";
			}else if(actType == 1){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 8){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 9){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 10){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 11){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 12){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 14){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 15){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 16){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 5){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 6){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else if(actType == 7){
				gatewayIdTr.style.display = "";
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
			}else{
				roleBeginTimeTr.style.display = 'none';
				roleEndTimeTr.style.display = 'none';
				gatewayIdTr.style.display = 'none';
			}
			if(actType!=1){
				isMutexTr.style.display = 'none';
				document.getElementById('isMutex').value = 0;
			}else{
					<c:if test="${requestScope.version=='old' }">
						isMutexTr.style.display = '';
					</c:if>
					<c:if test="${requestScope.version=='new' }">
						isMutexTr.style.display = 'none';
					</c:if>
				document.getElementById('isMutex').value = 1;
			}
			if (actType != 3) {
				document.getElementsByName('gatewayId').value = 0;
			}
			var tipControl = document.getElementById("tiptext") ;
			if(actType == 5){
				tipControl.innerText = '<bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.type5.tip"/>' ;
			}else if(actType == 6){
				tipControl.innerText = '<bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.type6.tip"/>' ;
			}else if(actType == 7){
				tipControl.innerText = '<bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.type7.tip"/>' ;
			}else{
				tipControl.innerText = '';
			}
		}
				
		function check(pram){
			//begin	验证活动名称长度
			var activityName=document.getElementById('activityName');
			if(activityName.value.length>32){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityName"/><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.activityNameTip"/>');
				return false;
			}
			//end
			
			var activityType=document.getElementById('activityType');
			if(activityType.value==3){
				var roleBeginTime=document.getElementById('roleBeginTime');
				var roleEndTime=document.getElementById('roleEndTime');
				if(roleBeginTime.value==""||roleEndTime.value==""){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.roleTimeMustbeNotnull"/>");
					return false;
				}
			}
			
		
			return validateAddActivityModelForm(pram);			
		}	
	</script>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>
	</div>

	<html:form action="addActivityModel.do" method="post" onsubmit="return check(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.title"/>				
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text"/>
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.activityIdTip"/></span>
				 </td>				 
			</tr>
			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityName" id="activityName" type="text" />
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.activityNameTip"/></span>
				 </td>				 
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select id="activityType" name="activityType" onchange="displayRoleTime()" style="width: 132px">
				 		<option value="1"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/></option>
				 		<option value="3"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/></option>
				 		<option value="5"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/></option>
				 		<option value="6"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/></option>
				 		<option value="7"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/></option>						
					 	<option value="9"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType9"/></option>
				 		<option value="10"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType10"/></option>
				 		<option value="11"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType11"/></option>
				 		<option value="12"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType12"/></option>
				 		<option value="14"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType14"/></option>
				 		<option value="15"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType15"/></option>
				 		<option value="16"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType16"/></option>	
				 	</select>&nbsp;&nbsp;<div style="display: inline;"><b><font id="tiptext" color="red"></font></b></div>
				 </td>
			</tr>
			<tr id="gatewayIdTr" height="30px" >
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				 <td class="t_border_r" align="left">
				 	<gmweb:createGatewayCheckboxActivityTag name="gatewayId"
							checkedValue="0"
							gatewayList="${requestScope.gatewayList}" showAllGateway="1" /><br/>
					<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.gatewayIdTip"/></span>
				 </td>
			</tr>			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.beginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.endTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="giftBeginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.giftBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.giftEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="giftEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr id="roleBeginTimeTr" height="30px" style="display:none">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleBeginTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleBeginTime" id="roleBeginTime" readonly type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.roleTimeMustbeNotnull"/></span>
				 </td>
			</tr>
			<tr id="roleEndTimeTr" height="30px" style="display:none">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.roleEndTime"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleEndTime" id="roleEndTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.addActivityModel.roleTimeMustbeNotnull"/></span>
				 </td>
			</tr>
			
			<tr id="isMutexTr" height="30px" style="<c:if test="${requestScope.version=='new' }">display:none</c:if>">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutex"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select id="isMutex" name="isMutex">
				 		<option value="1"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType1"/></option>
				 		<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType0"/></option>
				 	</select>
				 </td>
			</tr>

			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" colspan="2">
					<input name="version" type="hidden" value="${requestScope.version}" />&nbsp;&nbsp;
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " style="margin-left: 34%"/>&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityModel.do?version=${requestScope.version}'"/>
				</td>
			</tr>
		</table>
		</html:form>

	</body>
</html>