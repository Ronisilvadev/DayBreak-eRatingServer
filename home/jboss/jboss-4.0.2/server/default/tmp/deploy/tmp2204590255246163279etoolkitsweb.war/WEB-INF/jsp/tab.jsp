<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>切换登录</title>
</head>
<body style="MARGIN: 5px" scroll=no bgcolor="#ffffff">
<form method="post" action="login.do?method=tabLogin" target="_top">
<div align="center">
	<bean:message bundle="pageResources" key="page.tab.loginTab"/>：
	<select name="gameId">
		<c:forEach items="${requestScope.gameList}" var="game">
			<option value="${game.gameId }" <c:if test="${requestScope.gameId == game.gameId }">selected </c:if>>${game.gameName }</option>
		</c:forEach>
	</select>
	&nbsp;&nbsp;
	<select name="region">
		<option value="1" <c:if test="${requestScope.region == 1 }">selected </c:if>><bean:message bundle="pageResources" key="page.login.gateway1"/></option>
		<option value="0" <c:if test="${requestScope.region == 0 }">selected </c:if>><bean:message bundle="pageResources" key="page.login.gateway2"/></option>
	</select>
	&nbsp;&nbsp;
	<input class="button_01" type="submit" value="<bean:message bundle="pageResources" key="page.tab.tab"/>" />
</div>
</form>
</body>
</html>
