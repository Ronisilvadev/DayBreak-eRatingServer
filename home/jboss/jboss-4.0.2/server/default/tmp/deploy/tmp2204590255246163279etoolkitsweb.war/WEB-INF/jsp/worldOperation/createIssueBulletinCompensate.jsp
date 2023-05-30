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
		
		function check(){
			
				if ( document.forms[0].title.value == "" || document.forms[0].title.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.title"/>');
					  document.forms[0].title.focus();
					  return false;
				}
				
				if ( document.forms[0].title.value.length > 256){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.titleLength"/>');
					  document.forms[0].title.focus();
					  return false;
				}
				
				if (tmpValue != '0'){
					if ( document.forms[0].startTime.value == "" || document.forms[0].startTime.value  == null){
						  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.time"/>');
						  return false;
					}
				}
				if ( document.forms[0].totalTimes.value == "" || document.forms[0].totalTimes.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.totalTimes"/>');
					   document.forms[0].totalTimes.focus();
					  return false;
				}
				if ( document.forms[0].intervals.value == "" || document.forms[0].intervals.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.intervals"/>');
					   document.forms[0].intervals.focus();
					  return false;
				}
				if ( document.forms[0].content.value == "" || document.forms[0].content.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.content"/>');
					   document.forms[0].content.focus();
					  return false;
				}
				if ( document.forms[0].content.value.length > 1024){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.contentLength"/>');
					   document.forms[0].content.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff" onload="disableInput();">
	<form action="saveIssueBulletinCompensate.do" method="post" onsubmit="return check();" >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.title"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.titleName"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="title" type="text" value="${IssueBulletinCompensate.title}" style="width:230px"/>
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.length256"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<gmweb:createGatewayOption name="gatewayId" checkedValue="${requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" showAllGateway="1" />
				 </td>
			</tr>
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
			<tr height="30px">
				<td colspan="3" class="t_border_r" align="center">
				<input type="radio" name="booking" value="0" <c:if test="${IssueBulletinCompensate.booking == 0 || IssueBulletinCompensate.booking == null}">checked</c:if> onclick="disableInput();" /><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking0"/>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="radio" name="booking" value="1" <c:if test="${IssueBulletinCompensate.booking == 1 }">checked</c:if> onclick="disableInput();" /><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking1"/>
					<bean:message bundle="pageResources" key="page.worldOperation.addBulletin.bookingInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${ IssueBulletinCompensate.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeLength"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.totalTimes"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="totalTimes" type="text" value="${IssueBulletinCompensate.totalTimes }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervals"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="intervals">
						<option value="30" <c:if test="${IssueBulletinCompensate.intervals == 30 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue1"/></option>
						<option value="60" <c:if test="${IssueBulletinCompensate.intervals == 60 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue2"/></option>
						<option value="120" <c:if test="${IssueBulletinCompensate.intervals == 120 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue3"/></option>
						<option value="300" <c:if test="${IssueBulletinCompensate.intervals == 300 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue4"/></option>
						<option value="600" <c:if test="${IssueBulletinCompensate.intervals == 600 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue5"/></option>
						<option value="1200" <c:if test="${IssueBulletinCompensate.intervals == 1200 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue6"/></option>
						<option value="1800" <c:if test="${IssueBulletinCompensate.intervals == 1800 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue7"/></option>
						<option value="3600" <c:if test="${IssueBulletinCompensate.intervals == 3600 }">selected</c:if>><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.intervalsValue8"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.bulletinContent"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="content" rows=8 cols=35 size="10240" >${IssueBulletinCompensate.content }</textarea>
				 </td>
				 <td class="t_border_r" align="center">
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.length1024"/> 
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr1"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	 <input type="checkbox" name="commitFlag" value="1" <c:if test="${requestScope.commitFlag == '1' }">checked</c:if> /><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="compensateId" type="hidden" value="${requestScope.IssueBulletinCompensate.bulletinId }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.submit"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"> </font>
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>