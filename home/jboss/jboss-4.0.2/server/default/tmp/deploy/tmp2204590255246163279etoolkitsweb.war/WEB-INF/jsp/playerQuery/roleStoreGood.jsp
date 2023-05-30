<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/getRoleStoreGood"/>
	<script type="text/javaScript">
			function gotoPage(obj){
				obj.submit();
			}
			
		</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.goodList }">
		<html:form action="getRoleStoreGood.do" method="post" onsubmit="return validateGetRoleStoreGoodForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleStoreGood.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<gmweb:createGatewayOption name="gatewayId" checkedValue="${ requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.serverId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="serverId" style="width:150px">
					</select>
					<script language="JavaScript">
						sel = new ESelect();
						sel.setElement(document.all.serverId);
						<c:forEach items="${requestScope.serverList}" var="server">
							sel.add('${server.gatewayId }', '${server.serverId }', '${server.serverId }-${server.serverName }');	
						</c:forEach>
						document.all.gatewayId.onchange = function()
						{
							sel.set(this.value);
						}
						sel.set(document.all.gatewayId.value);
						var s = document.forms[0].serverId;
						for   (i=0; i < s.length;i++)   
							{   
							  	if   (s[i].value == '${requestScope.serverId}')   
							  {   
								 s[i].selected = true;
							  }   
						 	} 
					</script>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/></td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:230px" /> 
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>

	</c:if>
	
	<c:if test="${not empty requestScope.goodList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="5" align="center" ></td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.roleSelf"/> "<c:out value="${roleName}"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleStoreGood.store"/></td>
			</tr>
			
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.code"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.roleStoreGood.storeRemart"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>
			</tr>
			<c:forEach items="${requestScope.goodList}" var="stroage">
			<tr height="23px">
				<td align="center" class="t_border_l">${stroage.code }</td>
				<td align="center" class="t_border_l">${stroage.name }</td>
				<td align="center" class="t_border_l">${stroage.num }</td>
				<td align="center" class="t_border_l">${stroage.desc }</td>
				<td align="center" class="t_border_r"><a href="userItemInStorage.do?gatewayId=${gatewayId }&serverId=${serverId }&roleId=${roleId }&itemId=${stroage.code }"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.detail"/></a></td>
			</tr>
			</c:forEach>
			
			<tr height="30px">
				<td colspan="5" align="center" class="t_border">
				<form name="pageForm" action="getRoleStoreGood.do" method="post">
					<input name="roleName" value="${roleName }" type="hidden"/>
					<input name="serverId" value="${serverId }" type="hidden"/>
					<input name="gatewayId" value="${gatewayId }" type="hidden"/>
				</form>
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</c:if>
	<div align="center">
		<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
	</div>
	</body>
</html>