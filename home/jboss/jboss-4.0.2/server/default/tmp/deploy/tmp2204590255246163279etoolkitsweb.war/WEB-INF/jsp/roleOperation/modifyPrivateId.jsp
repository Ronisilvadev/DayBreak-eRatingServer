<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javaScript">
			function check(){
			
				if ( document.forms[0].passportName.value == "" || document.forms[0].passportName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.passport"/>');
					  document.forms[0].passportName.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
			
			function isValidPrivateId(privateId) {
				if (privateId == null) return false;
				var re=/^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
				return re.test(privateId);
			}
			
			function check2(){
			
				if ( document.forms[1].idCode.value == "" || document.forms[1].idCode.value ==null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.playerRegest"/>');
					  document.forms[1].idCode.focus();
					  return false;
				}
				if (!isValidPrivateId(document.forms[1].idCode.value)){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.playerRegestError"/>');
					  document.forms[1].idCode.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
			
		</script>
</head>


<body bgcolor="#ffffff">
		<form action="showModifyPrivateId.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.modifyPrivateId.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="passportName" type="text" value="${passportName}" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<br />
	<c:if test="${not empty requestScope.playerInfoMap }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.modifyPrivateId.title2"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.regestNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${playerInfoMap["idCode"]}
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.passportName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${playerInfoMap["realName"]}
				 </td>
			</tr>
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	<form action="modifyPrivateId.do" method="post" onsubmit="return check2();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.modifyPrivateId.title3"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.regestNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="idCode" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="passportName" type="hidden" value="${passportName}" />
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	</body>
</html>