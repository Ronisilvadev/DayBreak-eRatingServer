<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/loginInfo"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.loginInfoList }">
		<html:form action="loginInfo.do" method="post" onsubmit="return validateLoginInfoForm(this);"> 
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="userName" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate" />
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</html:form>
	
	</c:if>
	<c:if test="${not empty requestScope.loginInfoList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="9" align="center" ></td>
		</tr>
		<tr>
			<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.title"/> </td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginTime"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginMoney"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginExp"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginIp"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginOutTime"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginOutMoney"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginOutExp"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginOutIp"/></td>
		</tr>
			<c:forEach items="${requestScope.loginInfoList}" var="loginInfo" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l">${loginInfo.login_in_time }</td>
					<td align="center" class="t_border_l">${loginInfo.login_in_money }</td>
					<td align="center" class="t_border_l">${loginInfo.login_in_exp }</td>
					<td align="center" class="t_border_l">${loginInfo.login_in_ip }</td>
					<td align="center" class="t_border_l">${loginInfo.login_out_time }</td>
					<td align="center" class="t_border_l">${loginInfo.login_out_money }</td>
					<td align="center" class="t_border_l">${loginInfo.login_out_exp }</td>
					<td align="center" class="t_border_r">${loginInfo.login_out_ip }</td>
				</tr>
			</c:forEach>
		<tr height="5px">
			<td colspan="9" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
	</table>
	<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showLoginInfo.do'"/>
		</div>
	</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>