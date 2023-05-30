<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		function isValidId(oNum) 
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
		function check(){
			if ( document.forms[0].itemCode.value == "" || document.forms[0].itemCode.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemCode"/>');
				  document.forms[0].itemCode.focus();
				  return false;
			}
			
			if ( document.forms[0].itemName.value == "" || document.forms[0].itemName.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemName"/>');
				  document.forms[0].itemName.focus();
				  return false;
			}
		
			if(document.forms[0].itemName.value.length > 12) {
				alert ('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemName.length"/>') ;
				document.forms[0].itemName.focus () ; 
				return false ;
			} 
			
			if ( document.forms[0].activityId.value == "" || document.forms[0].activityId.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			
			if (!isValidId(document.forms[0].activityId.value)){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityIdError"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			if ( document.forms[0].activityType.value == "" || document.forms[0].activityType.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityType2"/>');
				  document.forms[0].activityType.focus();
				  return false;
			}
			if (!isValidId(document.forms[0].activityType.value)){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityTypeError"/>');
				  document.forms[0].activityType.focus();
				  return false;
			}
			if ( document.forms[0].beginTime.value == "" || document.forms[0].beginTime.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startTime"/>');
					document.forms[0].beginTime.focus();
					return false;
			}
			
			if ( document.forms[0].endTime.value == "" || document.forms[0].endTime.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endTime"/>');
					document.forms[0].endTime.focus();
					return false;
			}
			
			if ( document.forms[0].pointType.value == "" || document.forms[0].pointType.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.pointType"/>');
				  document.forms[0].pointType.focus();
				  return false;
			}
			if (!isValidId(document.forms[0].pointType.value)){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.pointTypeError"/>');
				  document.forms[0].pointType.focus();
				  return false;
			}
			if ( document.forms[0].costPoint.value == "" || document.forms[0].costPoint.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.costPoint"/>');
				  document.forms[0].costPoint.focus();
				  return false;
			}
			
			if (!isValidId(document.forms[0].costPoint.value)){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.costPointError"/>');
				  document.forms[0].costPoint.focus();
				  return false;
			}
			
			
			
			if ( document.forms[0].sendItemNum.value == "" || document.forms[0].sendItemNum.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.sendItemNum"/>');
				  document.forms[0].sendItemNum.focus();
				  return false;
			}
			
			if (!isValidId(document.forms[0].sendItemNum.value)){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.sendItemNumError"/>');
				  document.forms[0].sendItemNum.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<gmweb:showGiveItemDesc />
	<form action="addChargingGiveItem.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.addChargingGiceItem.title"/>
				</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItemDetail.itemCode"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemCode" type="text" value="${requestScope.itemCode}" style="width:200px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.product.productTitle"/> 
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemName" type="text" value="${requestScope.itemName}" style="width:200px" />&nbsp;<bean:message bundle="pageResources" key="page.worldOperation.errors.itemName.length"/>
				 </td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text" value="${requestScope.activityId}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityType" type="text" value="${requestScope.activityType}" style="width:200px" />
				 </td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItemDetail.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
						<option value="0">0-<bean:message bundle="pageResources" key="page.worldOperation.common.allGateway"/></option>
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName}</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.beginTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.activityType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="pointType" type="text" value="${requestScope.pointType}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.activityNum2"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="costPoint" type="text" value="${requestScope.costPoint}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.sendItemNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="sendItemNum" type="text" value="${requestScope.sendItemNum}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showChargingGiveItem.do'" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>