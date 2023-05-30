<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/getPlayerInfoByIdCode"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.playerInfoList }">
		<html:form action="getPlayerInfoByIdCode.do" method="post" onsubmit="return validateGetPlayerInfoByIdCodeForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerInfoOfIdCode.title"/></td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.shenfenzheng"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="idCode" size="30"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.playerInfoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.queryResult"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerPassport"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.playerID"/></td>
			</tr>
		<c:forEach items="${requestScope.playerInfoList}" var="playerInfo">
			<tr height="23px">
					<td align="center" class="t_border_l"><c:out value="${playerInfo.playerName }"/>&nbsp;</td>
					<td align="center" class="t_border_r">
						<c:if test="${playerInfo.playerId == 0}">
							<font color="red"><bean:message bundle="pageResources" key="page.common.unbeknownPassport"/></font>
						</c:if>
						<c:if test="${playerInfo.playerId != 0}">
							${playerInfo.playerId } 
						</c:if>
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" onclick="window.location.href='showGetPlayerInfoByIdCode.do'" value="<bean:message bundle="pageResources" key="page.common.back"/>"/>
		</div>
	</c:if>
	</body>
</html>