<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
			/*
			function delSubmit(frm) 
			{ 
				frm.action = "dictionary.do?method=delGame";
				frm.method = "post";
				frm.submit();
			}*/
			
			function checkAll(frm) 
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.common.selectAll"/>') 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.common.cancel"/>'){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == '<bean:message bundle="pageResources" key="page.common.selectAll"/>'){
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.common.cancel"/>';
					//frm.deleteButton.disabled = false;
					frm.modifybutton.disabled = false; 
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.common.selectAll"/>';
					//frm.deleteButton.disabled = true;
					frm.modifybutton.disabled = true; 
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
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.common.cancel"/>';
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.common.selectAll"/>';
				}
				
				if (0==TO)//全部未选中和选中一些时对删除按钮的disabled属性的影响 
				{ 
					//frm.deleteButton.disabled = true; 
					frm.modifybutton.disabled = true; 
				} 
				else 
				{ 
					//frm.deleteButton.disabled = false; 
					frm.modifybutton.disabled = false; 
				} 
				
			} 
			
			function selectThis(frm,selectValue){
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && e.value == selectValue) 
					{ 
						e.checked = true; 
						//frm.deleteButton.disabled = false; 
						frm.modifybutton.disabled = false; 
						break;
					} 
				} 
				
			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="modifyGame.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="4" align="center"></td>
				</tr>
				<tr>
					<td colspan="4" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.dictionary.game.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.dictionary.game.gameId"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.dictionary.game.gameName"/>
					</td>
				</tr>
				<c:if test="${not empty requestScope.gameList }">
				<c:forEach items="${requestScope.gameList}" var="game" varStatus="status">
					<tr height="23px">
						<td width="10%" align="center" class="t_border_l">
							<input name="countId" type="checkbox" value="${status.index + 1 }" onclick="uncheckAll(document.forms[0]);" />
						</td>
						<td align="center" class="t_border_l">
							${game.gameId }
							<input name="gameId${status.index + 1 }" type="hidden" value="${game.gameId }"  />
						</td>
						<td align="center" class="t_border_r">
							<input name="gameName${status.index + 1 }" type="text" value="${game.gameName }" onclick="selectThis(document.forms[0],${status.index + 1});" />
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
				<td colspan="4" align="center" class="t_border">
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onClick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="modifybutton" type="submit" value="<bean:message bundle="pageResources" key="page.dictionary.game.save"/>" disabled/>&nbsp;&nbsp;	
					<!--  
					<input name="deleteButton" type="button" value="<bean:message bundle="pageResources" key="page.dictionary.game.delete"/>" onClick="delSubmit(document.forms[0]);" disabled/>&nbsp;&nbsp;
					-->
					<input type="button" value="<bean:message bundle="pageResources" key="page.dictionary.game.add"/>" onclick="window.location.href='showAddGame.do'" />&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		<br />
		<div align="center">
			<strong><bean:message bundle="pageResources" key="page.dictionary.game.info"/></strong>
		</div>
		<br />
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
