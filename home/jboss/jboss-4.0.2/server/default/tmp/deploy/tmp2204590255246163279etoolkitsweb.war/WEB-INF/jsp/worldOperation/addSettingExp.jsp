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
		var tmpValue;
		function disableInput(){
			 for(var i=0;i < document.forms[0].booking.length;i++)   
				  {   
				  	if(document.forms[0].booking[i].checked)   
				  {   
				  	tmpValue = document.forms[0].booking[i].value   
				  	break   
				  }   
			}
		
			if (tmpValue == '0'){
				document.all.startTime.disabled = true;
			}else{
				document.all.startTime.disabled = false;
			}
		}
		
		function isDouble(strInt) {
			if (strInt == null) return false;
			var re = /^\d+((\.?\d{1,2})|(\d{0,1}))$/;
			return re.test(strInt);
		}		
		
		function check(){
				
				if (!checkGateway()) {
					return false;
				}
				
				if ( document.forms[0].expRate.value == "" || document.forms[0].expRate.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.expRate"/>');
					  document.forms[0].expRate.focus();
					  return false;
				}
				
				if (!isDouble(document.forms[0].expRate.value) || document.forms[0].expRate.value > 999 || document.forms[0].expRate.value <= 0){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.expRate"/>');
					  document.forms[0].expRate.focus();
					  return false;
				}				
				
				if (tmpValue != '0'){
					if ( document.forms[0].startTime.value == "" || document.forms[0].startTime.value  == null){
						  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startTime"/>');
						  return false;
					}
				}
				if ( document.forms[0].endTime.value == "" || document.forms[0].endTime.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endTime"/>');
					   document.forms[0].endTime.focus();
					  return false;
				}
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.reason"/>');
					   document.forms[0].reason.focus();
					  return false;
				}
				if ( document.forms[0].reason.value.length > 1024){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.reasonLength"/>');
					   document.forms[0].reason.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
			
		//检查网关，至少选择一个网关
		function checkGateway(){
			var gateway = document.getElementsByName("gatewayId");
			var flag = false;
			for (var i=0; i<gateway.length; i++){
		  		if(gateway[i].checked){
		  			flag = true;
		  		}		  	
		  	}	
		  	if(!flag){
		  		alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
				return false; 
		  	} else {
		  		return true;
		  	}
		}
	</script>
</head>


<body bgcolor="#ffffff" onload="disableInput();">
	<form action="addSettingExp.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.addSettingExp.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<gmweb:createGatewayCheckboxTag name="gatewayId" checkedValue="${ requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" showAllGateway="1" />
				 </td>
			</tr>
			<!-- 
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.serverID"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					 <select name="serverId" style="width:150px">
						</select>
						<script language="JavaScript">
							sel = new ESelect();
							sel.setElement(document.all.serverId);
							<c:forEach items="${requestScope.gatewayList}" var="gateway">
								sel.add('${gateway.gatewayId }', '0', '0-<bean:message bundle="pageResources" key="page.worldOperation.common.allServer"/>');	
				  			</c:forEach>
							<c:forEach items="${requestScope.serverList}" var="server">
								sel.add('${server.gatewayId }', '${server.serverId }', '${server.serverId }-${server.serverName }');	
							</c:forEach>
							document.all.gatewayId.onchange = function()
							{
								sel.set(this.value);
							}
							sel.set(document.all.gatewayId.value);
							var s = document.forms[0].serverId;
							for   (i=0; i < s.length;i++)   
							{   
							  	if   (s[i].value == '${requestScope.serverId}')   
							  {   
								 s[i].selected = true;
							  }   
						 	}   
						</script>
				 </td>
			</tr>
			 -->
			 <input type="hidden" name="serverId" value="0"/>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSettingExp.expType"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="expType">
				  		<c:forEach items="${requestScope.experienceTypeList}" var="experienceType">
				  			<option value="${experienceType.code }" <c:if test="${ requestScope.expType == experienceType.code}">selected</c:if>>${experienceType.name}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSettingExp.expRate"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="expRate" type="text" value="${ requestScope.expRate}" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.tip.expRate"/>
				 </td>
			</tr>
			<tr height="30px">
				<td colspan="3" class="t_border_r" align="center">
				<input type="radio" name="booking" value="0" checked="checked" onclick="disableInput();" /><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking0"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="booking" value="1" onclick="disableInput();" /><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking1"/>
					<bean:message bundle="pageResources" key="page.worldOperation.addBulletin.bookingInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>  
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<fmt:formatDate value="${ requestScope.startTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeLength"/> 
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 	<br />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSettingExp.reason"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="reason" rows=8 cols=35 size="10240" >${requestScope.content }</textarea>
				 </td>
				 <td class="t_border_r" align="center">
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.length1024"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>