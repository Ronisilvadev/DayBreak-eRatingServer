<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
	<!--
			
			
			function gotoPage(obj){
				var page = obj.page.options[obj.page.selectedIndex].value;
     			obj.reset();
     			obj.action = "showRoleUsers.do?roleIdScope=${requestScope.roleIdScope} ";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "showRoleUsers.do?roleIdScope=${requestScope.roleIdScope}";
				obj.method = "post";
				obj.page.value = 1;
				obj.submit();
			}		
			
		-->
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<c:if test="${not empty requestScope.pageInfo }">
		<form action="" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
				<input name="roleId" type="hidden" value="${requestScope.roleIdScope}"/>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.common.searchTitle"/></td>
			</tr>
			<tr height="30px">
				<td width="75%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left">
					<bean:message bundle="pageResources" key="page.purview.common.searchKeyWord"/>：
				  		<input name="keyWord" type="text" value="${keyWord }" style="width:200px" />
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <c:if test="${requestScope.searchType == 'passportName' }">
				  		<input type="radio" name="searchType" value="realName" /><bean:message bundle="pageResources" key="page.purview.userManage.realName"/>
				  		<input type="radio" name="searchType" value="passportName" checked /><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>
				  </c:if>
				  <c:if test="${requestScope.searchType != 'passportName' }">
				  		<input type="radio" name="searchType" value="realName" checked /><bean:message bundle="pageResources" key="page.purview.userManage.realName"/>
				  		<input type="radio" name="searchType" value="passportName" /><bean:message bundle="pageResources" key="page.purview.userManage.passport"/>
				  </c:if>
				</td>
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.purview.common.search"/>" onclick="return searchSubmit(document.forms[0]);"/>
				</td>
			</tr>
		</table>

		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head">${requestScope.roleInfo.roleName}&nbsp;<bean:message bundle="pageResources" key="page.purview.roleManage.roleUserList"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.realName"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.email"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.createTime"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>
			</tr>
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="userInfo" varStatus="recordRank">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					${recordRank.index+1+requestScope.pageInfo.pageSize*(requestScope.pageInfo.currentPage-1)}
				</td>
				<td width="15%" align="center" class="t_border_l">${userInfo.realName }</td>
				<td width="15%" align="center" class="t_border_l">
					${userInfo.passportName }
				</td>
				<td width="20%" align="center" class="t_border_l">${userInfo.email }</td>
				<td width="20%" align="center" class="t_border_l"><fmt:formatDate value="${userInfo.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td width="20%" align="center" class="t_border_r">
					<a href="showUser2Role.do?operId=${userInfo.operId }&roleIdScope=${requestScope.roleIdScope}&operType=roleUsers"><bean:message bundle="pageResources" key="page.purview.userManage.configRole"/></a>
				</td>
			</tr>
			
			</c:forEach>
			</c:if>
			<tr height="30px">
				<td colspan="6" align="center" class="t_border">
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="javascript:history.go(-1);"/>	&nbsp;&nbsp;&nbsp;
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" /> 	
				</td>
			</tr>
			<c:if test="${empty requestScope.pageInfo.infoList }">
				<script type="text/javascript">
				<!--
					document.getElementById("selectAll").disabled = true;
					document.getElementById("page").disabled = true;
				-->
				</script>
			</c:if>
	
		</table>
		</form>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<script type="text/javascript">
				<!--
					document.getElementById("keyWord").focus();
					document.onkeydown = function(e){
						var event = window.event || e;
						if(event.keyCode == 13){
							searchSubmit(document.forms[0]);
						}
					}
				-->
		</script>
		
	</c:if>
	</body>
</html>
