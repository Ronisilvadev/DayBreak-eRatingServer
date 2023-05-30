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
     			obj.action = "showResourceManage.do";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "showResourceManage.do";
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
					//全选对删除按钮的disabled属性的影响 
					frm.deleteButton.disabled = false;
				}else{
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.selectAll"/>";
					//全选对删除按钮的disabled属性的影响 
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
	<form action="delResource.do" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.common.searchTitle"/></td>
			</tr>
			<tr height="30px">
				<td width="75%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left">
					<bean:message bundle="pageResources" key="page.purview.common.searchKeyWord"/>：
				  	<input name="keyWord" type="text" value="${keyWord }" style="width:200px" id="keyWord"/>
				 </td>
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.purview.common.search"/>" onclick="searchSubmit(document.forms[0]);"/>
				</td>
			</tr>
		</table>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.resourceManage.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceName"/></td>
				<td width="25%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceDesc"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceType"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceParent"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/></td>
			</tr>
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="resourceInfo">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					<input name="resId" type="checkbox" value="${resourceInfo.resId }" onClick="uncheckAll(document.forms[0]);" />
				</td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="menuResources" key="${resourceInfo.resName }"/></td>
				<td width="25%" align="center" class="t_border_l">&nbsp;<bean:message bundle="menuResources" key="${resourceInfo.resDesc }"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="${resourceInfo.strResourceType }"/></td>
				<td width="15%" align="center" class="t_border_l">&nbsp;<c:if test="${not empty resourceInfo.parentResourceName }"><bean:message bundle="menuResources" key="${resourceInfo.parentResourceName }"/></c:if> </td>
				<td width="20%" align="center" class="t_border_r">
					<a href="showResourceModify.do?resId=${resourceInfo.resId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>&nbsp;
					<a href="delResource.do?resId=${resourceInfo.resId }" onclick="return confirmDel();">
					<bean:message bundle="pageResources" key="page.common.del"/></a>
				</td>
			</tr>
			</c:forEach>
			</c:if>
			<tr height="30px">
			  	<td colspan="6" align="center" class="t_border">&nbsp;&nbsp;
			  		<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onclick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="add" type="button" value= "<bean:message bundle="pageResources" key="page.common.add"/>" onclick="javascript:document.location.href='showResourceAdd.do';"/>&nbsp;&nbsp;
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
