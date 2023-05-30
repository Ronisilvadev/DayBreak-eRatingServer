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
					<td colspan="9" align="center"></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gameID"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/>
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
				<c:if test="${not empty requestScope.passportGatewayList }">
				<c:forEach items="${requestScope.passportGatewayList}" var="passportGateway">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${passportGateway.gameId }
						</td>
						<td align="center" class="t_border_l">
							${passportGateway.gatewayId }
						</td>
						<td align="center" class="t_border_l">
								${passportGateway.gatewayName }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${passportGateway.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${passportGateway.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
						<td align="center" class="t_border_r">
							<a href="showModifyPassportGateway.do?gatewayId=${passportGateway.gatewayId }&oldGatewayId=${passportGateway.original_gatewayId }&opFlag=modify"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/></a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
				<td colspan="9" align="center" class="t_border">
					<input type="button" onclick="window.location.href='showSynPassport.do'" value="<bean:message bundle="pageResources" key="page.common.syn"/>" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.onlineGm.add"/>" onclick="window.location.href='showAddPassportGateway.do' " />&nbsp;&nbsp;
				</td>
			</tr>
		</table>
			<br />
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
