<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		}
		function check(){
		if(getIsRestart()=='1'){
			if ( document.forms[0].activityName.value.trim() == "" || document.forms[0].activityName.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activeName"/>');
				  document.forms[0].activityName.focus();
				  return false;
			}
			if ( document.forms[0].activityKeyword.value.trim() == "" || document.forms[0].activityKeyword.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityKeyword"/>');
				  document.forms[0].activityKeyword.focus();
				  return false;
			}
		}
		if(getIsRestart()=='2'){
			if ( document.forms[0].activityName.value.trim() == "" || document.forms[0].activityName.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activeName"/>');
				  document.forms[0].activityName.focus();
				  return false;
			}
			if ( document.forms[0].activityKeyword.value.trim() == "" || document.forms[0].activityKeyword.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityKeyword"/>');
				  document.forms[0].activityKeyword.focus();
				  return false;
			}
			if ( document.forms[0].activiryID.value.trim() == "" || document.forms[0].activiryID.value.trim()  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
					document.forms[0].activiryID.focus();
					return false;
			}
			if ( document.forms[0].circle.value.trim() == "" || document.forms[0].circle.value.trim()  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.circle"/>');
					document.forms[0].circle.focus();
					return false;
			}
			if ( document.forms[0].startTime.value.trim() == "" || document.forms[0].startTime.value.trim()  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startTime"/>');
					document.forms[0].startTime.focus();
					return false;
			}
			if ( document.forms[0].endTime.value.trim() == "" || document.forms[0].endTime.value.trim()  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endTime"/>');
					document.forms[0].endTime.focus();
					return false;
			}
		}		
		else {
				  return true;
		}
		}
		function getIsRestart(){
		for(var i =0;i<document.forms[0].isRestart.length;i++)
     	{
      		if (document.forms[0].isRestart[i].checked== true )
     	 	{
       			return document.forms[0].isRestart[i].value;
      		}
    	}
		}
		
		function oneCheck1(){
			tr_activiryID.style.display = 'none';
			tr_circle.style.display = 'none';
			tr_startTime.style.display = 'none';
			tr_endTime.style.display = 'none';
			tr_activiryCmd.style.display = "";
			tr_isReservation.style.display = 'none';
		}
		function oneCheck2(){
			tr_activiryID.style.display = "";
			tr_circle.style.display = "";
			tr_startTime.style.display = "";
			tr_endTime.style.display = "";
			tr_activiryCmd.style.display = 'none';
			tr_isReservation.style.display = "";
		}
		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="operActivitySetting.do" method="post" onsubmit="return check();">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySetting.title"/>
				</td>
			</tr>
			<tr height="30px">
			<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.activeName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityName" type="text" value="${ActivitySetting.activityName}" style="width:200px" <c:if test="${oper=='modify'}">readonly</c:if>/>
				 </td>
			</tr>
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activityKeyword"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityKeyword" type="text" value="${ActivitySetting.activityKeyword}" style="width:200px" <c:if test="${oper=='modify'}">readonly</c:if>/>
				 </td>
			</tr>
			<c:if test="${oper!='modify'}">
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart"/>
				 </td>
				 <td class="t_border_r" align="left">
					<input type="radio" id="isRestart" name="isRestart" value="1" checked onclick="oneCheck1();"/><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart1"/>
					<input type="radio" id="isRestart" name="isRestart" value="2" onclick="oneCheck2();"/><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart2"/>
				 </td>
			</tr>
			</c:if>
			<c:if test="${ActivitySetting.isRestart!='1'}">
			<tr height="30px" id="tr_activiryID" <c:if test="${oper!='modify'}">style="display:none"</c:if>>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activiryID"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activiryID" type="text" value="${ActivitySetting.activiryNum}" style="width:200px" /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activiryNum"/>
				 </td>
			</tr>
			<tr height="30px" id="tr_circle" <c:if test="${oper!='modify'}">style="display:none"</c:if>>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.circleInfo"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="circle" type="text" value="${ActivitySetting.circle}" style="width:200px" /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.circle"/>
				 </td>
			</tr>
			<tr height="30px" id="tr_startTime" <c:if test="${oper!='modify'}">style="display:none"</c:if>>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${ActivitySetting.startTime}" style="width:200px" />
					<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px" id="tr_endTime" <c:if test="${oper!='modify'}">style="display:none"</c:if>>
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="${ActivitySetting.endTime}" style="width:200px" />
					<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px" id="tr_isReservation" <c:if test="${oper!='modify'}">style="display:none"</c:if>>
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isReservation"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="radio" name="isReservation" value="0" checked/><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart1"/>
				 	<input type="radio" name="isReservation" value="1" <c:if test="${ActivitySetting.isReservation=='1'}">checked</c:if>/><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart2"/>
				 </td>
			</tr>
			</c:if>
			<c:if test="${ActivitySetting.isRestart!='2'}">
			<tr height="30px" id="tr_activiryCmd">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activiryCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activiryCmd" type="text" value="${ActivitySetting.activiryCmd}" style="width:200px" />
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="activityID" value="${ActivitySetting.activityID}"/>
					<c:if test="${oper=='modify'}"><input type="hidden" name="isRestart" value="${ActivitySetting.isRestart}"/></c:if>
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	</form>

		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>