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
	</script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.curActivity }">
	<form action="queryCurActivity.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="10"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="10"><bean:message bundle="pageResources" key="page.worldOperation.curActivity.title1"/> </td>
			</tr>
			
			<tr height="30px">
				<td class="t_border_l" align="right" colspan="5"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left" colspan="5">
				 	<select name="gatewayId" style="width:200px">
				 		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td align="center" colspan="10" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	<c:if test="${not empty requestScope.curActivity }">
	<form action="delActivityInfo.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="10"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="10"><bean:message bundle="pageResources" key="page.worldOperation.curActivity.title2"/> </td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<input type="checkbox" onclick="sel('activeIDs');delButton.disabled=!this.checked" />
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
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.startCmd"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.endCmd"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.circleday"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.curActivity.enable"/>
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.curActivity}" var="activityInfo" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					<input type="checkbox" name="activeIDs" value="${activityInfo.activeID}"  onclick="delButton.disabled=!this.checked" />
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.activeID}
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.activeName}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activityInfo.startTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activityInfo.endTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.startCmd}
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.endCmd}
				</td>
				<td align="center" class="t_border_l">
					${activityInfo.circleday}
				</td>
				<td align="center" class="t_border_l">
					<c:if test="${activityInfo.enable==1}"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.todayValue2"/></c:if> 
					<c:if test="${activityInfo.enable==0}"><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.todayValue1"/></c:if> 
				</td>
				<td align="center" class="t_border_r">
					<a href="showOpActivityInfo.do?opFlag=modify&modifyContent=time&activeID=${activityInfo.activeID}&gatewayId=${gatewayId }&startTime=<fmt:formatDate value="${activityInfo.startTime}" pattern="yyyy-MM-dd HH:mm:ss" />&endTime=<fmt:formatDate value="${activityInfo.endTime}" pattern="yyyy-MM-dd HH:mm:ss" />"><bean:message bundle="pageResources" key="page.worldOperation.curActivity.modifyTime"/></a> 
					<a href="showOpActivityInfo.do?opFlag=modify&modifyContent=circleday&activeID=${activityInfo.activeID}&circleday=${activityInfo.circleday}&gatewayId=${gatewayId }"><bean:message bundle="pageResources" key="page.worldOperation.curActivity.modigyCircleday"/></a>
					<c:if test="${activityInfo.enable == '0'}"><a href="enableActivity.do?state=temp&activeID=${activityInfo.activeID}&enable=1&gatewayId=${gatewayId }"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.tmpStart"/></a></c:if>
					<c:if test="${activityInfo.enable == '1'}"><a href="enableActivity.do?state=temp&activeID=${activityInfo.activeID}&enable=0&gatewayId=${gatewayId }"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.tmpStop"/></a></c:if>
					<a href="enableActivity.do?opFlag=start&activeID=${activityInfo.activeID}&gatewayId=${gatewayId }"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.start"/></a> 
					<a href="enableActivity.do?opFlag=stop&activeID=${activityInfo.activeID}&gatewayId=${gatewayId }"><bean:message bundle="pageResources" key="page.worldOperation.activityPlanInfo.stop"/></a> 
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td colspan="10" class="t_border">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.curActivity.add"/>" onclick="window.location.href='showOpActivityInfo.do?opFlag=add'"/>
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="submit" id="delButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.del"/>" disabled />
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