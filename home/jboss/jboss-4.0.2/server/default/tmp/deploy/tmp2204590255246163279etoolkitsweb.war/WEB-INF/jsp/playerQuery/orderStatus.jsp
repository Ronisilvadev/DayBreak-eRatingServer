<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/getOrderStatus"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.orderStatus || requestScope.orderStatus == -1}">
		<html:form action="getOrderStatus.do" method="post" onsubmit="return validateGetOrderStatusForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.orderId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="orderId" type="text" style="width:200px" value="${requestScope.orderId }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.orderStatus && requestScope.orderStatus != -1}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.titleInfo"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderId"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/> </td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l">
					${requestScope.orderId}
				</td>
				<td align="center" class="t_border_r">
					<c:if test="${requestScope.orderStatus == 0}">
						<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.noCharge"/>
					</c:if>
					<c:if test="${requestScope.orderStatus == 1}">
						<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.butnoCharge"/>
					</c:if>
					<c:if test="${requestScope.orderStatus == 2}">
						<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.chargeOK"/>
					</c:if>
					<c:if test="${requestScope.orderStatus == 3}">
						<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.noState"/>
					</c:if>
					<c:if test="${requestScope.orderStatus == 4}">
						<bean:message bundle="pageResources" key="page.playerQuery.orderStatus.chargeBack"/>
					</c:if>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="10" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showQueryOrderStatus.do'"/>
		</div>
	</c:if>
</body>
</html>