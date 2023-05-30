<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
		<script type="text/javascript">		
			function gotoPage(obj){
				var page = obj.page.options[obj.page.selectedIndex].value;
     			obj.reset();
     			obj.action = "logManage.do?method=showRoleOperLog";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}	
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="logManage.do?method=showRoleOperLog" method="post" name="pageForm">
		<br />
		<br />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.log.roleOperation"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.operationName"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.operationTime"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.roleName"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.logManage.log.operDesc"/></td>
			</tr>
			<input type="hidden" name="roleName" id="roleName" value="${requestScope.roleName}"/>
			<input type="hidden" name="operType" id="operType" value="${requestScope.operType}"/>
			<c:if test="${not empty requestScope.pageInfo }">
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="logInfo">
			
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">${logInfo.passportName }</td>
				<td width="10%" align="center" class="t_border_l"><fmt:formatDate value="${logInfo.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td width="10%" align="center" class="t_border_l">${logInfo.roleName }</td>
				<td width="10%" align="center" class="t_border_l">${logInfo.gatewayId }</td>
				<td width="20%" align="center" class="t_border_r">&nbsp;${logInfo.operDesc }</td>
			</tr>
			</c:forEach>
			</c:if>
			</c:if>
			<tr height="30px">
			  	<td colspan="8" align="center" class="t_border">
			  		<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" /> 	
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
		</form>
	</body>
</html>
