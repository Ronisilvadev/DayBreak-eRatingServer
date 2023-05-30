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
	<form action="cancelBulletin.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.title1"/></td>
			</tr>
			<c:if test="${not empty requestScope.IssueBulletinCompensate }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.titleName"/></td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.title }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.gatewayId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.serverId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>：</td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${requestScope.IssueBulletinCompensate.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>：</td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${requestScope.IssueBulletinCompensate.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.intervals"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.intervals }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.bulletinContent"/></td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.content }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.totalTimes"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.totalTimes }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>：</td>
				<td align="center" class="t_border_r"><gmweb:bulletinAndExpState2Text state="${requestScope.IssueBulletinCompensate.state}" /></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.operatorName"/>：</td>
				<td align="center" class="t_border_r">${requestScope.IssueBulletinCompensate.operatorName}&nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.booking"/>：</td>
				<td align="center" class="t_border_r"><c:if test="${requestScope.IssueBulletinCompensate.booking == 0}"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking0"/></c:if><c:if test="${requestScope.IssueBulletinCompensate.booking == 1}"><bean:message bundle="pageResources" key="page.worldOperation.addBulletin.booking1"/></c:if> &nbsp;</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.result"/>：</td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.IssueBulletinCompensate.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		<gmweb:createCompenOperButton operType="${requestScope.oper}" actionName="worldOperation" operatorName="${requestScope.IssueBulletinCompensate.operatorName}" passportName="${sessionScope.userInfo.passportName}" compensateId="${requestScope.compensateId}" methodType="IssueBulletinCompensate" />
		<c:if test="${requestScope.oper == 'exed' }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="8"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="8"><bean:message bundle="pageResources" key="page.worldOperation.operBulletin.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.bulletinId"/>
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
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.worldOperation.operBulletin.cancelTime"/>
				</td>
			</tr>
			
			<c:forEach items="${requestScope.bulletinDetailList}" var="bulletinDetail" varStatus="status">
			
			<tr height="23px">
				<td align="center" class="t_border_l">
					${bulletinDetail.bulletinId}
				</td>
				<td align="center" class="t_border_l">
					${bulletinDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					${bulletinDetail.serverId}
				</td>
				<td align="center" class="t_border_l">
					${bulletinDetail.executiveTimes}
				</td>
				<td align="center" class="t_border_l">
					${bulletinDetail.successTimes}
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${bulletinDetail.lastExecuteTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
				<td align="center" class="t_border_l">
					<gmweb:bulletinAndExpState2Text state="${bulletinDetail.state}" />
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${bulletinDetail.cancelTime}" pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
				</td>
			</tr>
			</c:forEach>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="8">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.operBulletin.cancelBulletin"/> " />
					<input type="hidden" name="bulletinId" value="${requestScope.compensateId }" />
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
				<c:if test="${not empty requestScope.IssueBulletinCompLogList }">
				<c:forEach items="${requestScope.IssueBulletinCompLogList}" var="IssueBulletinCompLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${IssueBulletinCompLog.APPROVAL_NUM}" />
						</td>
						<td align="center" class="t_border_l">${IssueBulletinCompLog.OPERATOR_NAME }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${IssueBulletinCompLog.APPROVAL_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${IssueBulletinCompLog.APPROVAL_COMMENT }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${IssueBulletinCompLog.APPROVAL_RESULT}" />
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