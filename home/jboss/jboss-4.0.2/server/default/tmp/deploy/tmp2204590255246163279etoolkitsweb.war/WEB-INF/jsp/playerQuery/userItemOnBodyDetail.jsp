<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/func.js"></script>
	<title></title>
</head>

<body bgcolor="#ffffff">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="2" align="center" ></td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.userItemOnBody.title2"/> </td>
		</tr>
			<c:forEach items="${requestScope.userItemOnBodyDetailList}" var="userItemOnBodyDetail" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${userItemOnBodyDetail.name }</td>
					<td align="center" class="t_border_r">${userItemOnBodyDetail.value }</td>
				</tr>
			</c:forEach>
		<tr height="5px">
			<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center" >
				<input type="submit" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="Javascript:history.back(-1);" />
			</td>
		</tr>
	</table>
	</body>
</html>