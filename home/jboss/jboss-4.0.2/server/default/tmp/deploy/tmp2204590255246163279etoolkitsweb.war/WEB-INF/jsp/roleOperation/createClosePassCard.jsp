<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	
	<script type="text/javaScript">
			
			function check(){
			
				var pattern=/\w+@\w+\.[a-z]+/; 
				
				if ( document.forms[0].passportName.value == "" || document.forms[0].passportName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.passport"/>');
					  document.forms[0].passportName.focus();
					  return false;
				}
				if ( document.forms[0].playerRealName.value == "" || document.forms[0].playerRealName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.playerName"/>');
					  document.forms[0].playerRealName.focus();
					  return false;
				}
				if ( document.forms[0].privateId.value == "" || document.forms[0].privateId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.playerRegest"/>');
					  document.forms[0].privateId.focus();
					  return false;
				}
	
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.error2"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				if ( document.forms[0].reason.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.reasonLimit"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				if(!(pattern.test(document.forms[0].newEmail.value)))
				{
					alert('<bean:message bundle="pageResources" key="page.roleOperation.error.emailError"/>');
					document.forms[0].newEmail.focus();
					return false;
				}
			
				else {
					return true;
				}
			}
			
	</script>
	
</head>


<body bgcolor="#ffffff">
	<form action="saveClosePassCard.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleOperation.createClosePassCard.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="passportName" type="text" value="${requestScope.passportName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.passportName"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="playerRealName" type="text" value="${requestScope.playerRealName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.regestNum"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="privateId" type="text" value="${requestScope.privateId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.reason"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="reason" rows=8 cols=35 size="10240" >${requestScope.reason }</textarea>
				 </td>
				 <td class="t_border_r" align="left">
				 <bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.submit1"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	 <input type="checkbox" name="commitFlag" value="1" <c:if test="${requestScope.commitFlag == '1' }">checked</c:if> /> <bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.submit2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="compensateId" type="hidden" value="${requestScope.changeId }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.save"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>