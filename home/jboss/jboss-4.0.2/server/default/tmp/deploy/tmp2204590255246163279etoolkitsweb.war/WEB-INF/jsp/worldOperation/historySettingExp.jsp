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
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="11" align="center"></td>
				</tr>
				<tr>
					<td colspan="11" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.historySettingExp.title"/>
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
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.historySettingExp.stopOperName"/>
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
						<td align="center" class="t_border_l">
							${settingExp.stopOperName }&nbsp;
						</td>
						<td align="center" class="t_border_r">
							<a href="operSettingExp.do?changeId=${settingExp.changeId}&gatewayId=${settingExp.gatewayId}&action=showHistorySettingExp"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="11" align="center" class="t_border">
				<form name="pageForm" action="showHistorySettingExp.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />		
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="11" align="left">
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showIssueSettingExp.do'" />
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
