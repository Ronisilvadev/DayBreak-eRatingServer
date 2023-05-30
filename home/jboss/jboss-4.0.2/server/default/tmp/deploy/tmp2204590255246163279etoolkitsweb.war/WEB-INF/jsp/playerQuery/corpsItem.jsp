<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	
</head>

<body bgcolor="#ffffff">	
	<c:if test="${not empty requestScope.corpsItemList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="20" align="center" ></td>
		</tr>
		<tr>
			<td colspan="20" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.corpsItem.title"/> </td>
		</tr>
		<c:forEach items="${requestScope.corpsItemList}" var="parentInfo">
			<tr height="23px">			
			<c:forEach items="${parentInfo}" var="childInfo">				
				<td align="center" class="t_border_r"><c:out value="${childInfo}"/>&nbsp;</td>
			</c:forEach>	
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>"   onclick="Javascript:history.back(-1);">
			</td>
		</tr>
	</table>
	</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>