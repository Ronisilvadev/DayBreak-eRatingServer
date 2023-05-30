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
	
		function isValidId(strId) {
			if (strId == null) return false;
			var re=/^12\d{8}$/
			return re.test(strId);
		}
		function check(){
			if ( document.forms[0].activityId.value == "" || document.forms[0].activityId.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			if(document.forms[0].activityId.value.length <10 || document.forms[0].activityId.value.length >10){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityIdError"/>');
				  document.forms[0].activityId.focus();
				  return false;	
				}
			if ( document.forms[0].activityName.value == "" || document.forms[0].activityName.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityName"/>');
				  document.forms[0].activityName.focus();
				  return false;
			}
			
			if ( document.forms[0].beginTime.value == "" || document.forms[0].beginTime.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startTime"/>');
					document.forms[0].beginTime.focus();
					return false;
			}
			
			if ( document.forms[0].endTime.value == "" || document.forms[0].endTime.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endTime"/>');
					document.forms[0].endTime.focus();
					return false;
			}
			else {
				var frm = document.forms[0];
				
				var gatewaySelected = false;
				for (var i=0;i<frm.elements.length;i++) 
				{ 
				   
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && e.checked) 
					{
						gatewaySelected = true;
						break;
					} 
					
				} 
				if(!gatewaySelected){
					alert('<bean:message bundle="pageResources" key="page.roleOperation.common.gatewayID"/>');					
					return false;				
				}
				
				return true;
			}
		}
		function checkAll(frm)  
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
				   
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && document.getElementById("AllGateway").checked) 
					{
						 if(e.name=='gatewayId'){
							e.checked = true; 
						 }
						 document.getElementById("gatewayId").style.visibility ="hidden";
						
						 
					} 
					else if (e.type == 'checkbox'&& !document.getElementById("AllGateway").checked){
						if(e.name=='gatewayId'){
							e.checked = false; 
						 }
						document.getElementById("gatewayId").style.visibility = "visible";
					} 
				} 
			
				
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="addActivity.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.addActivity.title"/>
				</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text" value="${requestScope.activityId}" style="width:200px" /><br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityIdInfo"/>
				 </td>
			</tr>
			
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityName" type="text" value="${requestScope.activityName}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/> 
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.beginTime}" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>  
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
					<td width="25%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.worldOperation.common.gatewayID" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
					    <input type="checkbox" id="AllGateway" name="AllGateway" value="1" onclick="checkAll(document.forms[0]);"/><bean:message bundle="pageResources" key="page.common.allServer"/>  
					    <br/>
					    <span id="gatewayId" >
							
							<c:forEach items="${requestScope.gatewayList}" var="gateway" varStatus="status">
							<c:if test="${0==status.index%3 and status.index>0}">
								<br/>
							</c:if>
							<div style="width:170px;height:17px;overflow:hidden;float:left;" title="${gateway.gatewayId}-${gateway.gatewayName}"><input type="checkbox" id="AllGateway" name="gatewayId" value="${gateway.gatewayId}" />&nbsp;${gateway.gatewayId}-${gateway.gatewayName}</div>
							
							
							
						</c:forEach>
						</span>
					</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showIssueActivity.do'" />
				</td>
			</tr>
			
			
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>