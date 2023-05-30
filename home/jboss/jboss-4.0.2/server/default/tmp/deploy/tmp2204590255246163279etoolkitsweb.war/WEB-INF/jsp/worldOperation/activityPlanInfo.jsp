<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script language="javascript">
 	function sel(a){ 
 		o=document.getElementsByName(a) 
  		for(i=0;i<o.length;i++) 
  		o[i].checked=event.srcElement.checked 
 	}
 	function op(type){
 		if(type=='tmpStart'){
 			document.forms[0].action = 'opActivityInfoServer.do?opType=tmpStart';
 		}
 		if(type=='tmpStop'){
 			document.forms[0].action = 'opActivityInfoServer.do?opType=tmpStop';
 		}
 		if(type=='del'){
 			document.forms[0].action = 'opActivityInfoServer.do?opType=del';
 		}
 		if(type=='start'){
 			document.forms[0].action = 'opActivityInfoServer.do?opType=start';
 		}
 		if(type=='stop'){
 			document.forms[0].action = 'opActivityInfoServer.do?opType=stop';
 		}
 		document.forms[0].submit();
 	}
	</script>
</head>

<body bgcolor="#ffffff">
	<form method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="6"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="6"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.title"/> </td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<input type="checkbox" onclick="sel('activeIDs');tmpStartButton.disabled=!this.checked;tmpStopButton.disabled=!this.checked;delButton.disabled=!this.checked;startButton.disabled=!this.checked;stopButton.disabled=!this.checked;" />
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.activeID"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.activeName"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.startTime"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.endTime"/>
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.enable"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.activityInfo}" var="activityInfo" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					<input type="checkbox" name="activeIDs" value="${activityInfo.activeID}"  onclick="tmpStartButton.disabled=!this.checked;tmpStopButton.disabled=!this.checked;delButton.disabled=!this.checked;startButton.disabled=!this.checked;stopButton.disabled=!this.checked;" />
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.activeID}
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.activeName}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activityInfo.startTime}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activityInfo.endTime}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="center" class="t_border_r">
					<c:if test="${activityInfo.enable == '1'}"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.enable1"/></c:if>
					<c:if test="${activityInfo.enable == '0'}"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.enable2"/></c:if>
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td colspan="6" class="t_border">
					<input type="hidden" value="${gatewayId }" name="gatewayId"/>
					<input type="hidden" value="${today }" name="today"/>
					<input type="button" id="tmpStartButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.tmpStart"/>" onclick="op('tmpStart')" disabled/>
					<input type="button" id="tmpStopButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.tmpStop"/>" onclick="op('tmpStop')" disabled/>
					<input type="button" id="delButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.del"/>" onclick="op('del')" disabled/>
					<input type="button" id="startButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.start"/>" onclick="op('start')" disabled/>
					<input type="button" id="stopButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.stop"/>" onclick="op('stop')" disabled/>
				</td>
			</tr>
		</table>
	</form>

		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>