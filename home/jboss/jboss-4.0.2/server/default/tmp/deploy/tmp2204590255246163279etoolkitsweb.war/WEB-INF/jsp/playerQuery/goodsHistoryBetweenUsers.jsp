<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/goodsHistoryBetweenUsers"/>
	<script type="text/javascript">
		function nextPage(curPage){
			if(isNum(curPage)){
				document.getElementById('curPage').value=curPage;
				document.forms[0].submit();
			}else{
				alert('<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.errPage"/>');
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.roleLog }">
		<html:form action="goodsHistoryBetweenUsers.do" method="post" onsubmit="return validateGoodsHistoryBetweenUsersForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.role1"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName1" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.role2"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName2" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate" />：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="curPage" value="1" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	<c:if test="${not empty requestScope.roleLog }">
	<html:form action="goodsHistoryBetweenUsers.do" method="post" onsubmit="return validateGoodsHistoryBetweenUsersForm(this);">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="7" align="center" ></td>
		</tr>
		<tr>
			<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.title"/> </td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.fromRole"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.toRole"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.itemId"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.itemName"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.itemUnm"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryBetweenUsers.time"/></td>
		</tr>
			<c:forEach items="${requestScope.roleLog.list}" var="goodsHistoryBetweenUsers" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${goodsHistoryBetweenUsers.formRole }"/></td>
					<td align="center" class="t_border_l"><c:out value="${goodsHistoryBetweenUsers.toRole }"/></td>
					<td align="center" class="t_border_l">${goodsHistoryBetweenUsers.itemId }</td>
					<td align="center" class="t_border_l">${goodsHistoryBetweenUsers.itemName }</td>
					<td align="center" class="t_border_l">${goodsHistoryBetweenUsers.itemCount }</td>
					<td align="center" class="t_border_r">${goodsHistoryBetweenUsers.time }</td>
				</tr>
			</c:forEach>
		<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="7">
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="hidden" name="roleName1" value="${roleName1 }"/>
					<input type="hidden" name="roleName2" value="${roleName2 }"/>
					<input type="hidden" name="startTime" value="${startTime }"/>
					<input type="hidden" name="endTime" value="${endTime }"/>
					<input type="hidden" name="curPage" id="curPage"/>
					<c:if test="${requestScope.roleLog.page>1 }"><a href="javascript:void(0)" onclick="nextPage('${requestScope.roleLog.page-1 }');"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="javascript:void(0)" onclick="nextPage(document.getElementById('toPage').value);">GO</a>
					<a href="javascript:void(0)" onclick="nextPage('${requestScope.roleLog.page+1 }');"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.roleLog.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</html:form>
	</c:if>
	</body>
</html>