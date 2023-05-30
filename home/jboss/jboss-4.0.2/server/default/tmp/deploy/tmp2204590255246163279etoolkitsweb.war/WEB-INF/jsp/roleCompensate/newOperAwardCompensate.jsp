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
			<c:if test="${not empty requestScope.awardCompensate }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.gatewayId"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.gatewayId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.activityId"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.activityId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.passportNames"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.passportNames }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.items"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.items }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.beginTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.awardCompensate.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.endTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.awardCompensate.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.reason }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName"/></td>
				<td align="center" class="t_border_r">${requestScope.awardCompensate.operatorName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.awardCompensate.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>

		<div align="center">
			<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenOperButtonTag.tag1'/>"
				onclick="window.location.href='showNewAwardCompensate.do'" />		
			&nbsp&nbsp			
			<c:if test="${requestScope.type==1}">
			<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenOperButtonTag.tag2'/>"
				onclick="window.location.href='showNewEditAwardCompensate.do?compensateId=${compensateId }'" />
			&nbsp &nbsp
			<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenOperButtonTag.tag3'/>"
				onclick="window.location.href='submitNewAwardCompensate.do?compensateId=${compensateId }'" />
			&nbsp &nbsp
			<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenOperButtonTag.tag4'/>"
				onclick="window.location.href='delNewAwardCompensate.do?compensateId=${compensateId }'" />
			&nbsp &nbsp
			</c:if>			
			<c:if test="${requestScope.type==4}">
			  <input type="button" value="<bean:message bundle='pageResources' key='page.tag.ApprovalNum2TextTag.tag3'/>"
                onclick="window.location.href='newExeAwardCompensate.do?compensateId=${compensateId }'" />
			</c:if>
		</div>

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
				<c:if test="${not empty requestScope.awardCompensateLogList }">
				<c:forEach items="${requestScope.awardCompensateLogList}" var="awardCompensateLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${awardCompensateLog.approvalNum}" />
						</td>
						<td align="center" class="t_border_l">${awardCompensateLog.operatorName }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${ awardCompensateLog.approvalTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${awardCompensateLog.approvalComment }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${awardCompensateLog.approvalResult}" />
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