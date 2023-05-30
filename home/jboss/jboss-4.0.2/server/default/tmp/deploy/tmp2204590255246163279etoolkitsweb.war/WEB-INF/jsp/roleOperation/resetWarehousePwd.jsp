<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javascript" src="js/func.js"></script>
		<script type="text/javascript">
			function validateForm (targetform) {
					var message = '';
					if(targetform.gatewayId.value == ''){
						message+='<bean:message bundle="pageResources" key="page.roleOperation.resetStorePwd.roleNamenotnull" />'+'\n' ;
					}
					if(targetform.serverId.value == ''){
						message+='<bean:message bundle="pageResources" key="page.roleOperation.resetStorePwd.gatewayIdnotnull" />' + '\n' ;
					}
					if(targetform.roleName.value == ''){
						message+='<bean:message bundle="pageResources" key="page.roleOperation.resetStorePwd.roleNamenotnull" />' ;
					}
					if(message!='')
					{
						alert (message) ;
						return false ;
					}
					return true ;
			} 
		</script>
	</head>
	<body bgcolor="#ffffff">
		<form action="resetStorePwd.do" method="post" onsubmit="return validateForm (this) ;">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr>
					<td align="center" height="30PX"></td>
				</tr>
				<tr>
					<td align="center" class="t_head" colspan="2">
						<bean:message bundle="pageResources"
							key="page.roleOperation.resetStorePwd.title" />
					</td>
				</tr>
				<tr height="30px">
					<td width="35%" class="t_border_l" align="right">
						<bean:message bundle="pageResources" key="page.common.gatewayId" /> :
					</td>
					<td class="t_border_r" align="left">
						<select name="gatewayId" style="width: 150px">
							<c:forEach items="${requestScope.gatewayList}" var="gateway">
								<option value="${gateway.gatewayId }">
									${gateway.gatewayId} - ${gateway.gatewayName}
								</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr height="30px">
					<td width="35%" class="t_border_l" align="right">
						<bean:message bundle="pageResources" key="page.common.serverId" /> :
					</td>
					<td class="t_border_r" align="left">
						<select name="serverId" style="width: 150px">
						</select>
						<script language="JavaScript">
						sel = new ESelect();
						sel.setElement(document.all.serverId);
						<c:forEach items="${requestScope.serverList}" var="server">
							sel.add('${server.gatewayId }', '${server.serverId }', '${server.serverId }-${server.serverName }');	
						</c:forEach>
						document.all.gatewayId.onchange = function()
						{
							sel.set(this.value) ;
						}
						sel.set(document.all.gatewayId.value);
						var s = document.forms[0].serverId;
						for(i=0; i < s.length;i++){   
							if(s[i].value == '${requestScope.serverId}'){   
								 s[i].selected = true;
							}   
						} 
					</script>
					</td>
				</tr>
				<tr height="30px">
					<td width="35%" class="t_border_l" align="right">
						<bean:message bundle="pageResources"
							key="page.roleOperation.resetStorePwd.roleName" />
					
					</td>
					<td class="t_border_r" align="left">
						<input name="roleName" type="text" style="width: 230px" />
					</td>
				</tr>

				<tr height="30px">
					<td class="t_border_r" style="border-bottom: #AEAEB0 1px solid;"
						align="center" colspan="2">
						<input type="submit"
							value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
					</td>
				</tr>
			</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>
