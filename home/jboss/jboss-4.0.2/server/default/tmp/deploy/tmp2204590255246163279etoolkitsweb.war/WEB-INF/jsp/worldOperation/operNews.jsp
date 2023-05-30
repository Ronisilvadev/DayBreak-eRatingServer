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
	<form action="cancelNews.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="8"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="8"><bean:message bundle="pageResources" key="page.worldOperation.operNews.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueNews.newsId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operBulletin.executiveTimes"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operBulletin.successTimes"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operBulletin.lastExecuteTime"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.operBulletin.cancelTime"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.newsDetailList}" var="newsDetail" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					${newsDetail.newsId}
				</td>
				<td align="center" class="t_border_l">
					${newsDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					${newsDetail.serverId}
				</td>
				<td align="center" class="t_border_l">
					${newsDetail.executiveTimes}
				</td>
				<td align="center" class="t_border_l">
					${newsDetail.successTimes}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${newsDetail.lastExecuteTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<gmweb:bulletinAndExpState2Text state="${newsDetail.state}" />
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${newsDetail.cancelTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
			</tr>
			
			</c:forEach>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="8">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='${requestScope.action }.do'"/>&nbsp;&nbsp;&nbsp;&nbsp;
					<c:if test="${ requestScope.action == 'showIssueNews'}">
						<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.operNews.cancelNews"/> " />
					</c:if>
					<input type="hidden" name="newsId" value="${requestScope.newsId }" />
					<input type="hidden" name="gatewayId" value="${requestScope.gatewayId }" />
					<input type=hidden name="action" value="${requestScope.action }" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>