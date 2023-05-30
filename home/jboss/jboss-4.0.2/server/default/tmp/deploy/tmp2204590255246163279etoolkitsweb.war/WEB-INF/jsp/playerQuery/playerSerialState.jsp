<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
</head>
  
  <body bgcolor="#ffffff">
  <c:if test="${empty requestScope.userStates}">
  <form action="playerSerialState.do" method="post">
   <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.playerSerialState.titile"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.issueActivity.activityId"/>:</td>
				<td class="t_border_l" align="left"><input type="text" name="activityId" /></td>
				<td class="t_border_r" align="left">
				<bean:message bundle="pageResources" key="page.common.ableNull"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>:</td>
				<td class="t_border_l" align="left">
					<textarea name="passports" rows="10" cols="35" style="width:200px"></textarea></td> <td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.playerQuery.playerNames2Ids.addRemark"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
		</c:if>
		<c:if test="${not empty requestScope.userStates}">
			  <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerSerialState.titile"/> </td>
			</tr>
			<c:forEach var="test" items="${requestScope.userStates}" varStatus="statet">
			<tr height="30px">
				<td class="t_border_l" align="center" <c:if test="${statet.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>${test.key }</td>
				<td class="t_border_r" align="center" <c:if test="${statet.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>><c:if test="${test.value == 1}"><a href="activationLog.do?passport=${test.key }"><bean:message bundle="pageResources" key="page.playerQuery.playerSerialState.userstate1"/></a></c:if><c:if test="${ test.value != 1}"><bean:message bundle="pageResources" key="page.playerQuery.playerSerialState.userstate2"/></c:if></td>
			</tr></c:forEach>
			</table>
		</c:if>
  </body>
</html>
