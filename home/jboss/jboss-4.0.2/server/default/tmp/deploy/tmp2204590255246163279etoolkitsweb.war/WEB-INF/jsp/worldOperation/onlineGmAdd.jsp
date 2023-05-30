<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script language="javascript">
			
			
			function changeAction(obj){
				obj.action = "modifyOnlineGm.do";
				obj.method = "post";
				if (checkModForm(obj)){
					obj.submit();
					return true;
				}
				return false;
			}
			
			function checkModForm(obj){
				var realName = obj.realName.value;
				var email = obj.email.value;
				if (realName == null || realName.length < 1){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.realName"/>');
					obj.realName.focus();
					return false;
				}
				if (email == null || email.length < 1){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.email"/>');
					obj.email.focus();
					return false;
				}
				
				if (!checkEmail(email)){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.emailError"/>');
					obj.email.focus();
					return false;
				}
				return true;
			}
			
			function checkAddForm(obj){
				var passportName = obj.passportName.value;
				var realName = obj.realName.value;
				var email = obj.email.value;
				if (passportName == null || passportName.length < 1){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.passportName"/>');
					obj.passportName.focus();
					return false;
				}
				if (realName == null || realName.length < 1){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.realName"/>');
					obj.realName.focus();
					return false;
				}
				if (email == null || email.length < 1){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.email"/>');
					obj.email.focus();
					return false;
				}
				
				if (!checkEmail(email)){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.emailError"/>');
					obj.email.focus();
					return false;
				}
				return true;
			}
			
			function checkEmail(emailStr) {
		       if (emailStr.length == 0) {
		           return true;
		       }
		       var emailPat=/^(.+)@(.+)$/;
		       var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
		       var validChars="\[^\\s" + specialChars + "\]";
		       var quotedUser="(\"[^\"]*\")";
		       var ipDomainPat=/^(\d{1,3})[.](\d{1,3})[.](\d{1,3})[.](\d{1,3})$/;
		       var atom=validChars + '+';
		       var word="(" + atom + "|" + quotedUser + ")";
		       var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
		       var domainPat=new RegExp("^" + atom + "(\\." + atom + ")*$");
		       var matchArray=emailStr.match(emailPat);
		       if (matchArray == null) {
		           return false;
		       }
		       var user=matchArray[1];
		       var domain=matchArray[2];
		       if (user.match(userPat) == null) {
		           return false;
		       }
		       var IPArray = domain.match(ipDomainPat);
		       if (IPArray != null) {
		           for (var i = 1; i <= 4; i++) {
		              if (IPArray[i] > 255) {
		                 return false;
		              }
		           }
		           return true;
		       }
		       var domainArray=domain.match(domainPat);
		       if (domainArray == null) {
		           return false;
		       }
		       var atomPat=new RegExp(atom,"g");
		       var domArr=domain.match(atomPat);
		       var len=domArr.length;
		       if ((domArr[domArr.length-1].length < 2) ||
		           (domArr[domArr.length-1].length > 3)) {
		           return false;
		       }
		       if (len < 2) {
		           return false;
		       }
		       return true;
   			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="addOnlineGm.do" method="post" onsubmit="return checkAddForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
        	<c:if test="${empty requestScope.onlineGm }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.passportName"/></td>
				<td class="t_border_r"><input name="passportName" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.realName"/></td>
				<td class="t_border_r"><input name="realName" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.eMail"/></td>
				<td class="t_border_r"><input name="email" type="text" /> *</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="submit" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />&nbsp;&nbsp;
					<input name="reset" type="reset" value="<bean:message bundle="pageResources" key="page.worldOperation.common.restart"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>" onclick="window.location.href='showOnlineGm.do'" />	
				</td>
			</tr>
			
			</c:if>
			
			<c:if test="${not empty requestScope.onlineGm }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="right"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.passportName"/></td>
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
                	${onlineGm.passportName }
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.realName"/></td>
				<td class="t_border_r"><input name="realName" type="text" value="${onlineGm.realName }" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGmAdd.eMail"/></td>
				<td class="t_border_r"><input name="email" type="text" value="${onlineGm.email }" /> *</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="gmId" type="hidden" value="${onlineGm.gmId }" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" onclick="changeAction(document.forms[0]);" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.worldOperation.common.restart"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>" onclick="window.location.href='showOnlineGm.do'" />
				</td>
			</tr>
			
			</c:if>
			
		</table>
	</form>
	</body>
</html>