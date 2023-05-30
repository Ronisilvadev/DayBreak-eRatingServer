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
	<html:javascript formName="/roleExpLog"/>
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
       <c:if test="${empty requestScope.roleYueli}">
		<form action="getRoleYueli.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleyueli.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<select name="gatewayId" style="width:150px">
					     <c:forEach items = "${requestScope.gatewayList}" var = "gateway">
								<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
					     </c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="roleName"></input>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.operationType"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<select name="operType">
						<c:forEach items="${requestScope.dicList }" var="dic">
							<option value="${dic.opValue }">${dic.opValue } - ${dic.opText }></option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="startTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<fmt:formatDate value="${ requestScope.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="endTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					<!-- 
				 	<input type="text" name="endTime" value="<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				    -->
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="curPage" value="1" />
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
	</c:if>
	<c:if test="${not empty requestScope.roleYueli}">
		<form action="getRoleYueli.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="20"><bean:message bundle="pageResources" key="page.playerQuery.roleyueli.title"/></td>
			</tr>
			<tr class="h_CDE4F6">
			<c:forEach items="${requestScope.roleYueli.list }" var="logList" varStatus="status" begin="${fn:length(requestScope.roleYueli.list)-1 }">
				<c:forEach items="${logList }" var="log" varStatus="status">
					<td align="center" class="t_border_l" >${log.text }</td>
				</c:forEach>
			</c:forEach>
			</tr>
			<c:forEach items="${requestScope.roleYueli.list }" var="logList">
			<tr>
				<c:forEach items="${logList }" var="log" varStatus="status">
					<td align="center" class="t_border_l" >${log.value }</td>
				</c:forEach>
			</tr>
			</c:forEach>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="20">
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="hidden" name="roleName" value="${roleName }"/>
					<input type="hidden" name="operType" value="${operType }"/>
					<input type="hidden" name="startTime" value="${startTime }"/>
					<input type="hidden" name="endTime" value="${endTime}"/>
					<input type="hidden" name="curPage" id="curPage"/>
					<c:if test="${requestScope.roleYueli.page>1 }"><a href="#" onclick="nextPage('${requestScope.roleYueli.page-1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="#" onclick="nextPage(document.getElementById('toPage').value); return false;">GO</a>
					<a href="#" onclick="nextPage('${requestScope.roleYueli.page+1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.roleYueli.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	<form>	
	</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
</body>
</html>