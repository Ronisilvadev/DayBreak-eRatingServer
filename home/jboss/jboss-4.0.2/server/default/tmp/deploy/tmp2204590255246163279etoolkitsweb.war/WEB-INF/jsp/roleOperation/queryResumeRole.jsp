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
		
			if ( document.forms[0].roleName.value == "" || document.forms[0].roleName.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.roleName"/>');
				  document.forms[0].roleName.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
		
		function gotoPage(obj){
			obj.submit();
		}
			
		</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<form action="showResumeRole.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryResumeRole"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.roleName"/></td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left">
					<gmweb:createGatewayOption name="gatewayId" checkedValue="${ requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" />
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
	</c:if>
	
</body>
</html>