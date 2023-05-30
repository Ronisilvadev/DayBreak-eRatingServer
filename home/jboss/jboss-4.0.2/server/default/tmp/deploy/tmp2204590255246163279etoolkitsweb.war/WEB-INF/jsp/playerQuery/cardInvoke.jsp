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
	<c:if test="${empty requestScope.cardList }">
		<form action="getInvokeCard.do" method="post" onsubmit="return validateCardInvokeForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playQuery.cardInvoke.title"/></td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.playerPassport"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="passportName">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${not empty requestScope.cardList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="20" align="center" ></td>
		</tr>
		<tr>
			<td colspan="20" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playQuery.cardInvoke.title"/></td>
		</tr>
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.cardNO"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operationTime"/></td>
		</tr>
		<c:forEach items="${requestScope.cardList}" var="cardInfo">
			<tr height="23px">			
			<td align="center" class="t_border_r">${cardInfo.cardNo}&nbsp;</td>
			<td align="center" class="t_border_r"><fmt:formatDate value="${cardInfo.operateTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>"  onclick="window.location.href='showInvokeCard.do'">
			</td>
		</tr>
	</table>
	</form>
	</c:if>
	
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>