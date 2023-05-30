<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
		</script>
	</head>

	<body bgcolor="#ffffff">
		<c:if test="${not empty requestScope.pageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="10" align="center"></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.product.title"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
				
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.productCode"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.productName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.useType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.price"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.product.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="product">
					<tr height="23px" title="<bean:message bundle="pageResources" key="page.worldOperation.product.productTitle"/>${product.productName}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.productDesc"/>${product.productDesc}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.insertOperName"/>${product.insertOperName}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.startOperName"/>${product.startOperName}&#13<bean:message bundle="pageResources" key="page.worldOperation.product.endOperName"/>${product.endOperName}">
						<td align="center" class="t_border_l">
							${product.productCode}
						</td>
						<td align="center" class="t_border_l">
							${product.productName}
						</td>
						<td align="center" class="t_border_l">
							<gmweb:productType2Text productType="${product.useType }" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${product.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${product.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${product.state != 1 }">
								<a href="showProductPrice.do?productId=${product.productId}&productCode=${product.productCode}"><bean:message bundle="pageResources" key="page.worldOperation.product.priceDetail"/></a>
								
							</c:if>
							&nbsp;
						</td>
						<td align="center" class="t_border_r">
							<c:if test="${product.state == 1 }">
								<a href="showSynchronizationProduct.do?productId=${product.productId}"><bean:message bundle="pageResources" key="page.worldOperation.product.eRating"/></a>&nbsp;&nbsp;								
							</c:if>
							<c:if test="${product.state != 1}">
								<a href="showStartProduct.do?productId=${product.productId}"> <bean:message bundle="pageResources" key="page.worldOperation.product.start"/></a>
								<a href="showEndProduct.do?productId=${product.productId}"><bean:message bundle="pageResources" key="page.worldOperation.product.stop"/></a>
								<a href="showProductInfo.do?productId=${product.productId}&productCode=${product.productCode}&productState=${product.state}"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
                                <c:if test="${requestScope.ownertype == 1}"> 
								<a href="synchronizGame.do?productId=${product.productId}"><bean:message bundle="pageResources" key="page.worldoperation.product.synchronizGame"/></a>
							    </c:if> 
							</c:if>								
							<a href="showModifyProduct.do?productId=${product.productId}&productCode=${product.productCode}"><bean:message bundle="pageResources" key="page.worldOperation.product.update"/></a>
							
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="showProduct.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td align="left" colspan="10">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.product.addProduct"/>" onclick="window.location.href='showAddProduct.do'" />&nbsp;&nbsp;
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.product.productSort"/>" onclick="window.location.href='showProductSort.do'" />&nbsp;&nbsp; 
				</td>
			</tr>
			</table>
			
			<br />
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
