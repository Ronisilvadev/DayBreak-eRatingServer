<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="WEB-INF/jsp/inc/taglibs.jsp"%>
<html>
	<head>
		<title></title>

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
				<td	style="height:90px;font-size:14px;font-weight:bold;color:#FF0000">
					<c:if test="${not empty requestScope.errMsg }">
						${requestScope.errMsg }
					</c:if>
					<c:if test="${empty requestScope.errMsg }">
						<bean:message bundle="pageResources" key="page.error.errorInfo"/>
					</c:if>
					<input type="button" onclick="returnPage()" value="<bean:message bundle="pageResources" key="page.common.back"/>" />
				</td>
			</tr>
		</table>
	</body>
</html>
