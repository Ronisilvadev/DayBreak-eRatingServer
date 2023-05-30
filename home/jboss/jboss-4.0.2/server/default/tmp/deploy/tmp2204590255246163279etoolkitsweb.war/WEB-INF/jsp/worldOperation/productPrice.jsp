<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
		</script>
	</head>

	<body bgcolor="#ffffff">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="7" align="center"></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.productPrice.title"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
				
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.productPrice.priceId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.useType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.productPrice.priceOrigin"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.productPrice.priceDiscount"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.endTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.productPrice.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.productPriceList}" var="productPrice">
					<tr height="23px" title="<bean:message bundle="pageResources" key="page.worldOperation.product.insertOperName"/>${productPrice.insertOperName}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.startOperName"/>${productPrice.startOperName}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.endOperName"/>${productPrice.endOperName}">
						<td align="center" class="t_border_l">
							${productPrice.priceId}
						</td>
						<td align="center" class="t_border_l">
							<gmweb:subjectId2Text subjectId="${productPrice.subjectId}" />
						</td>
						<td align="center" class="t_border_l">
							${productPrice.priceOrigin}
						</td>
						<td align="center" class="t_border_l">
							${productPrice.priceDiscount}
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${productPrice.startTime }" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${productPrice.endTime }" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_r">
							<c:if test="${productPrice.state == 4 }">
								<a href="showSendProductPrice.do?priceId=${productPrice.priceId}&productCode=${productCode }"><bean:message bundle="pageResources" key="page.worldOperation.productPrice.sendPrice" /></a>
								<!-- <a href="showEndProductPrice.do?priceId=${productPrice.priceId}&eratingPriceId=${productPrice.eratingPriceId}&productCode=${productCode }"><bean:message bundle="pageResources" key="page.worldOperation.productPrice.stopPrice"/></a>-->
							</c:if>
							<c:if test="${productPrice.state != 4 }">
								<bean:message bundle="pageResources" key="page.worldOperation.productPrice.noStart"/>
							</c:if>
							&nbsp;
						</td>
					</tr>
				</c:forEach>
			<tr height="10px">
			  	<td colspan="7" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			<tr height="30px">
				<td align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.productPrice.addPrice"/>" onclick="window.location.href='showAddProductPrice.do?productCode=${requestScope.productCode }&productId=${requestScope.productId }'" />
				</td>
			</tr>
			</table>
			
			<br />
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
