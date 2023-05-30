<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javaScript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
			var passports = document.getElementById('passports').value;
			var IPs = document.getElementById('IPs').value;
			var sum = passports.trim() + IPs.trim();
			if(sum.length>0){
				return true;
			}else{
				alert('<bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.error"/>');
				return false;
			}
		}
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>

<body bgcolor="#ffffff">
	<form action="insertChargeCompensate.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.title"/></td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.passports"/> </td>
				<td class="t_border_r" align="left">
					<textarea name="passports" rows="5"></textarea><br><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.passportsInfo"/>
				</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.IPs"/> </td>
				<td class="t_border_r" align="left">
					<textarea name="IPs" rows="5"></textarea><br><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.IPsInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td align="center" class="t_border_r" align="left" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"/>
				</td>
			</tr>
			<tr height="10px">
			  	<td align="center" class="border_top" colspan="2">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</form>
	<div align="center">
			<font color="red" size="3px">${msg }</font>
	</div>
	<c:if test="${not empty requestScope.errorList}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.result"/></td>
			</tr>
		<c:forEach items="${requestScope.errorList}" var="error">
			<tr height="23px">
					<td align="center" class="t_border_l">${error }</td>
					<td align="center" class="t_border_r">
						<font color="red"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.unbeknownPassport"/></font>
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</c:if>
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.log"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.IP"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></td>
				</tr>
				<c:if test="${not empty requestScope.pageInfo }">
				<c:forEach items="${requestScope.pageInfo.infoList}" var="chargeCompensate" varStatus="state">
				<tr height="23px">
					<td align="center" class="t_border_l">${state.index + 1 }</td>
					<td align="center" class="t_border_l">${chargeCompensate.passport }&nbsp;</td>
					<td align="center" class="t_border_l">${chargeCompensate.ip }&nbsp;</td>
					<td align="center" class="t_border_r"><a href="delChargeCompensate.do?passport=${chargeCompensate.passport }&ip=${chargeCompensate.ip }&type=${chargeCompensate.type}"><bean:message bundle="pageResources" key="page.roleOperation.chargeCompensate.del"/></a></td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
					<td colspan="10" align="center" class="t_border">
					<form name="pageForm" action="showChargeCompensate.do" method="post">
						<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					</form>
					</td>
				</tr>
			</table>
	</body>
</html>