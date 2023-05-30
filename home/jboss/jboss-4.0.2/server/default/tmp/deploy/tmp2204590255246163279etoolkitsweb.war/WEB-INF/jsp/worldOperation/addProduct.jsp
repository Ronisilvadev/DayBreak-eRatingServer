<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript">
		function isInt(strInt) {
			if (strInt == null) return false;
			var re=/^\d{1,1}$/
			return re.test(strInt);
		}
		
		function check(){
			if ( document.forms[0].productCode.value == "" || document.forms[0].productCode.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemCode"/>');
					  document.forms[0].productCode.focus();
					  return false;
			}
			
			if ( document.forms[0].productName.value == "" || document.forms[0].productName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.itemName"/>');
					  document.forms[0].productName.focus();
					  return false;
			}
			
			if ( document.forms[0].productDesc.value.length > 4000){
					  	alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.descLength"/>');
						document.forms[0].productDesc.focus();
						return false;
				}
				
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="addProduct.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.addProduct.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.productCode"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="productCode" type="text" value="${ requestScope.productCode}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_name"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="productName" type="text" value="${ requestScope.productName}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_type"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="useType">
				 		<option value='1'><bean:message bundle="pageResources" key="page.worldOperation.addProduct.itemTypeValue1"/></option>
						<option value='2'><bean:message bundle="pageResources" key="page.worldOperation.addProduct.itemTypeValue2"/></option>
						<option value='3' selected><bean:message bundle="pageResources" key="page.worldOperation.addProduct.itemTypeValue3"/></option>
						<option value='4'><bean:message bundle="pageResources" key="page.worldOperation.addProduct.itemTypeValue4"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.description"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="20" rows="5" name="productDesc" ></textarea>
				  	<bean:message bundle="pageResources" key="page.worldOperation.common.length4000"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showProduct.do'"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>