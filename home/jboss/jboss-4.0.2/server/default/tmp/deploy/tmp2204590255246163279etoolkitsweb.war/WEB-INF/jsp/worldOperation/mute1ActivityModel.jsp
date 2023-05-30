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
	<form action="mute1ActivityModel.do" method="post"  >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>				
				 <input name="activityId" type="hidden" value="${serial.activityId}"/>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.setMute"/></td>
				
			</tr>
			
			<tr  height="30px" >
				<td width="50%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.activityModel.muteTips"/>&nbsp;&nbsp;
				 </td>
				 <td class="t_border_r" align="left">
				 	<select id="isMutex" name="isMutex">
				 		<option value="1"
				 		 <c:if test="${typeMute eq 1}">
				 			selected
				 		 </c:if>
				 		><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType1"/></option>
				 		<option value="0"
				 		 <c:if test="${typeMute eq 0}">
				 			selected
				 		 </c:if>
				 		 ><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType0"/></option>
				 	</select>
				 	<bean:message bundle="pageResources" key="page.worldOperation.activityModel.operMuteTips"/>
				 	 <c:if test="${typeMute eq 1}">
				 			<font color="red">(
				 			<bean:message bundle="pageResources" key="page.worldOperation.activityModel.current"/><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType1"/>
				 			)</font>
				 		 </c:if>
				 	 <c:if test="${typeMute eq 0}">
				 			<font color="red">(
				 			<bean:message bundle="pageResources" key="page.worldOperation.activityModel.current"/><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.isMutexType0"/>
				 			)</font>
				 		 </c:if>
				 </td>
			</tr>
			
			
			
			
			
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>" 
					
					 />&nbsp;&nbsp;
					
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityModel.setActivityMute"/>" onclick="window.location.href='showMute2ActivityModel.do?activityId=${serial.activityId}'"/>
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showOperActivityModel.do?activityId=${serial.activityId}&version=new'"/>
						
					
					
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
			
			
		</div>

	</body>
</html>