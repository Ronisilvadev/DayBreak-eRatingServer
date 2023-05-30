<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/queryTestSerialInfo"/>
</head>
<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.testSerialList }">
		<html:form  action="queryTestSerialInfo.do" method="post"onsubmit="return validateQueryTestSerialInfoForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.testSerialTotal.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="activityId">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.serialTotal"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate}" pattern="yyyy-MM-dd"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.openService"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.endDate}" pattern="yyyy-MM-dd"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>""/>
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.testSerialList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="4" align="center" ></td>
			</tr>
			<tr>
				<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.testSerialTotal.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.PlayerQuery.testSerialTotal.date"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.testSerialTotal.activity"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.testSerialTotal.loginNum"/></td>
			</tr>
		<c:forEach items="${requestScope.testSerialList}" var="test">
			<tr height="23px">
				<td align="center" class="t_border_l"><gmweb:showTimeFormat user_time="${test.user_time}" endDate="${requestScope.endDate}"></gmweb:showTimeFormat></td>
				<td align="center" class="t_border_l">&nbsp;${test.activity}</td>
				<td align="center" class="t_border_l">${test.logion}</td>
			</tr>
		</c:forEach>
			<tr height="10px">
				<td colspan="3" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showQueryTestSerialInfo.do'"/>
		</div>
	</c:if>
</body>
</html>