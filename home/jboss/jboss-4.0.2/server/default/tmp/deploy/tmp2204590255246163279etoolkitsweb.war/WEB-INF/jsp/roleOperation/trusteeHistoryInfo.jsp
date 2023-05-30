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
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.logID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.freezeHistoryInfo.passportID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.state"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.resumeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeOper"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.resumeOper"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.IP"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.trusteeType"/></td>
			</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="trusteeInfo" varStatus="status">
				<tr height="23px" title="<bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.reason"/>${trusteeInfo.reason }">
						<td align="center" class="t_border_l">${trusteeInfo.logId }&nbsp;</td>
						<td align="center" class="t_border_l"><c:out value="${trusteeInfo.passportName }"/>&nbsp;</td>
						<td align="center" class="t_border_l"><c:if test="${trusteeInfo.state == '3'}"><bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.state1"/></c:if><c:if test="${trusteeInfo.state == '4'}"><bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.state2"/></c:if><c:if test="${trusteeInfo.state == '5'}"><bean:message bundle="pageResources" key="page.roleOperation.trusteHistoryInfo.state3"/></c:if>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${trusteeInfo.trusteeTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${trusteeInfo.restoreTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
						<td align="center" class="t_border_l">${trusteeInfo.operatorName }&nbsp;</td>
						<td align="center" class="t_border_l">${trusteeInfo.restoreOperName }&nbsp;</td>
						<td align="center" class="t_border_l">${trusteeInfo.allowIp }&nbsp;</td>
						<td align="center" class="t_border_r"><c:if test="${trusteeInfo.trusteeType == '0'}"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.loginTrustee"/></c:if><c:if test="${trusteeInfo.trusteeType == '1'}"><bean:message bundle="pageResources" key="page.roleOperation.queryTrusteePlayer.allTrustee"/></c:if>&nbsp;</td>
					</tr>
				</c:forEach>
				<tr height="30px">
					<td colspan="10" align="center" class="t_border">
					<form name="pageForm" action="getHistoryInfo.do?flag=trustee" method="post">
						<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					</form>
					</td>
				</tr>
				<tr height="30px">
					  	<td colspan="10" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
	</body>
</html>