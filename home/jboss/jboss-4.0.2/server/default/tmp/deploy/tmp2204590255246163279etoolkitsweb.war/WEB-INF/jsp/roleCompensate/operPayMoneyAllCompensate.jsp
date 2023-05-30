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
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.title1"/></td>
			</tr>
			<c:if test="${not empty requestScope.PayMoneyAllCompensate }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operGoldCompensate.gatewayId"/></td>
				<td align="center" class="t_border_r">${requestScope.PayMoneyAllCompensate.GATEWAY_ID }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYTYPE"/>：</td>
				<td align="center" class="t_border_r"><c:if test="${requestScope.PayMoneyAllCompensate.MONEY_TYPE == 1}"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYTYPE1"/></c:if></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.paymoneyall.MONEYNUM"/>：</td>
				<td align="center" class="t_border_r">${requestScope.PayMoneyAllCompensate.MONEY_NUM }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.PayMoneyAllCompensate.REASON }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName"/></td>
				<td align="center" class="t_border_r">${requestScope.PayMoneyAllCompensate.OPERATOR_NAME }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.PayMoneyAllCompensate.APPROVAL_RESULT}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		
		<gmweb:createCompenOperButton operType="${requestScope.oper}" actionName="roleCompensate" operatorName="${requestScope.PayMoneyAllCompensate.OPERATOR_NAME}" passportName="${sessionScope.userInfo.passportName}" compensateId="${requestScope.compensateId}" methodType="PayMoneyAllCompensate" />
		
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
				<c:if test="${not empty requestScope.PayMoneyAllCompLogList }">
				<c:forEach items="${requestScope.PayMoneyAllCompLogList}" var="PayMoneyAllCompLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${PayMoneyAllCompLog.APPROVAL_NUM}" />
						</td>
						<td align="center" class="t_border_l">${PayMoneyAllCompLog.OPERATOR_NAME }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${PayMoneyAllCompLog.APPROVAL_TIME}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${PayMoneyAllCompLog.APPROVAL_COMMENT }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${PayMoneyAllCompLog.APPROVAL_RESULT}" />
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