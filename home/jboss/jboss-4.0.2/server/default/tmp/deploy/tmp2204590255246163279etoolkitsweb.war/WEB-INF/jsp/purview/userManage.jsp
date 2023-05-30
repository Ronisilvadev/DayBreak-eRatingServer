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
			function confirmDel(){
				return confirm("<bean:message bundle="pageResources" key="page.purview.common.confirmDel"/>");
			}
			
			function gotoPage(obj){
				var page = obj.page.options[obj.page.selectedIndex].value;
     			obj.reset();
     			obj.action = "showUserManage.do";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "showUserManage.do";
				obj.method = "post";
				obj.page.value = 1;
				obj.submit();
			}
			
			function checkAll(frm) 
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.selectAll"/>") 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.cancel"/>"){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.selectAll"/>"){
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.cancel"/>";
					frm.deleteButton.disabled = false;
				}else{
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.selectAll"/>";
					frm.deleteButton.disabled = true;
				}
			}
			
			function uncheckAll(frm) 
			{ 
				var TB=TO=0; 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox') 
					{ 
						TB++; 
						if (e.checked){
							TO++;
						} 
					} 
				}
				
				if (TB == TO){
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.cancel"/>";
				}else{
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.selectAll"/>";
				}
				
				if (0==TO)//全部未选中和选中一些时对删除按钮的disabled属性的影响 
				{ 
					frm.deleteButton.disabled = true; 
				} 
				else 
				{ 
					frm.deleteButton.disabled = false; 
				} 
				
			} 
		-->
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<c:if test="${not empty requestScope.pageInfo }">
		<form action="delUser.do" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.common.searchTitle"/></td>
			</tr>
			<tr height="30px">
				<td class="t_border" colspan="2" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left">
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
				
			</tr>
			
			
			<tr height="30px">
				<td class="t_border" colspan="2" style="border-bottom:#AEAEB0 1px solid;padding-left:00px" align="center">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.purview.common.search"/>" onclick="return searchSubmit(document.forms[0]);"/>
				</td>
				
			</tr>
			
		</table>

		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.userManage.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.realName"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.passport"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.email"/><bean:message bundle="pageResources" key="page.userManagement.showUserManagement.userLevel"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.userManage.createTime"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>
			</tr>
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="tempInfo">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					<c:if test="${tempInfo.userLv<10}">
					<input name="operId" type="checkbox" value="${tempInfo.operId }" onclick="uncheckAll(document.forms[0]);" />
					</c:if>
					<c:if test="${requestScope.userInfo.userLv>=30}">
						<c:if test="${tempInfo.userLv==20}">	
							<input name="operId" type="checkbox" value="${tempInfo.operId }" onclick="uncheckAll(document.forms[0]);" />
						</c:if>
					</c:if>
					&nbsp;
				</td>
				<td width="15%" align="center" class="t_border_l">
						${tempInfo.realName }&nbsp;&nbsp;&nbsp;
						<br/>						
						<c:if test="${tempInfo.userLv eq 30}"><font color="blue">(<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.gameAdmin"/>)</font></c:if>
						<c:if test="${tempInfo.userLv eq 20}"><font color="blue">(<bean:message bundle="pageResources" key="page.userManagement.showUserManagement.servicerAdmin"/>)</font></c:if>
				</td>
				<td width="15%" align="center" class="t_border_l">
					${tempInfo.passportName }
				</td>
				<td width="20%" align="center" class="t_border_l">${tempInfo.email}</td>
				<td width="20%" align="center" class="t_border_l"><fmt:formatDate value="${tempInfo.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td width="20%" align="center" class="t_border_r">
					<!--  如果是游戏管理员-->
					<c:if test="${requestScope.userInfo.userLv>=30}">
					    <!--  如果权限比游戏管理员低-->
						<c:if test="${tempInfo.userLv<30}">
							<a href="showUserModify.do?operId=${tempInfo.operId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>&nbsp;					
							<a href="delUser.do?operId=${tempInfo.operId }" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.common.del"/></a>&nbsp;	
							<a href="showUser2Role.do?operId=${tempInfo.operId }"><bean:message bundle="pageResources" key="page.purview.userManage.configRole"/></a>
						</c:if>
						<!--  如果也是游戏管理员-->
						<c:if test="${tempInfo.userLv>=30}">
						    <!-- 是本人的话，就可以修改-->
							<c:if test="${tempInfo.operId eq requestScope.userInfo.operId}">
					    		<a href="showUserModify.do?operId=${userInfo.operId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>&nbsp;
					 		</c:if>
					 		<!-- 否则，不可以-->
					 		<c:if test="${tempInfo.operId != requestScope.userInfo.operId}">
					    		<font color="gray"><bean:message bundle="pageResources" key="page.common.modify"/></font>&nbsp;
					 		</c:if>				
								<font color="gray"><bean:message bundle="pageResources" key="page.common.del"/></font>&nbsp;
								<font color="gray"><bean:message bundle="pageResources" key="page.purview.userManage.configRole"/></font>&nbsp;
						</c:if>
						
					</c:if>
					<!--  如果是客服总监-->
					<c:if test="${requestScope.userInfo.userLv>=20 and requestScope.userInfo.userLv<30}">
					    <!--  如果权限比客服总监低 -->
						<c:if test="${tempInfo.userLv<20}">
							<a href="showUserModify.do?operId=${tempInfo.operId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>&nbsp;					
							<a href="delUser.do?operId=${tempInfo.operId }" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.common.del"/></a>&nbsp;	
							<a href="showUser2Role.do?operId=${tempInfo.operId }"><bean:message bundle="pageResources" key="page.purview.userManage.configRole"/></a>				
						</c:if>
						<!--  如果权限比客服总监高 -->
						<c:if test="${tempInfo.userLv>=20}">
							<c:if test="${tempInfo.operId eq requestScope.userInfo.operId}">
					    		<a href="showUserModify.do?operId=${userInfo.operId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>&nbsp;
					 		</c:if>
					 		<c:if test="${tempInfo.operId != requestScope.userInfo.operId}">
					    		<font color="gray"><bean:message bundle="pageResources" key="page.common.modify"/></font>&nbsp;
					 		</c:if>				
								<font color="gray"><bean:message bundle="pageResources" key="page.common.del"/></font>&nbsp;
								<font color="gray"><bean:message bundle="pageResources" key="page.purview.userManage.configRole"/></font>&nbsp;					
						</c:if>
						
					</c:if>					

					<br/>

				</td>
			</tr>
			
			</c:forEach>
			</c:if>
			<tr height="30px">
				<td colspan="6" align="center" class="t_border">
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onclick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="add" type="button" value="<bean:message bundle="pageResources" key="page.common.add"/>" onclick="javascript:document.location.href='showUserAdd.do';" />&nbsp;&nbsp;
					<input name="deleteButton" type="submit" value="<bean:message bundle="pageResources" key="page.common.del"/>" disabled onclick="return confirmDel();"/>&nbsp;&nbsp;	
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
