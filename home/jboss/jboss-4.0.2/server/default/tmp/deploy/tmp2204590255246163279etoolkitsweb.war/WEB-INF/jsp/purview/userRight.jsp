<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
	
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<c:if test="${not empty requestScope.operUserInfo }">
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.queryOperRight"/></td>
			</tr>			
			<tr height="30px">
				<td width="40%" class="t_border_l" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="right">
					<bean:message bundle="pageResources" key="page.logManage.log.passportName"/>&nbsp;
				</td>
				<td  class="t_border_r" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:00px" align="left">
					${requestScope.operUserInfo.passportName}
				</td>				
			</tr>
			<tr height="30px">
				<td width="40%" class="t_border_l" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="right">
					<bean:message bundle="pageResources" key="page.logManage.log.name"/>&nbsp;
				</td>
				<td  class="t_border_r" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:00px" align="left">
					${requestScope.operUserInfo.realName}
				</td>				
			</tr>
			<tr height="30px">
				<td width="40%" class="t_border_l" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="right">
					<bean:message bundle="pageResources" key="page.purview.userManage.email"/>&nbsp;
				</td>
				<td  class="t_border_r" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:00px" align="left">
					${requestScope.operUserInfo.email}
				</td>				
			</tr>
			<tr height="30px">
				<td width="40%" class="t_border_l" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="right">
					<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.userLevel"/>&nbsp;
				</td>
				<td  class="t_border_r" colspan="1" style="border-bottom:#AEAEB0 1px solid;padding-left:00px" align="left">
					
					<c:if test="${requestScope.operUserInfo.userLv eq 30}"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.gameAdmin"/></c:if>
					<c:if test="${requestScope.operUserInfo.userLv eq 20}"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdmin"/><br/>
					(<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdminTips"/>)</c:if>
					<c:if test="${requestScope.operUserInfo.userLv < 10}"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.ordinaryAdmin"/></c:if>
					
				</td>				
			</tr>
			
		</table>

		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.rightList"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.gameName"/></td>
				<td width="40%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.roleManage.title"/></td>
				<td width="40%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.specialRight"/></td>				
			</tr>
			<c:if test="${not empty requestScope.userRightList }">
			<c:forEach items="${requestScope.userRightList}" var="userRiht">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="20%" align="center" class="t_border">
					${userRiht.gameName}
					
					&nbsp;
				</td>
				<td width="40%" align="center" class="t_border">
					${userRiht.roleNames}
					&nbsp;
				</td>
				<td width="15%" align="center" class="t_border">					
					<c:if test="${userRiht.userLv eq 30}"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.gameAdmin"/></c:if>
					<c:if test="${userRiht.userLv eq 20}"><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdmin"/></c:if>
				</td>
				
			</tr>
			
			</c:forEach>
			</c:if>
			
	
		</table>
		
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<script type="text/javascript">
				
		</script>
		
	</c:if>
	</body>
</html>
