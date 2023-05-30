<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		var tmpValue;
		function disableInput(){
			 for(var i=0;i < document.forms[0].booking.length;i++)   
				  {   
				  	if(document.forms[0].booking[i].checked)   
				  {   
				  	tmpValue = document.forms[0].booking[i].value   
				  	break   
				  }   
			}
		
			if (tmpValue == '0'){
				document.all.startTime.disabled = true;
			}else{
				document.all.startTime.disabled = false;
			}
		}
		
		function isInt(strInt) {
			if (strInt == null) return false;
			var re=/^\d{1,1}$/
			return re.test(strInt);
		}
		
		function check(){
			return true;
		}
		
		function isLimitCheck(arg){
			if(arg=='0'){
				limitNumTr.style.display = 'none';
			}else
			if(arg=='1'){
				limitNumTr.style.display = "";
			}
		}
		
		function isLimitTimeCheck(arg){
			if(arg=='0'){
				limitTimeTr.style.display = 'none';
			}else
			if(arg=='1'){
				limitTimeTr.style.display = "";
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="addProductPrice.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.addProductPrice.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.productCode"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 		${ requestScope.productCode}
				 		<input name="productCode" type="hidden" value="${ requestScope.productCode}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectId"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="subjectId">
						<option value='3' selected>3-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdGold"/></option>
						<option value='4'>4-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdSiv"/></option>
						<option value='5'>5-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdYuanbao"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addProductPrice.priceOrigin"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="priceOrigin" type="text" value="${ requestScope.priceOrigin}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addProductPrice.priceDiscount"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="priceDiscount" type="text" value="${ requestScope.priceDiscount}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.isLimitTime"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="radio" name="isLimitTime" onclick="isLimitTimeCheck('0')" value="0" checked /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart1"/>
					<input type="radio" name="isLimitTime" onclick="isLimitTimeCheck('1')" value="1" /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart2"/>
				 </td>
			</tr>
			<tr height="30px" id="limitTimeTr"  style="display:none">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.limitTime"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="limitTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm'})" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.isLimit"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="radio" name="isLimit" onclick="isLimitCheck('0')" checked /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart1"/>
					<input type="radio" name="isLimit" onclick="isLimitCheck('1')" /><bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart2"/>
				 </td>
			</tr>
			<tr height="30px" id="limitNumTr" style="display:none">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.limitNum"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="text" name="limitNum" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="productId" type="hidden" value="${ requestScope.productId}" />
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