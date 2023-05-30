<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
	<head>
		<title>蓝港在线欢迎您</title>

		<script type="text/javascript">
		function returnPage(){
				history.go(-1);
			}		
		</script>
		<link rel="stylesheet" href="css/jspMain.css" type="text/css" media="all" />
	</head>
	<body background="images/bk02.png">
		<table width="670" border="0" align="center">
			<tr>
				<td	style="height:90px;font-size:14px;font-weight:bold;color:#000000">
					<font color="red" size="3px">${msg }</font>
					<input type="button" onclick="returnPage()" value="<bean:message bundle="pageResources" key="page.roleOperation.common.back"/>" />
				</td>
			</tr>
		</table>
	</body>
</html>
