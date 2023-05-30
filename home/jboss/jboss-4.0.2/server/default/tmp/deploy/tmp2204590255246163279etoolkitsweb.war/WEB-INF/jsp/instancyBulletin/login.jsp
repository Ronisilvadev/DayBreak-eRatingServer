<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><bean:message bundle="pageResources" key="page.login.title"/></title>
<style type="text/css">
<!--
div,ul,ol,li{margin:0;padding:0;border:0;}
td,li,select,input {font-size:12px;}

.w802 {width: 802px; clear:both;}
.w566 {width: 566px; float:left; height:171px;}
.w802 img{float:left;}
.login_bg{ width:236px;height:171px; background:url(images/login/login_r3_c3.jpg); float:right;}
-->
</style>
 <link href="css/main.css" rel="stylesheet" type="text/css" />

<script type="text/javaScript">
	function check(){
			
		if ( document.LoginForm.passportName.value == "" || document.LoginForm.passportName.value  == null){
			  alert('<bean:message bundle="pageResources" key="page.login.error.passport"/>');
			  document.LoginForm.passportName.focus();
			  return false;
		}
		else if ( document.LoginForm.password.value == "" || document.LoginForm.password.value ==null){
			  alert('<bean:message bundle="pageResources" key="page.login.error.password"/>');
			  document.LoginForm.password.focus();
			  return false;
		}
		else if ( document.LoginForm.validCode.value == "" || document.LoginForm.validCode.value ==null){
			  alert('<bean:message bundle="pageResources" key="page.login.error.validCode"/>');
			  document.LoginForm.validCode.focus();
			  return false;
		}
		else {
			  document.LoginForm.submit();
			  return true;
		}
	}
			
</script>
</head>

<body>
<center>
<div class="w802" style="margin:50px">
<img src="images/login/login_r1_c1.jpg" /><img src="images/login/login_r1_c2.jpg" />
<img src="images/login/login_r2_c1.jpg" /><img src="images/login/login_r2_c2.jpg" />
<div>
    <div class="w566"><img src="images/login/login_r3_c1.jpg" /><img src="images/login/login_r3_c2.jpg" />
    <img src="images/login/login_r4_c1.jpg" /><img src="images/login/login_r4_c2.jpg" /></div>
    <div class="login_bg">
        <form name="LoginForm" method="post" action="instancyBulletin.do?method=login">
                <table width="100%" border="0" cellpadding="0" cellspacing="0" style="margin-top:10px;">
                    <tr height="25px">
                        <td width="30%" align="right"><bean:message bundle="pageResources" key="page.login.passport"/>：</td>
                        <td align="left"><input type="text" name="passportName" style="width:120px;height:12px"/></td>
                    </tr>
                    <tr height="25px" align="right">
                        <td><bean:message bundle="pageResources" key="page.login.password"/>：</td>
                        <td align="left"><input type="password" name="password" style="width:120px;height:12px"/></td>
                    </tr>
                    <tr height="25px">
                      <td align="right"><bean:message bundle="pageResources" key="page.login.game"/>：</td>
                      <td align="left">
                            <select name="gameId">
								<c:forEach items="${requestScope.gameList}" var="game">
									<option value="${game.gameId }" <c:if test="${2 == game.gameId }">selected </c:if>>${game.gameName }</option>
								</c:forEach>
							</select>
                      </td>
                  </tr>
                    <tr height="25px">
                      <td align="right"><bean:message bundle="pageResources" key="page.login.gateway"/>：</td>
                      <td align="left">
                        <select name="region" style="width:120px">
                        <option value="1" selected ><bean:message bundle="pageResources" key="page.login.gateway1"/></option>
                        <option value="0" ><bean:message bundle="pageResources" key="page.login.gateway2"/></option>
                        </select>
                      </td>
                  </tr>
                    <tr height="25px" align="right">
                        <td><bean:message bundle="pageResources" key="page.login.validCode"/>：</td>
                        <td align="left"><input type="text" name="validCode" style="width:50px;height:12px" /><img align="absmiddle" border="0" src="generateRandomCode.do" alt="<bean:message bundle="pageResources" key="page.login.generateRandomCode"/>" onclick="this.src=this.src+'?'" style="float:none" height="20px"/>								</td>
                    </tr>
                    <tr height="25px">
                        <td colspan="2" align="center">
                        	<input type="button" value="<bean:message bundle="pageResources" key="page.login.login"/>" onclick = "return check();" style="cursor:pointer;float:none" />&nbsp;&nbsp;
                        	<input type="button" value="<bean:message bundle="pageResources" key="page.login.reset"/>" onclick = "LoginForm.reset();" style="cursor:pointer;float:none" />								</td>
                    </tr>
                </table>
        </form>
    </div>
</div>
</div>
</center>
<div align="center">
	<a href="login.do?method=showLogin"><bean:message bundle="pageResources" key="page.login.loginType1"/></a>
</div>
<div align="center">
	<font color="red" size="3px">${errMsg }</font>
</div>
<script type="text/javaScript">
	document.LoginForm.passportName.focus();
	
	document.onkeydown = function(e){
		var event = window.event || e;
		if(event.keyCode == 13){
			check();
		}
	}
</script>
</body>
</html>
