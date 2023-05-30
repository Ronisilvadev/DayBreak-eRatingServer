<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
</head>

<body bgcolor="#ffffff">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="6"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="6"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.title"/> </td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.common.index"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.activeName"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.activeKeyword"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.activeCmd"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.oper"/>
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.setting"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.activitySettingList}" var="activitySetting" varStatus="status">
			<tr height="23px">
				<td align="center" class="t_border_l">
					${status.index + 1 }
				</td>
				<td align="center" class="t_border_l">
					${activitySetting.activityName}
				</td>
				<td align="center" class="t_border_l">
					${activitySetting.activityKeyword}
				</td>
				<td align="center" class="t_border_l">
				<c:if test="${activitySetting.isRestart=='1'}">${activitySetting.activiryCmd}</c:if>
				<c:if test="${activitySetting.isRestart=='2'}">${activitySetting.activiryNum},${activitySetting.circle},${activitySetting.startTime},${activitySetting.endTime}</c:if>&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<a href="showOperActivitySetting.do?activityID=${activitySetting.activityID}&oper=modify"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/></a>&nbsp;&nbsp;
					<a href="showOperActivitySetting.do?activityID=${activitySetting.activityID}&oper=del"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.del"/></a>
				</td>
				<td align="center" class="t_border_r">
				<c:if test="${activitySetting.isRestart=='1'}">
					<a href="showSetActivitySetting.do?name=${activitySetting.activityKeyword}&op=open&param=${activitySetting.activiryCmd}"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.start"/></a>&nbsp;&nbsp;
					<a href="showSetActivitySetting.do?name=${activitySetting.activityKeyword}&op=close&param=${activitySetting.activiryCmd}"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.stop"/></a>&nbsp;&nbsp;
				</c:if>
				<c:if test="${activitySetting.isRestart=='2'}">
					<a href="showSetActivitySetting.do?name=${activitySetting.activityKeyword}&op=update_time&param=${activitySetting.activiryNum},${activitySetting.circle},${activitySetting.startTime},${activitySetting.endTime}&type=${activitySetting.isReservation }"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.modifyTime"/></a>
				</c:if>
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td colspan="6" class="t_border">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.add"/>" onclick="window.location.href='showOperActivitySetting.do'"/>
				</td>
			</tr>
		</table>

		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>