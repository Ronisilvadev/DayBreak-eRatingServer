<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/func.js"></script>
	<title></title>
	<html:javascript formName="/finishedTaskInfo"/>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.finishedTaskInfoList }">
		<html:form action="finishedTaskInfo.do" method="post" onsubmit="return validateFinishedTaskInfoForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.finishedTaskInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:150px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.role"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:230px" /> 
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	<c:if test="${not empty requestScope.finishedTaskInfoList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="3" align="center" ></td>
		</tr>
		<tr>
			<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.finishedTaskInfo.title2"/> </td>
		</tr>
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.finishedTaskInfo.taskId"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.finishedTaskInfo.taskName"/></td>
		</tr>
			<c:forEach items="${requestScope.finishedTaskInfoList}" var="finishedTaskInfo" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_r">${finishedTaskInfo.taskId }</td>
					<td align="center" class="t_border_r">${finishedTaskInfo.taskName }</td>
				</tr>
			</c:forEach>
		<tr height="5px">
			<td colspan="3" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center" >
				<input type="submit" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showFinishedTaskInfo.do'" />
			</td>
		</tr>
	</table>
	</c:if>
	</body>
</html>