<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		}
		function check(){
			if ( document.forms[0].activeName.value.trim() == "" || document.forms[0].activeName.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activeName"/>');
					  document.forms[0].activeName.focus();
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
				
			if ( document.forms[0].startCmd.value.trim() == "" || document.forms[0].startCmd.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startCmd"/>');
						document.forms[0].startCmd.focus();
						return false;
			}
			if ( document.forms[0].endCmd.value.trim() == "" || document.forms[0].endCmd.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endCmd"/>');
						document.forms[0].endCmd.focus();
						return false;
			}
			if ( document.forms[0].circleday.value.trim() == "" || document.forms[0].circleday.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.circleday"/>');
						document.forms[0].circleday.focus();
						return false;
			}	
			else {
					  return true;
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
<c:if test="${opFlag =='add' }">
	<form action="addActivityInfo.do" method="post" onsubmit="return check();">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.title1"/>
				</td>
			</tr>
			<tr height="30px">
			<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.activeName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activeName" type="text"  style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.startCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startCmd" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.endCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endCmd" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.circleday"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="circleday" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	</form>
	
</c:if>
<c:if test="${opFlag =='synchronization' }">
	<form action="synchronizationActivityInfo.do" method="post" >
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.title2"/>
				</td>
			</tr>
			<tr>
				<td class="t_border_l" align="right" width="50%" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.activeName"/>
					<select name="activityId">
						<c:forEach items="${requestScope.activityInfo}" var="activityInfo">
						<option value="${activityInfo.activeID }">${activityInfo.activeName}</option>
						</c:forEach>
					</select> 
				 </td>
				 <td class="t_border_r" align="left"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.gatewayList"/>
				 </td>
			</tr>
			<c:forEach items="${requestScope.gatewayList}" var="gateway">
			<tr>
				<td class="t_border_l" align="right" width="50%" >&nbsp;</td>
				 <td class="t_border_r" align="left">
					<input type="checkbox" name="gatewayIds" value="${gateway.gatewayId }" />${gateway.gatewayName}<br>
				</td>
			</tr>
			</c:forEach>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	</form>
</c:if>
<c:if test="${opFlag =='plan' }">
	<form action="planActivityInfo.do" method="post" >
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.title3"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left" >
				 	<select name="gatewayId" style="width:200px">
				 		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.today"/></td>
				 <td class="t_border_r" align="left">
				 	<select name="today" style="width:200px">
				  		<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.todayValue1"/></option>
				  		<option value="1"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.todayValue2"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	</form>
</c:if>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>