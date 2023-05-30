<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javaScript">
			String.prototype.trim=function(){ 
				return this.replace(/(^\s*)|(\s*$)/g, ""); 
			} 
			function check(){
			
				if ( document.forms[0].orderId.value.trim() == "" || document.forms[0].orderId.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.orderId"/>');
					  document.forms[0].orderId.focus();
					  return false;
				}
				if(!isNumber(document.forms[0].orderId.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.orderIdIsNum"/>');
					document.forms[0].orderId.focus();
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
	<form action="modifyOrderStatus.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
					<bean:message bundle="pageResources" key="page.worldOperation.modifyOrderState.title"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.orderId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="orderId" type="text" style="width:200px" value="${requestScope.orderId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/>" />
				</td>
			</tr>
		</table>
	</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	
</body>
</html>