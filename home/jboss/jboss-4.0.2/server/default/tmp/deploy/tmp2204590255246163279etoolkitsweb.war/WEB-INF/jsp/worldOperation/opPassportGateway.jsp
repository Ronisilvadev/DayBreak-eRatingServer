<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
			var gatewayId = document.forms[0].gatewayId.value;
			var gatewayName = document.forms[0].gatewayName.value;
			if(gatewayId.trim() == "" || gatewayId.trim() == null){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gatewayId"/>');
				document.forms[0].gatewayId.focus();
				return false;
			}
			if(gatewayName.trim() == "" || gatewayName.trim() == null){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gatewayName"/>');
				document.forms[0].gatewayName.focus();
				return false;
			}
			if(!isNumber(gatewayId.trim())){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gatewayIdIsNum"/>');
				document.forms[0].gatewayId.focus();
				return false;
			}
			else {
				return true;
			}
		}
		
		function isNumber(oNum) 
   		{ 
  			if(!oNum) return false; 
 			var strP=/^\d+(\.\d+)?$/; 
  			if(!strP.test(oNum)) return false; 
  			try{ 
  				if(parseFloat(oNum)!=oNum) return false; 
  			}catch(ex){ 
   				return false; 
  			} 
  			return true; 
   		}
		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="opPassportGateway.do" method="post" onsubmit="return check();">
	<c:if test="${requestScope.opFlag == 'add' }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.title"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gameId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gameId}
				 	<input type="hidden" name="opFlag" value="${requestScope.opFlag}" />
				    <input name="originalGatewayId" type="hidden" value="0" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayId" type="text" value="${requestScope.strGatewayId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gatewayName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayName" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.beginDate}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />
				</td>
			</tr>
		</table>
	</c:if>
	<c:if test="${requestScope.opFlag == 'modify' }">
	<c:if test="${not empty requestScope.passportGateway }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.title2"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gameId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.gameId}
				 	<input type="hidden" name="opFlag" value="${requestScope.opFlag}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayId" type="text" value="${requestScope.passportGateway.gatewayId}" />
				 	<input name="originalGatewayId" type="hidden" value="${requestScope.passportGateway.original_gatewayId}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.opPassportGateway.gatewayName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayName" type="text" value="${requestScope.passportGateway.gatewayName }"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.passportGateway.beginTime}" pattern="yyyy-MM-dd HH:mm:ss" />" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.passportGateway.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />
				</td>
			</tr>
		</table>
	</c:if>
	</c:if>
	</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>