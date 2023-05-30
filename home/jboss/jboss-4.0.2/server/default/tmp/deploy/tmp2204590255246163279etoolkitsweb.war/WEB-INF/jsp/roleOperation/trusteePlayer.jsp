<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	
	<script type="text/javaScript">
	
			function isValidPassword(password) {
				if (password == null) return false;
				var re=/^\S*[A-Za-z]+\S*$/
				var re2=/^[^\u4e00-\u9fa5\s]+$/
				var re3=/^\S*[0-9]+\S*$/
				return re.test(password) || re2.test(password) || re3.test(password);
			}
			
			function check(){
			
				if ( document.forms[0].password.value == "" || document.forms[0].password.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error1"/>');
					  document.forms[0].password.focus();
					  return false;
				}
				if (document.forms[0].password.value.length < 6 || document.forms[0].password.value.length > 31){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error2"/>');
					  document.forms[0].password.focus();
					  return false;
				}
				
				if (!isValidPassword(document.forms[0].password.value)){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error3"/>');
					  document.forms[0].password.focus();
					  return false;
				}
				if ( document.forms[0].replyPassword.value == "" || document.forms[0].replyPassword.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error4"/>');
					  document.forms[0].replyPassword.focus();
					  return false;
				}
				if ( document.forms[0].replyPassword.value != document.forms[0].password.value){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error5"/>');
					  document.forms[0].replyPassword.focus();
					  return false;
				}
				if ( document.forms[0].adminPassword.value == "" || document.forms[0].adminPassword.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error6"/>');
					  document.forms[0].adminPassword.focus();
					  return false;
				}
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error7"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				else if ( document.forms[0].reason.value.length > 128){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.error8"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				else {
					  return true;
				}
			}
			
	</script>
</head>

<body bgcolor="#ffffff">
	<form action="trusteePlayer.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${playerName }"/>
				 	<input name="playerId" type="hidden" value="${playerId }" />
				 	<input name="playerName" type="hidden" value="${playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.password"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="password" type="password" />
				 	<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.passwordRemark"/>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.isPassword"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<input name="replyPassword" type="password" />
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.adminPassword"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<input name="adminPassword" type="password" />
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.loginIp"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<select name="allowIp">
				  	<c:forEach items="${requestScope.trusteeIpList}" var="trusteeIp">
						<option value='${trusteeIp.trusteeIp }'>${trusteeIp.ipName } - ${trusteeIp.trusteeIp }</option>
				  	</c:forEach>
					</select>
					<strong>
					<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.yourIP"/>${sessionScope.userInfo.loginIp }</strong>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeType2"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<input type="radio" name="trusteeType" value="1" checked /><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.loginTrustee"/>
				  	<input type="radio" name="trusteeType" value="2" /><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.allTrustee"/><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.wending"/>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.trusteeReason"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="50" rows="10" name="reason" ></textarea>
				  	<br />
				  	<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.trusteePlayer.trustee"/>" />
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>