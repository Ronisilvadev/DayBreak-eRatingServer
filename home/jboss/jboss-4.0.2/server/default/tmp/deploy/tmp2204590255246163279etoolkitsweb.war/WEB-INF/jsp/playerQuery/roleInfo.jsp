<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/getRoleDetailInfo"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.roleDetailList }">
		<html:form action="getRoleDetailInfo.do" method="post" onsubmit="return validateGetRoleDetailInfoForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<gmweb:createGatewayOption name="gatewayId" checkedValue="${ requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.serverId"/>：
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
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/>：</td>
				 <td class="t_border_r" align="left">
				 	<input name="roleName" type="text" style="width:230px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.type"/>：</td>
				 <td class="t_border_r" align="left">
				 	<select name="type">
				 		<option value="0"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.type0"/></option>
				 		<option value="1"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.type1"/></option>
				 		<option value="2"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.type2"/></option>
				 	</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.attrQuery"/>：</td>
				 <td class="t_border_r" align="left">
				 	<input name="roleAttr" type="checkbox" value="1" /><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.roleAttr"/>
				 	<input name="resistAttr" type="checkbox" value="1" /><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.resistAttr"/>
				 	<input name="reputationAttr" type="checkbox" value="1" /><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.reputationAttr"/>
				 	<br /><strong><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.warn"/></strong>
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
	
	<c:if test="${not empty requestScope.roleDetailList }">
		<c:if test="${type == 0 }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.roleSelf"/> "<c:out value="${roleName }"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleInfo.roleInfo"/></td>
			</tr>
			<c:forEach items="${requestScope.roleDetailList}" var="roleDetail">
			<tr height="23px">
				<td align="right" class="t_border_l" width="45%"><c:out value="${roleDetail.name}"/>：</td>
				<td align="center" class="t_border_r">${roleDetail.value}&nbsp;</td>
			</tr>
			</c:forEach>
	
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</c:if>
		<c:if test="${type == 1 }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="3" align="center" ></td>
			</tr>
			<tr>
				<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.roleSelf"/> "<c:out value="${roleName }"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleInfo.petInfo"/></td>
			</tr>
			<c:forEach items="${requestScope.roleDetailList}" var="roleDetail">
			<tr height="23px">
				<td align="right" class="t_border_l" width="45%"><c:out value="${roleDetail.name}"/>：</td>
				<td align="center" class="t_border_r" width="45%">${roleDetail.value}&nbsp;</td>
				<td align="center" class="t_border_r"><a href="petItemDetail.do?roleId=${roleId }&itemId=${roleDetail.id}&gatewayId=${gatewayId }&serverId=${serverId }&type=0"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.detail"/></a></td>
			</tr>
			</c:forEach>
	
		<tr height="30px">
			  	<td colspan="3" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</c:if>
		<c:if test="${type == 2 }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.roleSelf"/> "<c:out value="${roleName }"/>" <bean:message bundle="pageResources" key="page.playerQuery.roleInfo.mailInfo"/></td>
			</tr>
			<c:forEach items="${requestScope.roleDetailList}" var="mailDetail">
				<tr height="23px">
					<td align="right" class="t_border_l" width="45%"><c:out value="${mailDetail.name}"/>：</td>
					<td align="center" class="t_border_r">${mailDetail.value}&nbsp;</td>
				</tr>
			</c:forEach>
	
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</c:if>
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);"/>
		</div>
	</c:if>
	</body>
</html>