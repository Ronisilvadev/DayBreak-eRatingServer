<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/getOrderDetail"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.orderDetail}">
		<html:form action="getOrderDetail.do" method="post" onsubmit="return validateGetOrderDetailForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.title"/></td>
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
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.orderId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="orderId" type="text" style="width:200px" value="${requestScope.orderId }" />
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
	
	<c:if test="${not empty requestScope.orderDetail}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="11" align="center" ></td>
			</tr>
			<tr>
				<td colspan="11" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.titleInfo"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.orderId"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.chargeTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.chargeAmount"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.chargeIp"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.game"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.subject"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.channel"/> </td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.state"/> </td>
				
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.orderId}
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.passportId}
				</td>
				<td align="center" class="t_border_l">
					<c:out value="${requestScope.orderDetail.passportName}"/>
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${requestScope.orderDetail.chargeTime}" pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.chargeAmount}
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.ip}
				</td>
				<td align="center" class="t_border_l">
				<!-- 游戏 -->
				${gameId }
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.gatewayId}
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.chargeSubjectId}
				</td>
				<td align="center" class="t_border_l">
					${requestScope.orderDetail.chargeChannelId}
				</td>
				<td align="center" class="t_border_r">
					${requestScope.orderDetail.dealState}
				</td>
				
			</tr>
			<tr height="30px">
				<td colspan="11" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</c:if>
</body>
</html>