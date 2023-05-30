<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="js/func.js"></script>
</head>


<body bgcolor="#ffffff">
	<form action="setActivitySetting.do" method="post">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.activitySetting.title"/>
				</td>
			</tr>
			<tr height="30px">
			<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activityKeyword"/>
				 </td>
				 <td class="t_border_r" align="left">
				 ${name}<input type="hidden" name="name" value="${name}"/>
				 </td>
			</tr>
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setActivitySetting.oper"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	 ${op}<input type="hidden" name="op" value="${op}"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.activiryCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	 ${paramCmd}<input type="hidden" name="param" value="${paramCmd}"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				 		<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="type" value="${type}"/>
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>