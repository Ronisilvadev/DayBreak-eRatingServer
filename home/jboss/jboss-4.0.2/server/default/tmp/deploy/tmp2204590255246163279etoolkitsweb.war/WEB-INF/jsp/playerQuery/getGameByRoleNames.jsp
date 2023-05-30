<%@ page language="java" import="java.util.*" pageEncoding="UTf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
  </head>
  <body  bgcolor="#ffffff">
    <c:if test="${not empty result}">
    		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center" ></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.getGameByRoleNames.title"/> </td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.getGameByRoleNames.roleName"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.game"/></td>
				</tr>
				
				<c:forEach items="${result}" var="ts">
				<tr height="23px">
					<td align="center" class="t_border_l">${ts.key }</td>
					<td align="center" class="t_border_r">${ts.value }</td>
				</tr>
				</c:forEach>
	
				<tr height="5px">
					  	<td colspan="9" align="center" class="t_border">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
			</table>
    </c:if>
    <c:if test="${empty result}">
    <!--
    	如果是空 则做表单 
     -->
     <form action="getGameByRoleNames.do" method="post">
  		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.getGameByRoleNames.title"/></td>
			</tr>
						
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.getGameByRoleNames.roleNameInput"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="roleNames" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.playerQuery.getGameByRoleNames.remark"/>
					</span> 
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>	
		<div align="center">
			<font color="red">
				${msg }
			</font>
		</div>     		
     </form>
   	</c:if>
  </body>
</html>
