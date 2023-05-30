<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
		function check(){
			
				if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
					  document.forms[0].gatewayId.focus();
					  return false;
				}
				
				if ( document.forms[0].productCode.value == "" || document.forms[0].productCode.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemId"/>');
						document.forms[0].productCode.focus();
						return false;
				}
				
				if ( document.forms[0].position.value == "" || document.forms[0].position.value  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.pos"/>');
						document.forms[0].position.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="sortProduct.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.productSort.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
				 		<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.common.allGateway"/></option>
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.productSort.productCode"/>:
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="productCode" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.productSort.position"/>:
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="position" type="text" style="width:200px" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.addProduct.locationDesc"/>
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