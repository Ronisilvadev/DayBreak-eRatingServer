<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/func.js"></script>
	<title></title>
	<html:javascript formName="/clearStorage"/>
</head>

<body bgcolor="#ffffff">
<c:if test="${empty requestScope.clearStorageList }">
		<html:form action="clearStorage.do" method="post" onsubmit="return validateClearStorageForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.clearStorage.title"/></td>
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
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.role"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:230px" /> 
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</html:form>
</c:if>
<c:if test="${not empty requestScope.clearStorageList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="5" align="center" ></td>
				</tr>
				<tr>
					<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.clearStorage.info"/></td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.itemId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemName"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemNum"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.clearStorage.itemDesc"/></td>
				</tr>
				<c:forEach items="${requestScope.clearStorageList}" var="clearStorage" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l">${clearStorage.itemId }</td>
					<td align="center" class="t_border_l">${clearStorage.itemName }</td>
					<td align="center" class="t_border_l">${clearStorage.itemNum }</td>
					<td align="center" class="t_border_r">${clearStorage.itemDesc }</td>
				</tr>
				</c:forEach>
				<tr height="5px">
					  	<td colspan="5" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
	</table>
</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>