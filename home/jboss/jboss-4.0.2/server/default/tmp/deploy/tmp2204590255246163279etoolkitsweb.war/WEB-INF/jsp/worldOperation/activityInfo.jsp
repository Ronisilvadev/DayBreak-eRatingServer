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
	<form action="delActivityInfo.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="8"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="8"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.title"/> </td>
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
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.circleday"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.activityInfo}" var="activityInfo" varStatus="status">
			
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
				<td align="center" class="t_border_r">
					${activityInfo.circleday}
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td colspan="8" class="t_border">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.add"/>" onclick="window.location.href='showOpActivityInfo.do?opFlag=add'"/>
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/>" onclick="window.location.href='showOpActivityInfo.do?opFlag=synchronization'"/>
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.plan"/>"   onclick="window.location.href='showOpActivityInfo.do?opFlag=plan'"/>
					<input type="submit" id="delButton" value="<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.del"/>" disabled />
				</td>
			</tr>
		</table>
	</form>

		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>