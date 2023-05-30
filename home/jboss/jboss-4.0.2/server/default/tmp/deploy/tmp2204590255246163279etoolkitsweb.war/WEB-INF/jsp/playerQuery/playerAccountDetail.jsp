<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/getPlayerAccountDetail"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.accountDetailList }">
		<html:form action="getPlayerAccountDetail.do" method="post" onsubmit="return validateGetPlayerAccountDetailForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.internal}">
				<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.game"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gameId" style="width:200px">
				 	<c:forEach var="game" items="${requestScope.games}">
				 		<option value="${game.gameId }" <c:if test="${game.gameId == sessionScope.gameId }">selected</c:if>>${game.gameName }</option>
				 	</c:forEach>
				 	</select>
				 	<input type="hidden" value="${internal }" name="internal"></input>
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="playerName" type="text" style="width:200px" value="${requestScope.playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
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
	
	<c:if test="${not empty requestScope.accountDetailList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "<c:out value="${playerName }"/>" <bean:message bundle="pageResources" key="page.playerQuery.accountDetail.accountDetail"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.gateway"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.jinquan"/> </td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.yinquan"/> </td>
			</tr>
		<c:forEach items="${requestScope.accountDetailList}" var="accountDetail">
			<tr height="23px">
				<td align="center" class="t_border_l">
					<c:if test="${not empty accountDetail.ratingName }">
						${accountDetail.ratingName}
					</c:if>
					<c:if test="${empty accountDetail.ratingName }">
						<c:if test="${accountDetail.ratingId == 0}">
							<bean:message bundle="pageResources" key="page.playerQuery.accountDetail.nofenqu"/>
						</c:if>
						<c:if test="${accountDetail.ratingId != 0}">
							${accountDetail.ratingId}
						</c:if>
					</c:if>
				</td>
				<td align="center" class="t_border_l">
					<c:if test="${accountDetail.subjectId == 3}">
						${accountDetail.amount}
					</c:if>
					<c:if test="${accountDetail.subjectId == 4}">
						0
					</c:if>
					<c:if test="${accountDetail.subjectId != 3 and accountDetail.subjectId != 4}">
						0
					</c:if>
					
				</td>
				<td align="center" class="t_border_r">
					<c:if test="${accountDetail.subjectId == 4}">
						${accountDetail.amount}
					</c:if>
					<c:if test="${accountDetail.subjectId == 5}">
						${accountDetail.amount}
					</c:if>
					<c:if test="${accountDetail.subjectId == 3}">
						0
					</c:if>
					<c:if test="${accountDetail.subjectId != 3 and accountDetail.subjectId != 4}">
						0
					</c:if>
				</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="3" align="center" class="t_border">&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryPlayerAccountDetail.do<c:if test="${not empty internal}">?internal=${internal }</c:if>'"/>
		</div>
	</c:if>
</body>
</html>