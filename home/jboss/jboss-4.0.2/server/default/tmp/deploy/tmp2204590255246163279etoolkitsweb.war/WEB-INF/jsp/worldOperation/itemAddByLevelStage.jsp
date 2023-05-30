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
		function check(){
				if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
					  document.forms[0].gatewayId.focus();
					  return false;
				}
				if ( document.forms[0].activityId.value.trim() == "" || document.forms[0].activityId.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
						document.forms[0].activityId.focus();
						return false;
				}
				if(!isNumber(document.forms[0].activityId.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityIdErr"/>');
					document.forms[0].activityId.focus();
					return false;
				}
				if ( document.forms[0].itemCode.value.trim() == "" || document.forms[0].itemCode.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemCode"/>');
						document.forms[0].itemCode.focus();
						return false;
				}
				if ( document.forms[0].beginDate.value.trim() == "" || document.forms[0].beginDate.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.beginDate"/>');
						document.forms[0].beginDate.focus();
						return false;
				}
				if ( document.forms[0].endDate.value.trim() == "" || document.forms[0].endDate.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endDate"/>');
						document.forms[0].endDate.focus();
						return false;
				}
				if ( document.forms[0].itemNum.value.trim() == "" || document.forms[0].itemNum.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemNum"/>');
						document.forms[0].itemNum.focus();
						return false;
				}
				if(!isNumber(document.forms[0].itemNum.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemNumErr"/>');
					document.forms[0].itemNum.focus();
					return false;
				}
				if ( document.forms[0].beginLv.value.trim() == "" || document.forms[0].beginLv.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.beginLv"/>');
						document.forms[0].beginLv.focus();
						return false;
				}
				if(!isNumber(document.forms[0].beginLv.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.beginLvErr"/>');
					document.forms[0].beginLv.focus();
					return false;
				}
				if ( document.forms[0].endLv.value.trim() == "" || document.forms[0].endLv.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endLv"/>');
						document.forms[0].endLv.focus();
						return false;
				}
				if(!isNumber(document.forms[0].endLv.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.endLvErr"/>');
					document.forms[0].endLv.focus();
					return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="itemAddByLevelStage.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.itemAddByLevelStage.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.gatewayId"/>：
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
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.itemAddByLevelStage.activityId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text" style="width:230px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.itemAddByLevelStage.itemCode"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemCode" type="text" style="width:230px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginDate" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:230px" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endDate" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:230px" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.itemAddByLevelStage.itemNum"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemNum" type="text" style="width:230px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.beginLv"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginLv" type="text" style="width:230px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.endLv"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endLv" type="text" style="width:230px" />
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
			<font color="red" size="2px"><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.info"/></b></font>
		</div>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>