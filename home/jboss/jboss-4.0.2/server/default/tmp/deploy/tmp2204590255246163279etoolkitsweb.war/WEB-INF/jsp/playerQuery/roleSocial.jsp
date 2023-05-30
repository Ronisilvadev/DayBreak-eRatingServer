<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/queryRoleSocial"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.roleSocialList }">
		<html:form action="queryRoleSocial.do" method="post" onsubmit="return validateQueryRoleSocialForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleSocial.title"/></td>
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
				 	<input name="roleName" type="text" style="width:230px" /><bean:message bundle="pageResources" key="page.common.queryOnLine"/> 
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.type"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="type" style="width:70px">
				 		<option value="0" selected>0 - <bean:message bundle="pageResources" key="page.common.all"/></option>				  		
				 		<c:forEach items="${requestScope.socialTypeList }" var="dic">				 			
				 			<option value="${dic.opValue }">${dic.opValue } - ${dic.opText }</option>
				 		</c:forEach>
					</select>
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
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.roleSocialList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.roleSelf"/> "<c:out value="${roleName}"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleSocial.social"/></td>
			</tr>
			<c:forEach items="${requestScope.roleSocialList}" var="roleSocial" varStatus="state">
			<tr height="23px">
				<td align="right" class="t_border_l" width="45%"><c:out value="${roleSocial.name }"/></td>
				<td align="right" class="t_border_r" width="45%">${roleSocial.value }</td>
			</tr>
			</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);"/>
		</div>
	</c:if>
	</body>
</html>