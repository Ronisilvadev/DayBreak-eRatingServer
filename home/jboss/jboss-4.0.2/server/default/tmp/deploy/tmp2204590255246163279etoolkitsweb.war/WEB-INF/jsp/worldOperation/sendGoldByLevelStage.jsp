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
				if ( document.forms[0].amount.value.trim() == "" || document.forms[0].amount.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.amount"/>');
						document.forms[0].amount.focus();
						return false;
				}
				if(!isNumber(document.forms[0].amount.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.amountErr"/>');
					document.forms[0].amount.focus();
					return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="sendGoldByLevelStage.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
						<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
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
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.sendGoldByLevelStage.amount"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="amount" type="text" style="width:230px" />
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