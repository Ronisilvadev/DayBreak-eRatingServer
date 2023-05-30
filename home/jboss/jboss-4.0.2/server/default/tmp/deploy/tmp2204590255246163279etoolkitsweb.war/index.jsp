<%@ page language="java" pageEncoding="UTF-8"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title></title>
	</head>
<body>
	<jsp:forward page="/login.do">
		<jsp:param name="method" value="showLogin"/>
	</jsp:forward>
</body>
</html>