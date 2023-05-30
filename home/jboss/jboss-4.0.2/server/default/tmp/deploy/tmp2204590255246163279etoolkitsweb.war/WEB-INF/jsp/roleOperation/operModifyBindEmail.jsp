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
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.modifyBindEmail }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/></td>
				<td align="center" class="t_border_r">${requestScope.modifyBindEmail.passportName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.email"/></td>
				<td align="center" class="t_border_r">${requestScope.modifyBindEmail.newEmail }</td>
			</tr>
			<tr>
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.createModifyBindEmail.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.modifyBindEmail.reason }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.proposer"/></td>
				<td align="center" class="t_border_r">${requestScope.modifyBindEmail.operatorName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.state"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.modifyBindEmail.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		
		<gmweb:createCompenOperButton operType="${requestScope.oper}" actionName="roleOperation" operatorName="${requestScope.modifyBindEmail.operatorName}" passportName="${sessionScope.userInfo.passportName}" compensateId="${requestScope.compensateId}" methodType="ModifyBindEmail" />
					
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.logInfo"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.Auditing"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.Auditer"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditContent"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditResult"/></td>
				</tr>
				<c:if test="${not empty requestScope.modifyBindEmailLogList }">
				<c:forEach items="${requestScope.modifyBindEmailLogList}" var="modifyBindEmailLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${modifyBindEmailLog.approvalNum}" />
						</td>
						<td align="center" class="t_border_l">${modifyBindEmailLog.operatorName }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${ modifyBindEmailLog.approvalTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${modifyBindEmailLog.approvalComment }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${modifyBindEmailLog.approvalResult}" />
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		
	</body>
</html>