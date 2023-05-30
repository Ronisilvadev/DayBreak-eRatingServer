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
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.freezeHistoryInfo.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.logID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.freezeHistoryInfo.passportID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.freezeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.freezeUntilTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.freezeOper"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeOper"/></td>
			</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="freezeInfo" varStatus="status">
				<tr height="23px" title="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.freezeReason"/>${freezeInfo.reason }">
						<td align="center" class="t_border_l">${freezeInfo.logId }&nbsp;</td>
						<td align="center" class="t_border_l">${freezeInfo.passportId }&nbsp;</td>
						<td align="center" class="t_border_l"><c:if test="${freezeInfo.state == '3'}"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.state1"/></c:if><c:if test="${freezeInfo.state == '4'}"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.state2"/></c:if><c:if test="${freezeInfo.state == '5'}"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.state3"/></c:if>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${freezeInfo.freezeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${freezeInfo.unFreezeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l">${freezeInfo.lastSeconds }&nbsp;</td>
						<td align="center" class="t_border_l">${freezeInfo.operatorName }&nbsp;</td>
						<td align="center" class="t_border_r">${freezeInfo.unFreezeOperName }&nbsp;</td>
					</tr>
				</c:forEach>
				<tr height="30px">
					<td colspan="8" align="center" class="t_border">
					<form name="pageForm" action="getHistoryInfo.do?flag=freeze" method="post">
						<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					</form>
					</td>
				</tr>
				<tr height="30px">
					  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
	</body>
</html>