<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
  </head>
  
<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.passportName }">
		<form  action="getPassportName.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.showPassportName.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showPassportId"/></td>
				<td class="t_border_r" align="left">
					<input type="text" name="passportId" style="width:200px"/>
				</td>	
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>""/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"><html:errors />${msg}</font>
			<font color="red" size="3px">${request.msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.passportName }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.showPassportName.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">玩家帐号:</td>
				<td class="t_border_r" align="left">
					${requestScope.passportName}
				</td>	
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="2">
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showgetPassportName.do'"/>
				</td>
			</tr>
		</table>
		<br />
	</c:if>
</body>
</html>
