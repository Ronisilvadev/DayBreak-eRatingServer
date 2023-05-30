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

		<c:if test="${not empty requestScope.pageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="10" align="center"></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.title"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l" width="15%">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.changeId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expRate"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.operatorName"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="settingExp" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${settingExp.changeId}
						</td>
						<td align="center" class="t_border_l">
							<gmweb:gatewayId2Text2 gatewayId="${settingExp.gatewayId }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:serverId2Text2 serverId="${settingExp.serverId }" />
						</td>
						<td align="center" class="t_border_l">
							${settingExp.expType }
						</td>
						<td align="center" class="t_border_l">
							${settingExp.expRate }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${settingExp.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${settingExp.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:bulletinAndExpState2Text state="${settingExp.state}" />
						</td>
						<td align="center" class="t_border_l">
							${settingExp.operatorName }
						</td>
						<td align="center" class="t_border_r">
							<form name="args" action="operSettingExp.do" method="post">
								<input type="hidden" name="changeId" value="${settingExp.changeId}" />
								<input type="hidden" name="gatewayId" value="${settingExp.gatewayId}" />
								<input type="hidden" name="serverId" value="${settingExp.serverId }" />
								<input type="hidden" name="expType" value="${settingExp.expTypeCode }" />
								<input type="hidden" name="action" value="showIssueSettingExp" />
								<a onmouseover="this.style.cursor='hand'" onclick="submit()"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
							</form>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="showIssueSettingExp.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.addSettingExp"/>" onclick="window.location.href='showAddSettingExp.do'" />
				</td>
				<td colspan="5" align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.showHistory"/>" onclick="window.location.href='showHistorySettingExp.do'" />
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
