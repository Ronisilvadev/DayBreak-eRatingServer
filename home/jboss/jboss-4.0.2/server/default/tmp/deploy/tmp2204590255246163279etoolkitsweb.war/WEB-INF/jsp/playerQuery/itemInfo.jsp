<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/getRoleDetailInfo"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.infoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.itemInfo.title"/></td>
			</tr>
			<c:forEach items="${requestScope.infoList}" var="infoDetail">
			<tr height="23px">
				<td align="right" class="t_border_l" width="45%">${infoDetail.name}：</td>
				<td align="center" class="t_border_r">${infoDetail.value}</td>
			</tr>
			</c:forEach>
	
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);"/>
		</div>
	</c:if>
	</body>
</html>