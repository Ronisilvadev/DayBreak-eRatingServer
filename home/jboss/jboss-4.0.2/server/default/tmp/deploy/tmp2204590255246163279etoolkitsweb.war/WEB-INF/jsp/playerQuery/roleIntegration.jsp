<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
</head>


<body bgcolor="#ffffff">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center" ></td>
				</tr>
				<tr>
					<td align="center" class="t_head" colspan=4>
						<bean:message bundle="pageResources" key="page.playerQuery.roleIntegration.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleIntegration.passportId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleIntegration.pointtype"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.roleIntegration.point"/></td>
				</tr>
				<c:forEach items="${list}" var="info">
					<tr height="23px">
						<td align="center" class="t_border_l">${info.passportId }&nbsp;</td>
						<td align="center" class="t_border_l">${info.pointType }&nbsp;</td>
						<td align="center" class="t_border_r">${info.point }&nbsp;</td>
					</tr>
				</c:forEach>
				<tr>
					<td align="center" class="t_border" colspan=4>
						<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
					</td>
				</tr>
			</table>
</body>
</html>