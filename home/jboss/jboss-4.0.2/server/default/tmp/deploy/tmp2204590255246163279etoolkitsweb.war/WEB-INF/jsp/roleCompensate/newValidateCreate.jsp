<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
</head>


<body bgcolor="#ffffff">                          
	
	<form action="<c:if test="${empty requestScope.isError }">saveNewAwardCompensate</c:if>
	<c:if test="${not empty requestScope.isError }"><c:if test="${requestScope.oper == 'add'}">showCreateAwardCompensate</c:if><c:if test="${requestScope.oper == 'edit'}">showEditAwardCompensate</c:if></c:if>.do" method="post">
	<c:if test="${not empty requestScope.itemInfoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="5" align="center" ></td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.itemCode"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.itemNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.beginDate"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.endDate"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.itemName"/></td>
			</tr>
		<c:forEach items="${requestScope.itemInfoList}" var="itemInfo">
			<tr height="23px">
					<td align="center" class="t_border_l" <c:if test="${itemInfo.itemNum == 0 }">style="color:red"</c:if>>
						${itemInfo.playerItemCode }
					</td>
					<td align="center" class="t_border_l" <c:if test="${itemInfo.itemNum == 0 }">style="color:red"</c:if>>
						${itemInfo.itemNum }
					</td>
					
					<td align="center" class="t_border_l" <c:if test="${itemInfo.itemNum == 0 }">style="color:red"</c:if>>
						${requestScope.beginDate }
					</td>
					<td align="center" class="t_border_r" <c:if test="${itemInfo.itemNum == 0 }">style="color:red"</c:if>>
						${requestScope.endDate }
					</td>
					<td align="center" class="t_border_r" <c:if test="${itemInfo.itemNum == 0 }">style="color:red"</c:if>>
					<c:if test="${not empty itemInfo.playerItemName}">${itemInfo.playerItemName }</c:if>
					<c:if test="${empty itemInfo.playerItemName}">-----</c:if>
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="5" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
	</c:if>
	
	<c:if test="${not empty requestScope.playInfoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.title2"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.playerName"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.playerID"/></td>
			</tr>
		<c:forEach items="${requestScope.playInfoList}" var="playInfo">
			<tr height="23px">
					<td align="center" class="t_border_l" <c:if test="${playInfo.playerId == 0 }">style="color:red"</c:if>>
						${playInfo.playerName }
					</td>
					
					<td align="center" class="t_border_r" <c:if test="${playInfo.playerId == 0 }">style="color:red"</c:if>>
						<c:if test="${playInfo.playerId == 0}"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.unKnownPlayer"/></c:if>
						<c:if test="${playInfo.playerId != 0}">${playInfo.playerId }</c:if>
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
	</c:if>
	
	<div align="center">
		<c:if test="${not empty requestScope.isError }">
			<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.back"/> "/>
		</c:if>
		<c:if test="${empty requestScope.isError }">
			<c:if test="${requestScope.commitFlag == '1' }">
				<input type="submit" value="<bean:message bundle='pageResources' key='page.roleOperation.createModifyBindEmail.submit2'/>"/>
			</c:if>
			<c:if test="${requestScope.commitFlag != '1' }">
				<input type="submit" value="<bean:message bundle='pageResources' key='page.common.save'/>"/>
			</c:if>
		</c:if>
	</div>
		<input name=gatewayId type="hidden" value="${requestScope.gatewayId }" />
		<input name="activityId" type="hidden" value="${requestScope.activityId }" />
		<input name="items" type="hidden" value="${requestScope.items }" />
		<input name="playerNames" type="hidden" value="${requestScope.playerNames }" />
		<input name="reason" type="hidden" value="${requestScope.reason }" />
		<input name="beginDate" type="hidden" value="${requestScope.beginDate }" />
		<input name="endDate" type="hidden" value="${requestScope.endDate }" />
		<input name="compensateId" type="hidden" value="${requestScope.compensateId }" />
		<input name="oper" type="hidden" value="${requestScope.oper }" />
		<input name="commitFlag" type="hidden" value="${requestScope.commitFlag }" />
	</form>
	
	</body>
</html>