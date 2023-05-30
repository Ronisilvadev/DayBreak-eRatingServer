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
				if ( document.forms[0].moneyNum.value.trim() == "" || document.forms[0].moneyNum.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.error.paymoneyall"/>');
					  document.forms[0].moneyNum.focus();
					  return false;
				}
				if ( document.forms[0].reason.value.trim() == "" || document.forms[0].reason.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.reason"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				if(!isNumber(document.forms[0].moneyNum.value.trim())){
					alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.moneytype"/>');
					document.forms[0].moneyNum.focus();
					return false;
				}
				if ( document.forms[0].reason.value.trim().length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.reasonLength"/>');
					  document.forms[0].reason.focus();
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
	<form action="savePayMoneyAllCompensate.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.title2"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="gatewayId">
				 		<option value="0" selected>0 - <bean:message bundle="pageResources" key="page.roleCompensate.common.allGateway"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }" <c:if test="${requestScope.gatewayId == gateway.gatewayId }">selected</c:if>>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYTYPE"/>： 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<select name="moneyType">
				  		<option value="1" <c:if test="${requestScope.PayMoneyAllCompensate.MONEY_TYPE == 1}">selected</c:if>>1 - <bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYTYPE1"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYNUM"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="moneyNum" type="text" value="${requestScope.PayMoneyAllCompensate.MONEY_NUM }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.reason"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<textarea name="reason" rows=5 cols=35 size="10240" >${requestScope.PayMoneyAllCompensate.REASON }</textarea>
				 	<bean:message bundle="pageResources" key="page.roleCompensate.common.wordLength512"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr1"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	 <input type="checkbox" name="commitFlag" value="1" <c:if test="${requestScope.commitFlag == '1' }">checked</c:if> /><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="compensateId" type="hidden" value="${requestScope.PayMoneyAllCompensate.COMPENSATE_ID }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.submit"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>