<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
		function check(){
		        
				if ( document.forms[0].playerNames.value == "" || document.forms[0].playerNames.value  == null){
						alert('<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.error1"/>');
						document.forms[0].playerNames.focus();
						return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="validateRestorePlayers.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">${requestScope.title }</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="playerNames" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.players"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.next"/>" />
				</td>
			</tr>
		</table>
	</form>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	
	</body>
</html>