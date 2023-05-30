<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
	<!--
			function confirmDel(){
				return confirm('<bean:message bundle="pageResources" key="page.worldOperation.alertInfo.del"/>');
			}
			
			function gotoPage(obj){
				var page = obj.page.options[obj.page.selectedIndex].value;
     			obj.reset();
     			obj.action = "showOnlineGm.do";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "showOnlineGm.do";
				obj.method = "post";
				obj.page.value = 1;
				obj.submit();
			}
			
			function checkAll(frm) 
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.worldOperation.common.allSelect"/>') 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.worldOperation.common.del"/>'){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == '<bean:message bundle="pageResources" key="page.worldOperation.common.allSelect"/>'){
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.worldOperation.common.del"/>';
					frm.deleteButton.disabled = false;
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.worldOperation.common.allSelect"/>';
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
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.worldOperation.common.del"/>';
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.worldOperation.common.allSelect"/>';
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
		<form action="delOnlineGm.do" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.title"/></td>
			</tr>
			<tr height="30px">
				<td width="75%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.keyWord"/>
				  		<input name="keyWord" type="text" value="${keyWord }" style="width:200px" />
				  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				  <c:if test="${requestScope.searchType == 'passportName' }">
				  		<input type="radio" name="searchType" value="realName" /><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.playerName"/>
				  		<input type="radio" name="searchType" value="passportName" checked /><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.passportName"/>
				  </c:if>
				  <c:if test="${requestScope.searchType != 'passportName' }">
				  		<input type="radio" name="searchType" value="realName" checked /><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.playerName"/>
				  		<input type="radio" name="searchType" value="passportName" /><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.passportName"/>
				  </c:if>
				</td>
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.title"/>" onclick="return searchSubmit(document.forms[0]);"/>
				</td>
			</tr>
		</table>

		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.title2"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.productSort.select"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.playerName"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.passportName"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.eMail"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.createTime"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/></td>
			</tr>
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="onlineGm">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					<input name="gmId" type="checkbox" value="${onlineGm.gmId }" onclick="uncheckAll(document.forms[0]);" />
				</td>
				<td width="15%" align="center" class="t_border_l">${onlineGm.realName }</td>
				<td width="15%" align="center" class="t_border_l">
					${onlineGm.passportName }
				</td>
				<td width="20%" align="center" class="t_border_l">${onlineGm.email }</td>
				<td width="20%" align="center" class="t_border_l"><fmt:formatDate value="${onlineGm.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td width="20%" align="center" class="t_border_r">
					<a href="showOnlineGmModify.do?gmId=${onlineGm.gmId }"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/></a>&nbsp;
					<a href="delOnlineGm.do?gmId=${onlineGm.gmId }" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.del"/></a>&nbsp;
					<a href="showModifyOnlineGmIp.do?gmId=${onlineGm.gmId }"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.IP"/></a>
				</td>
			</tr>
			
			</c:forEach>
			</c:if>
			<tr height="30px">
				<td colspan="6" align="center" class="t_border">
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.allSelect"/>" onclick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="add" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.onlineGm.add"/>" onclick="javascript:document.location.href='showOnlineGmAdd.do';" />&nbsp;&nbsp;
					<input name="deleteButton" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.onlineGm.del"/>" disabled onclick="return confirmDel();"/>&nbsp;&nbsp;	
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
