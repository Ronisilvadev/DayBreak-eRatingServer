<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<html:javascript formName="/queryVipCard"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.vipCardList }">
		<html:form action="queryVipCard.do" method="post" onsubmit="return validateQueryVipCardForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.vipCardNum"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="vipCards" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.Remart"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.type"/>
				 </td>
				 <td class="t_border_l" align="left" colspan="2">
				 	<input type=text name="cardType"/>*
				 	<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.ps"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.vipCardList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="4" align="center" ></td>
			</tr>
			<tr>
				<td colspan="4" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.result"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNumState"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.vipCardPlayer"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.vipCardTime"/></td>
			</tr>
		<c:forEach items="${requestScope.vipCardList}" var="vipCard">
			<tr height="23px">
				<td align="center" class="t_border_l">${vipCard.cardNumber }</td>
				<td align="center" class="t_border_l"><gmweb:cardState2Text cardState="${vipCard.cardState}" /></td>
				<td align="center" class="t_border_l">${vipCard.playerName }&nbsp;</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${ vipCard.useTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
				</td>
			</tr>
		</c:forEach>
		
		<tr height="23px">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.sum"/></td>
			<td align="center" class="t_border_l">${requestScope.total}</td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.cardNum"/></td>
			<td align="center" class="t_border_r">${requestScope.useTotal}</td>
		</tr>
		<tr height="30px">
			  	<td colspan="4" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" onclick="window.location.href='showQueryVipCard.do'" value="<bean:message bundle="pageResources" key="page.common.back"/>"/>
		</div>
	</c:if>
	</body>
</html>