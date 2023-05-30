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
	<script type="text/javascript">
		function nextPage(curPage){
			if(isNum(curPage)){
				document.getElementById('curPage').value=curPage;
				document.forms[0].submit();
			}else{
				alert('<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.errPage"/>');
			}
		}
		
		function searchSubmit(obj){
				var roleName = document.getElementById("roleName").value;
				if (roleName == "") {
					alert('<bean:message bundle="pageResources" key="page.common.roleName"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
					document.forms[0].roleName.focus();
					return false;
				}
				obj.action = "logManage.do?method=showRoleOperLog";
				obj.method = "post";
				obj.submit();
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="recoverRoleItem.do" method="post" onsubmit="return validateRecoverRoleItemForm(this);">
		<input type="hidden" value="${requestScope.oper }" name="oper"/> 
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><c:if test="${empty requestScope.oper }"><bean:message bundle="pageResources" key="page.roleOperate.roleItem.title"/></c:if><c:if test="${not empty requestScope.oper }"><bean:message bundle="pageResources" key="page.playerQuery.roleItem.title"/></c:if></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:150px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="roleName" id="roleName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.roleItem.itemId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="itemId" value="0">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="startTime" value="<fmt:formatDate value="${startTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="endTime" value="<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
					<input name="search" type="button" onclick="searchSubmit(document.forms[0]);" value="<bean:message bundle="pageResources" key="page.common.searchLog"/>" />
				</td>
			</tr>
		</table>
		<input type="hidden" name="type" value="0"/>
		<input type="hidden" name="curPage" value="1" />
		<input type="hidden" name="page" value="1" />
		<input type="hidden" name="operType" value="1" />
		</html:form>		
	</c:if>
	
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
	</div>
	<c:if test="${not empty requestScope.pageInfo }">
	<html:form action="recoverRoleItem.do" method="post" onsubmit="return validateRecoverRoleItemForm(this);">
	<input type="hidden" value="${requestScope.oper }" name="oper"/> 
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="20" align="center" ><br /></td>
		</tr>
		<tr>
			<td colspan="20" align="center" class="t_head"> <br /></td>
		</tr>
		<c:forEach items="${requestScope.pageInfo.list}" var="parentInfo" varStatus="parStatus">
			<tr height="23px">			
			<c:forEach items="${parentInfo}" var="childInfo" varStatus="childStatus">								
				<td align="center" class="t_border_r"><nobr><c:out value="${childInfo}"/>&nbsp;</nobr></td>
				<c:if test="${childStatus.index == 3}">
				<c:choose>
					<c:when test="${parStatus.index == 0}">
						<c:if test="${empty oper or oper eq ''}"><td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td></c:if>
					</c:when>
					<c:otherwise>
						<c:if test="${empty oper or oper eq ''}"><td align="center" class="t_border_r"><a href="recoverRoleItem.do?type=1&queryItemId=${commonParamPojo.itemId}&curPage=${commonParamPojo.page }&roleId=${commonParamPojo.roleId}&roleName=${commonParamPojo.roleName}&gatewayId=${commonParamPojo.gatewayId}&startTime=${parentInfo[1]}&itemId=${parentInfo[2]}&endTime=${commonParamPojo.endTime }"><bean:message bundle="pageResources" key="page.roleOperation.queryResumeRole.resume"/></a></td></c:if>
					</c:otherwise>
				</c:choose>
				</c:if>
			</c:forEach>			
			</tr>
		</c:forEach>
		<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="20">
					<input type="hidden" name="gatewayId" value="${commonParamPojo.gatewayId }"/>
					<input type="hidden" name="roleName" value="${commonParamPojo.roleName }"/>
					<input type="hidden" name="itemId" value="${commonParamPojo.itemId}"/>
					<input type="hidden" name="startTime" value="${commonParamPojo.startTime }"/>
					<input type="hidden" name="endTime" value="${commonParamPojo.endTime }"/>
					<input type="hidden" name="type" value="${commonParamPojo.type }"/>
					<input type="hidden" name="curPage" id="${commonParamPojo.page }"/>
					<c:if test="${requestScope.pageInfo.page>1 }"><a href="#" onclick="nextPage('${requestScope.pageInfo.page-1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="#" onclick="nextPage(document.getElementById('toPage').value); return false;">GO</a>
					<a href="#" onclick="nextPage('${requestScope.pageInfo.page+1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.pageInfo.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
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