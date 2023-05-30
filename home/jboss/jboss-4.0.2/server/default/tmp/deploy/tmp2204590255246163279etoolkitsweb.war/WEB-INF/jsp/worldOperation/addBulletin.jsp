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
				document.all.betweenTime.disabled  = true;
			}else{
				document.all.startTime.disabled = false;
				document.all.betweenTime.disabled  = false;
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
				
				if (!checkGateway()) {
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
				if ( document.forms[0].content.value.length > 2048){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.contentLength"/>');
					   document.forms[0].content.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
		//根据开始时间，结束时间，间隔时间计算发布次数
		function calculateTimes() {			
			var startTimeStr = document.all.startTime.value;
			var endTimeStr = document.all.endTime.value;
			var intervals = document.all.intervals.value;
			var startDate,endDate;			
			
			if (startTimeStr != null) {
				startDate = new Date(Date.parse(startTimeStr.replace(/-/g, "/")));
			} else {
				startDate = new Date();
			}
			if (endTimeStr != null) {
			    endDate = new Date(Date.parse(endTimeStr.replace(/-/g, "/")));
			} else {
				endDate = new Date();
			}  
			var times = Math.round((endDate-startDate)/1000/intervals);
			if (times > 1) {
				document.all.totalTimes.value = times;
			} else {
				document.all.totalTimes.value = 1;
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
		<form action="addBulletin.do" method="post" onsubmit="return check();">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr>
					<td align="center" height="30PX"></td>
				</tr>
				<tr>
					<td align="center" class="t_head" colspan="3">
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.title" />
					</td>
				</tr>
				<tr>
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.titleName" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<input name="title" type="text" value="${requestScope.title}"
							style="width: 230px" />
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.length256" />
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.gatewayID" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<gmweb:createGatewayCheckboxTag name="gatewayId"
							checkedValue="${requestScope.gatewayId}"
							gatewayList="${requestScope.gatewayList}" showAllGateway="1" />
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
				<tr>
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources" key="page.worldOperation.synchronizserver"/>
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<select name="sync">
							<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.butongbu"/></option>
							<option value="1"><bean:message bundle="pageResources" key="page.worldOperation.tongbu"/></option>		
						</select>
					</td>
				</tr>
				<input type="hidden" name="serverId" value="0" />
				<tr height="30px">
					<td colspan="3" class="t_border_r" align="center">
						<input type="radio" name="booking" value="0" checked="checked"
							onclick="disableInput();" />
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.booking0" />
						&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="radio" name="booking" value="1"
							onclick="disableInput();" />
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.booking1" />
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.bookingInfo" />
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.startTime" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<input name="startTime" type="text"
							onchange="javascript:calculateTimes();"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
							value="<fmt:formatDate value="${ requestScope.startTime}" pattern="yyyy-MM-dd HH:mm"/>" />
						<br />
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.timeLength" />
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.endTime" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<input name="endTime" type="text"
							onchange="javascript:calculateTimes();"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})"
							value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" />
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.totalTimes" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<input name="totalTimes" type="text"
							value="${requestScope.totalTimes }" />
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.addBulletin.intervals" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<select name="intervals" onchange="javascript:calculateTimes();">
							<option value="30">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue1" />
							</option>
							<option value="60">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue2" />
							</option>
							<option value="120">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue3" />
							</option>
							<option value="300" selected>
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue4" />
							</option>
							<option value="600">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue5" />
							</option>
							<option value="1200">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue6" />
							</option>
							<option value="1800">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue7" />
							</option>
							<option value="3600">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue8" />
							</option>
							<option value="7200">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue9"/>
							</option>
							<option value="10800">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue10"/>
							</option>
							<option value="14400">
							    <bean:message bundle="pageResources"
							        key="page.worldOperation.addBulletin.intervalsValue19"/>
							</option>
							<option value="21600">
								<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue11"/>
							</option>											
						</select>
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
						    key="page.worldOperation.issueBulletin.betweenServerTime"/>
					</td>
					<td class="t_border_l" align="left" colspan="2">
						<select name="betweenTime">
							<option value="0">
									<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervals"/>
							</option>
							<option value="60">
									<bean:message bundle="pageResources"
									    key="page.worldOperation.addBulletin.intervalsValue2" />
							</option>
							<option value="120">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue3"/>
							</option>
							<option value="180">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue12"/>
							</option>
							<option value="240">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue13"/>
							</option>
							<option value="300">
									<bean:message bundle="pageResources"
									key="page.worldOperation.addBulletin.intervalsValue4" />
							</option>
							<option value="360">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue14"/>
							</option>
							<option value="420">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue15"/>
							</option>
							<option value="480">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue16"/>
							</option>
							<option value="540">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue17"/>
							</option>
							<option value="600">
									<bean:message bundle="pageResources"
										key="page.worldOperation.addBulletin.intervalsValue18"/>
							</option>								
						</select>
					</td>
				</tr>
				<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.issueBulletin.bulletinContent" />
					</td>
					<td class="t_border_l" align="left">
						<textarea name="content" rows=8 cols=35 size="10240">${requestScope.content }</textarea>
					</td>
					<td class="t_border_r" align="center">
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.length1024" />
					</td>
				</tr>
				<tr height="30px">
					<td class="t_border_r" style="border-bottom: #AEAEB0 1px solid;"
						align="center" colspan="3">
						<input type="submit"
							value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>