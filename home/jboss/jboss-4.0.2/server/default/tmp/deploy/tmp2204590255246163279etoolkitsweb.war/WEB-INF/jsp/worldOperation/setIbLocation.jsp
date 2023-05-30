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
		function check(){
			
				if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
					  document.forms[0].gatewayId.focus();
					  return false;
				}
				
				if ( document.forms[0].webType.value == "" || document.forms[0].webType.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.webType"/>');
						document.forms[0].webType.focus();
						return false;
				}
				
				if ( document.forms[0].itemId.value == "" || document.forms[0].itemId.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemId"/>');
						document.forms[0].itemId.focus();
						return false;
				}
				
				if ( document.forms[0].pos.value == "" || document.forms[0].pos.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.pos"/>');
						document.forms[0].pos.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="setIbLocation.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.setIbLocation.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbLocation.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbLocation.webType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="webType" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbLocation.itemId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemId" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbLocation.pos"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="pos" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>