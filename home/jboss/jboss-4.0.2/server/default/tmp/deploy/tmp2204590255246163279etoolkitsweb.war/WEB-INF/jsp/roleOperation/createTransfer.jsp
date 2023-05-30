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
				if ( document.forms[0].passportName.value == "" || document.forms[0].passportName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.passport"/>');
					  document.forms[0].passportName.focus();
					  return false;
				}
				if ( document.forms[0].orderId.value == "" || document.forms[0].orderId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.transferID"/>');
					  document.forms[0].orderId.focus();
					  return false;
				}
				
				if ( document.forms[0].fromGatewayId.value == document.forms[0].toGatewayId.value){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.gateway"/>');
					  document.forms[0].fromGatewayId.focus();
					  return false;
				}
	
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.reason"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				if ( document.forms[0].reason.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.reasonLimit"/>');
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
	<form action="saveTransfer.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">${requestScope.title}</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="passportName" type="text" value="${requestScope.passportName }" style="width:220px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.transfer.outGateway2"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<gmweb:createGatewayOption name="fromGatewayId" checkedValue="${ requestScope.fromGatewayId}" gatewayList="${requestScope.gatewayList}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.transfer.inGateway2"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<gmweb:createGatewayOption name="toGatewayId" checkedValue="${ requestScope.toGatewayId}" gatewayList="${requestScope.gatewayList}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.transfer.transferNum"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="orderId" type="text" value="${requestScope.orderId }"  style="width:220px" />
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
					<input name="compensateId" type="hidden" value="${requestScope.compensateId }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>