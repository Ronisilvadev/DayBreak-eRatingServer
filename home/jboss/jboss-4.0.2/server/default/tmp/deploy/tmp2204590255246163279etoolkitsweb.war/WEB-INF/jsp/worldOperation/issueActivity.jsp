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

		<c:if test="${not empty requestScope.pageInfo}">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr height="30px">
					<td colspan="7" align="left"><c:if test="${ownerType eq 2 }">
						<font color="red" size="3"><b>${tipmsg }</b></font>
					</c:if></td>
				</tr>
				<tr>
					<td colspan="7" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.title"/> 
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.activityId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.gameName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.activityName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.charingActivity.isAllServerOrNot"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>
					</td>
					
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="activity" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${activity.activityId}
						</td>
						<td align="center" class="t_border_l">
							${activity.gameName }
						</td>
						<td align="center" class="t_border_l">
							${activity.activityName }
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${activity.gatewayType == 0}"><!-- 是 全服-->
								<bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart2"/>
							</c:if>
							<c:if test="${activity.gatewayType != 0}"><!-- 是 -->
								<bean:message bundle="pageResources" key="page.worldOperation.activitySetting.isRestart1"/>
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${activity.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${activity.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_r">
							<a href="showActivityDetail.do?activityId=${activity.activityId}&action=showIssueActivity"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
							<c:if test="${ownerType == '2'}">
								<a href="showSynchronizationActivityGames.do?activityId=${activity.activityId}"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/></a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="showIssueActivity.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.addActivity"/>" onclick="window.location.href='showAddActivity.do'" />
				</td>
				<td colspan="6" align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.historyActivity"/>" onclick="window.location.href='showHistoryActivity.do'" />
				</td>
			</tr>
			</table>
			<c:if test="${ownerType == '2'}">
				<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  				<tr>
  				<td align="left"><a href="#" onclick="window.location.href='showAddRelationGames.do';"><bean:message bundle="pageResources" key="page.common.configRelationGames"/></a></td>
  				</tr>
  				</table>
			</c:if>
			<br />
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
