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
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="5" align="center" ></td>
		</tr>
		<tr>
			<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistory.title"/></td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/> </td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.fromRole"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.toRole"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.actionRemark"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.actionTime"/></td>
		</tr>
		<c:if test="${not empty requestScope.goodsHistoryList }">
			<c:forEach items="${requestScope.goodsHistoryList}" var="goodsHistory" varStatus="status">
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${goodsHistory.fromRoleName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${goodsHistory.toRoleName }"/> </td>
					<td align="center" class="t_border_l">${goodsHistory.actionType }</td>
					<td align="center" class="t_border_l">${goodsHistory.actionTime }</td>
				</tr>
			</c:forEach>
		</c:if>
		<tr height="5px">
			<td colspan="5" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
  </body>
</html>
