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
		function isInt(strInt) {
			if (strInt == null) return false;
			var re=/^\d{1,1}$/
			return re.test(strInt);
		}
		
		function check(){
			
				return true;
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="<c:if test="${ requestScope.oper == 'synchronization'}">synchronizationProduct.do</c:if><c:if test="${ requestScope.oper == 'start'}">startProduct.do</c:if><c:if test="${ requestScope.oper == 'end'}">endProduct.do</c:if>" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<c:if test="${ requestScope.oper == 'start'}">
						<bean:message bundle="pageResources" key="page.worldOperation.operProduct.title1"/>
					</c:if>
					<c:if test="${ requestScope.oper == 'end'}">
						<bean:message bundle="pageResources" key="page.worldOperation.operProduct.title2"/>
					</c:if>
					<c:if test="${ requestScope.oper == 'synchronization'}">
						<bean:message bundle="pageResources" key="page.worldOperation.operProduct.title3"/>
					</c:if>
				</td>
			</tr>
			<c:if test="${ requestScope.oper == 'synchronization'}">
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.productCode"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	${ requestScope.product.productCode}
				 	<input name="productCode" type="hidden" value="${ requestScope.product.productCode}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_name"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	${ requestScope.product.productName}
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_type"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	${ requestScope.product.useType}
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.state"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<gmweb:productState2Text state="${product.state}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<fmt:formatDate value="${ requestScope.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<input name="endTime" type="text"  value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm"/>" readonly />
				 </td>
			</tr>
			</c:if>
			<c:if test="${ requestScope.oper == 'start' || requestScope.oper == 'end'}">
				<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<select name="gatewayId" style="width:200px">
						<option value="0"><bean:message bundle="pageResources" key="page.worldOperation.common.allGateway"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			</c:if>
			<c:if test="${ requestScope.oper == 'start'}">
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_location"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="position" type="text" value="${ requestScope.position}" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.addProduct.locationDesc"/>
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input type="hidden" name="productId" value="${ requestScope.product.productId}" />
					<input type="submit" value="<c:if test="${ requestScope.oper == 'synchronization'}"><bean:message bundle="pageResources" key="page.worldOperation.operProduct.sychro"/> </c:if><c:if test="${ requestScope.oper == 'start'}"> <bean:message bundle="pageResources" key="page.worldOperation.operProduct.title1"/> </c:if><c:if test="${ requestScope.oper == 'end'}"> <bean:message bundle="pageResources" key="page.worldOperation.operProduct.title2"/> </c:if>" />&nbsp;&nbsp;
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