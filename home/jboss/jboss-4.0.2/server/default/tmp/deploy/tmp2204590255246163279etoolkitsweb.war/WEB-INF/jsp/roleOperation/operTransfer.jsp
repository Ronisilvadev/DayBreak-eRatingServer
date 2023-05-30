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
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.operTransfer.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.transfer }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.passportName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.transfer.outGateway2"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.fromGatewayId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.transfer.inGateway2"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.toGatewayId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.transfer.transferID2"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.orderId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.common.reason2"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.reason }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.proposer2"/></td>
				<td align="center" class="t_border_r">${requestScope.transfer.operatorName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.state"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.transfer.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		
		<gmweb:createCompenOperButton operType="${requestScope.oper}" actionName="roleOperation" operatorName="${requestScope.transfer.operatorName}" passportName="${sessionScope.userInfo.passportName}" compensateId="${requestScope.compensateId}" methodType="Transfer" />
			
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.operClosePassCard.title2"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.Auditing"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.Auditer"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditContent"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.operModifyBindEmail.AuditResult"/></td>
				</tr>
				<c:if test="${not empty requestScope.transferLogList }">
				<c:forEach items="${requestScope.transferLogList}" var="transferLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${transferLog.approvalNum}" />
						</td>
						<td align="center" class="t_border_l">${transferLog.operatorName }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${ transferLog.approvalTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${transferLog.approvalComment }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${transferLog.approvalResult}" />
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