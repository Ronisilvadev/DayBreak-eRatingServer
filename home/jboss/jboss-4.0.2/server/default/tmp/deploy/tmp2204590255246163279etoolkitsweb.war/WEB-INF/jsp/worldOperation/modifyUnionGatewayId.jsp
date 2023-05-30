<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
				return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
			
				var gatewayId1 = document.forms[0].gatewayId1.value.trim();
				var gatewayId2 = document.forms[0].gatewayId2.value.trim();
				
				if ( gatewayId1 == "" || gatewayId1  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
					  document.forms[0].gatewayId1.focus();
					  return false;
				}
				if ( gatewayId2 == "" || gatewayId2 == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
					  document.forms[0].gatewayId2.focus();
					  return false;
				}
				if ( gatewayId1 == gatewayId2){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.modifyUnionGatewayId"/>');
					  document.forms[0].gatewayId2.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="modifyUnionGatewayId.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.modifyUnionGatewayId.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.modifyUnionGatewayId.gatewayId1"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId1" style="width:230px">
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.modifyUnionGatewayId.gatewayId2"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId2" style="width:230px">
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		<br>
		<div>
			<font size="2px"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message bundle="pageResources" key="page.worldOperation.modifyUnionGatewayId.info"/></b></font>
		</div>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>