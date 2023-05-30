<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/searchRole"/>
	<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="searchRole.do" method="post" onsubmit="return validateSearchRoleForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleSearch.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/></td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				 		<option value="0" selected>0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleKeyWord"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:200px" value="${requestScope.roleName }" />
				 	<bean:message bundle="pageResources" key="page.common.keyWordRemark"/>
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
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.roleSearch.roleIn"/> "<c:out value="${roleName}"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleSearch.result"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gameId"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleSearch.createGateway"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleSearch.roleStae"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleSearch.passport"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.inGateway"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="roleInfo" varStatus="status">
			<tr height="23px">
				<td align="center" class="t_border_l">${status.index + 1 }</td>
				<td align="center" class="t_border_l">
					${roleInfo.gameId }-
					<c:forEach items="${requestScope.gameMap}" var="gamePojo" varStatus="gameStatus">
						<c:if test="${roleInfo.gameId==gamePojo.key}">
							<c:out value="${gamePojo.value}"></c:out>
						</c:if>
					</c:forEach>
				</td>
				<td align="center" class="t_border_l"><c:out value="${roleInfo.roleName}"/></td>
				<td align="center" class="t_border_l">${roleInfo.gatewayId }</td>
				<td align="center" class="t_border_l">
					<gmweb:roleState2Text roleState="${roleInfo.roleState }" />&nbsp;
				</td>
				<td align="center" class="t_border_l"><c:out value="${roleInfo.passportName }"/></td>
				<td align="center" class="t_border_r">
					<gmweb:gatewayId2Text gatewayId="${roleInfo.userOnlineState }" />
				</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
				<form name="pageForm" action="searchRole.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input name="roleName" type="hidden" value="${requestScope.roleName }" />
					<input name="gatewayId" type="hidden" value="${requestScope.strGatewayId}" />
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showSearchRole.do'"/>
		</div>
	</c:if>
</body>
</html>