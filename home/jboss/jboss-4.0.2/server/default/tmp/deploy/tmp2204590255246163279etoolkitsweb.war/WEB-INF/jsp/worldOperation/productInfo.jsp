<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
</head>
  
  <body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.proInfo }">
    	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.title"/></td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_id"/></td>
				<td class="t_border_r">${requestScope.proInfo.item_id }</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_name"/></td>
				<td class="t_border_r">${requestScope.proInfo.item_name }</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_location"/></td>
				<td class="t_border_r">${requestScope.proInfo.item_location }</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.description"/></td>
				<td class="t_border_r">${requestScope.proInfo.description}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.pay_type"/></td>
				<td class="t_border_r">${requestScope.proInfo.pay_type}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_type"/></td>
				<td class="t_border_r">${requestScope.proInfo.item_type}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_limit"/></td>
				<td class="t_border_r">${requestScope.proInfo.item_limit}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.price"/></td>
				<td class="t_border_r">${requestScope.proInfo.price}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.discount"/></td>
				<td class="t_border_r">${requestScope.proInfo.discount}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.start_time"/></td>
				<td class="t_border_r"><fmt:formatDate value="${requestScope.proInfo.start_time}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.sale_room"/></td>
				<td class="t_border_r">${requestScope.proInfo.sale_room}</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.on_sale"/></td>
				<td class="t_border_r">${requestScope.proInfo.on_sale}</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<a href="showProductPrice.do?productId=${productId}&productCode=${productCode}"><bean:message bundle="pageResources" key="page.worldOperation.product.priceDetail"/></a>
			<c:if test="${productState == 3 }">
				<a href="showStartProduct.do?productId=${productId}"><bean:message bundle="pageResources" key="page.worldOperation.product.start"/></a>
			</c:if>
			<c:if test="${productState == 5 }">
				<a href="showStartProduct.do?productId=${productId}"><bean:message bundle="pageResources" key="page.worldOperation.product.start"/></a>
			</c:if>
			<c:if test="${productState == 4 }">
				<a href="showEndProduct.do?productId=${productId}"><bean:message bundle="pageResources" key="page.worldOperation.product.stop"/></a>
			</c:if>
			<br>
				<input type="button" onclick="window.location.href='showProduct.do'" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>"/>&nbsp;&nbsp;&nbsp;
		</div>
	</c:if>
	<c:if test="${empty requestScope.proInfo }">
		<form action="productInfo.do" method="post" >
		<input type="hidden" name="productId" value="${productId }" />
		<input type="hidden" name="productName" value="${productName}"/>
		<input type="hidden" name="productCode" value="${productCode }" />
		<input type="hidden" name="productState" value="${productState }" />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.productInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				</td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
	</c:if>
  </body>
</html>
