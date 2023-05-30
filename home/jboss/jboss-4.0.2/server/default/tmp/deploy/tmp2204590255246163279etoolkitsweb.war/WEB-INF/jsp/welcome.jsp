<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>welcome</title>
</head>

<body style="MARGIN: 0px" scroll=no bgcolor="#ffffff">

<table width="99%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center"> 
   <tr>
      <td height="25" colspan="2"></td>
  </tr>
  <tr bgcolor="CDE4F6">
  	<td align="right" width="5%"><img src="images/ball.jpg" /></td>
      <td height=30 style="padding-left:5px;" align="left"><bean:message bundle="pageResources" key="page.welcome.welcome"/>，${sessionScope.userInfo.passportName }</td>
  </tr>
  <tr bgcolor="E3EDF6">
    <td align="right">&nbsp;</td>
    <td height=30 style="padding-left:5px;" align="left"><bean:message bundle="pageResources" key="page.welcome.lastLoginTime"/>：<fmt:formatDate value="${sessionScope.userInfo.lastLoginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
  </tr>
  <tr bgcolor="CDE4F6">
    <td align="right">&nbsp;</td>
    <td height=30 style="padding-left:5px;" align="left"><bean:message bundle="pageResources" key="page.welcome.lastLoginIp"/>：${sessionScope.userInfo.lastLoginIp }</td>
  </tr>
  <tr bgcolor="E3EDF6" >
    <td align="right">&nbsp;</td>
    <td height=30 style="padding-left:5px;" align="left"><bean:message bundle="pageResources" key="page.welcome.loginIp"/>：${sessionScope.userInfo.loginIp }</td>
  </tr>
  <tr bgcolor="CDE4F6">
    <td align="right">&nbsp;</td>
    <td height=30 style="padding-left:5px;" align="left"><bean:message bundle="pageResources" key="page.welcome.loginCount"/> ${sessionScope.userInfo.loginCount + 1} <bean:message bundle="pageResources" key="page.welcome.loginCount2"/></td>
  </tr>
</table>

<table width="99%" height="100%" border="0" cellspacing="0" cellpadding="0" align="center">  
	<tr>
    	<td valign="bottom" align="right" height="100%"><img src="images/welcomebg.jpg" /></td>
  	</tr>
</table>

</body>


</html>
