<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
</head>

<body bgcolor="#ffffff">
	<form action="stopSettingExp.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.title1"/></td>
			</tr>
			<c:if test="${not empty requestScope.IssueSettingExpCompensate }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.changeId"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueSettingExpCompensate.changeId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>：</td>
				<td align="center" class="t_border_r"><gmweb:gatewayId2Text2 gatewayId="${requestScope.IssueSettingExpCompensate.gatewayId }" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>：</td>
				<td align="center" class="t_border_r"><gmweb:serverId2Text2 serverId="${requestScope.IssueSettingExpCompensate.serverId }" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expType"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueSettingExpCompensate.expType }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expRate"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueSettingExpCompensate.expRate }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>：</td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${requestScope.IssueSettingExpCompensate.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${requestScope.IssueSettingExpCompensate.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>：</td>
				<td align="center" class="t_border_r"><gmweb:bulletinAndExpState2Text state="${requestScope.IssueSettingExpCompensate.state}" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.operatorName"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueSettingExpCompensate.operatorName}&nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addSettingExp.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.IssueSettingExpCompensate.reason}&nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.booking"/>：</td>
				<td align="center" class="t_border_r"><c:if test="${requestScope.IssueSettingExpCompensate.booking == 0}"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking0"/></c:if><c:if test="${requestScope.IssueSettingExpCompensate.booking == 1}"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking1"/></c:if> &nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.result"/>：</td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.IssueSettingExpCompensate.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		<gmweb:createCompenOperButton operType="${requestScope.oper}" actionName="worldOperation" operatorName="${requestScope.IssueSettingExpCompensate.operatorName}" passportName="${sessionScope.userInfo.passportName}" compensateId="${requestScope.compensateId}" methodType="IssueSettingExpCompensate" />
		<c:if test="${requestScope.oper == 'exed' }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="6"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="6"><bean:message bundle="pageResources" key="page.worldOperation.operBulletin.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.changeId"/>
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
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.operSettingExp.stopTime"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.SettingExpDetailList}" var="SettingExpDetail" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					${SettingExpDetail.changeId}
				</td>
				<td align="center" class="t_border_l">
					${SettingExpDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					${SettingExpDetail.serverId}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${settingExpDetail.executiveTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<gmweb:bulletinAndExpState2Text state="${settingExpDetail.state}" />&nbsp;
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${settingExpDetail.stopTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
			</tr>
			</c:forEach>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="6">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.operSettingExp.stop"/> " />
					<input type="hidden" name="changeId" value="${requestScope.compensateId }" />
					<input type="hidden" name="expType" value="${requestScope.expType }" />
					<input type="hidden" name="serverId" value="${requestScope.serverId }" />
				</td>
			</tr>
		</table>
		</c:if>
		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.title2"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalNum"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName2"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalComment"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult2"/></td>
				</tr>
				<c:if test="${not empty requestScope.IssueSettingExpCompLogList }">
				<c:forEach items="${requestScope.IssueSettingExpCompLogList}" var="IssueSettingExpCompLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${IssueSettingExpCompLog.APPROVAL_NUM}" />
						</td>
						<td align="center" class="t_border_l">${IssueSettingExpCompLog.OPERATOR_NAME }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${IssueSettingExpCompLog.APPROVAL_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${IssueSettingExpCompLog.APPROVAL_COMMENT }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${IssueSettingExpCompLog.APPROVAL_RESULT}" />
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		</form>	
	</body>
</html>