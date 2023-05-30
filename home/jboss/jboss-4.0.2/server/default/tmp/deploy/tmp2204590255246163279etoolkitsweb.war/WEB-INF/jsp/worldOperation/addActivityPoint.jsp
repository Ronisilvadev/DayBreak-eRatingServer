<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
		<script type="text/javascript" src="js/func.js"></script>
		<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		window.onload = function () {
			var checkBox = document.getElementsByName('chargeChannelId');
			if(document.forms[0].activityType.value == '2'){
					for (var i = 0;i < checkBox.length;i++){
						checkBox[i].disabled = true;
					} 
					document.getElementById("startTime").style.display = "block";
					document.getElementById("endTime").style.display = "block";
			}
		}
		function check(){
			
				var len = document.forms[0].chargeChannelId.length; 
		        var checked = false; 
		
		        for (i = 0; i < len; i++) 
		        { 
		            if (document.forms[0].chargeChannelId[i].checked == true) 
		            { 
		                checked = true; 
		                break; 
		            } 
		        } 
		        
		        if (document.forms[0].activityType.value !="2" & !checked) 
		        { 
		            alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityType"/>'); 
		            return false; 
		        } 

				
				if ( document.forms[0].pointQuotiety.value == "" || document.forms[0].pointQuotiety.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.pointQuotiety"/>');
					  document.forms[0].pointQuotiety.focus();
					  return false;
				}
				
				if ( document.forms[0].config.value == "" || document.forms[0].config.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.config2"/>');
						document.forms[0].config.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
			function changeActivityType(val){
				var checkBox = document.getElementsByName('chargeChannelId');
				if(val == '2'){
					
					for (var i = 0;i < checkBox.length;i++){
						checkBox[i].disabled = true;
					} 
					document.getElementById("startTime").style.display = "block";
					document.getElementById("endTime").style.display = "block";
				}else{
					for (var i = 0;i < checkBox.length;i++){
						checkBox[i].disabled = false;
					} 
					document.getElementById("startTime").style.display = "none";
					document.getElementById("endTime").style.display = "none";
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="validateActivityPoint.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
 
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.title"/></td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/> </td>
				 <td class="t_border_r" align="left">
					 ${requestScope.activityId}
					 <input type="hidden" name="activityId" value="${ requestScope.activityId}" />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/></td>
				<td class="t_border_r" align="left">
					 ${requestScope.activityName}
					 <input type="hidden" name="activityName" value="${ requestScope.activityName}" />
				</td>
			</tr>
			<c:if test="${gameId>700 && gameId!=706 && gameId!=710 && gameId!=734 && gameId!=749 && gameId !=769 && gameId !=774 && gameId !=786}">
			<tr style="display:none">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeChannelId"/></td>
				<td class="t_border_r" align="left">
					<gmweb:createChannelIdCheckBox name="chargeChannelId" checkedValue="10" />
				</td>
			</tr>
			</c:if>
			<c:if test="${gameId<=700 || gameId==706 || gameId==710 || gameId==734 || gameId==749 || gameId ==769 || gameId ==774 || gameId ==786}">
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeChannelId"/></td>
				<td class="t_border_r" align="left">
					<gmweb:createChannelIdCheckBox name="chargeChannelId" checkedValue="0" />
				</td>
			</tr>
			</c:if>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectId"/></td>
				<td class="t_border_r" align="left">
					<select name="chargeSubjectId" style="width:125px">
						<option value='3' selected>3-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdGold"/></option>
						<option value='4'>4-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdSiv"/></option>
						<option value='5'>5-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdYuanbao"/></option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/></td>
				<td class="t_border_r" align="left">
					<select name="activityType" style="width:125px" onchange="changeActivityType(this.value);">
						<option value="1" selected>1-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.pointActivity"/></option>
					 	<option value="2">2-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.Accumulative"/></option>
					</select>
					
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.pointType"/></td>
				<td class="t_border_r" align="left">
					<input name="pointType" type="text" value="1" style="width:125px" />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.pointQuotiety"/></td>
				<td class="t_border_r" align="left">
					<input type="text" name="pointQuotiety" value="${ requestScope.pointQuotiety}" /><br />
				</td>
			</tr>
			<tr id="startTime" style="display:none;">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/></td>
				<td class="t_border_r" align="left">
						<input name="startDate" type="text" readonly="readonly"
							onchange="javascript:calculateTimes();"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							value="<fmt:formatDate value="${ requestScope.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
						<br />
				</td>
			</tr>
			<tr id="endTime" style="display:none;">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/></td>
				<td class="t_border_r" align="left">
						<input name="endDate" type="text" readonly="readonly"
							onchange="javascript:calculateTimes();"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
							value="<fmt:formatDate value="${ requestScope.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />&nbsp;<span style="color: red;">
							<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.betweenStartDatetoEndDate"/></span>
							
						<br />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.config"/></td>
				<td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.configInfo1"/><br />
					<textarea name="config" rows=10 cols=35 size="10240" ></textarea><br />
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.configInfo2"/><br />
					50,100,1<br />
					100,200,2<br />
					200,-,4）
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityDetail.do?action=showIssueActivity&activityId=${requestScope.activityId}'"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>