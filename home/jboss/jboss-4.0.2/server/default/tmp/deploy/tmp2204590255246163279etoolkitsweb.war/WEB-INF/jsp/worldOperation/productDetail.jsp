<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>

</head>

<body bgcolor="#ffffff">
	<form action="stopSettingExp.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="6"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="6"><bean:message bundle="pageResources" key="page.worldOperation.productDetail.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.productDetail.productId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operSettingExp.executiveTime"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operSettingExp.stopTime"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.productDetailList}" var="productDetail" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					${productDetail.productId}
				</td>
				<td align="center" class="t_border_l">
					${productDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					${productDetail.serverId}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${productDetail.executiveTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<gmweb:productState2Text state="${productDetail.state}" />
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${productDetail.stopTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="6">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showProduct.do'"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${ requestScope.action == 'showIssueSettingExp'}">
						<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.productDetail.eRating"/>" />
					</c:if>
					<input type="hidden" name="productId" value="${requestScope.productId}" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>