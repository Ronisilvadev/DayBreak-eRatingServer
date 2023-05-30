<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
   <link href="css/main.css" rel="stylesheet" type="text/css" />
   <html:javascript formName="/sendEmail"/>
  </head>
 
 	<body bgcolor="#ffffff">
  
  	<html:form action="sendEmail.do" method="post" onsubmit="return validateEmailForm(this);">
				<table width="90%" border="0" cellpadding="0" cellspacing="0"
					align="center">
					<tr>
						<td align="center" height="30PX"></td>
					</tr>
					<tr>
						<td align="center" class="t_head" colspan="2">
							<bean:message bundle="pageResources"
								key="page.roleOperation.sendEmail.title" />
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources" key="page.common.gatewayId" />
						</td>
						<td class="t_border_r" align="left">
							<select name="gatewayId" style="width: 200px">
								<c:forEach var="target" items="${requestScope.gatewayList}">
									<option value="${target.gatewayId }">
										${target.gatewayId} - ${target.gatewayName }
									</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.sendEmail.roleName" />
						</td>
						<td class="t_border_r" align="left">
							<textarea name="roleName" rows="5" cols="22"></textarea>&nbsp;<bean:message bundle="pageResources" key="page.roleOperation.sendEmail.roleNametip"/>
						</td>
					</tr>
					
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.sendEmail.emailTitle" />
						</td>
						<td class="t_border_r" align="left">
							<input type="text" name="title" style="width: 200px"/>
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.sendEmail.emailBody" />
						</td>
						<td class="t_border_r" align="left">
							<textarea rows="5" cols="22" size="200" name="body"></textarea>&nbsp;<bean:message bundle="pageResources" key="page.roleOpertion.sendEmail.bodyltMaxNumber"/>
						</td>
					</tr>
					<tr height="30px">
						<td width="35%" class="t_border_l" align="right">
							<bean:message bundle="pageResources"
								key="page.roleOperation.sendEmail.emailType" />
						</td>
						<td class="t_border_r" align="left">
							<input type="text" name="type" style="width: 200px" value="35" readonly="readonly"/>&nbsp;							<bean:message bundle="pageResources" key="page.roleOpertion.sendEmail.typeFromGame"/>
						</td>
					</tr>
					
					<tr height="30px">
						<td class="t_border_r" style="border-bottom: #AEAEB0 1px solid;"
							align="center" colspan="2">
							<input type="submit"
								value="<bean:message bundle="pageResources" key="page.roleOperation.sendEmail.send"/>" />
						</td>
					</tr>
				</table>
				<div align="center"><font color="red">${msg }</font></div>
			</html:form>
  </body>
</html>
