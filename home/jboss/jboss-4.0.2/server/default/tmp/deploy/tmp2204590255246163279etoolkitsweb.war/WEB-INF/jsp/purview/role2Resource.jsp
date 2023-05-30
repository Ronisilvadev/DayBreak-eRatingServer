<%@ page language="java"pageEncoding="utf-8"%>
<%@ include file="../inc/taglibs.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>My JSP 'tree.jsp' starting page</title>
    <link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<SCRIPT language=javascript src="js/treeCheckBox.0.2.js" type=text/javascript></SCRIPT>
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  <body bgcolor="#ffffff">
  <form action="modifyRoleResource.do" method="post">
  <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" ></td>
			</tr>
			<!--  
			<tr height="30px">
				<td align="left">
					<gmweb:createGameResOptionLink defaultValue="${requestScope.gameId}" gameList="${requestScope.gameList}" link="showRole2Resource.do?roleId=${requestScope.roleInfo.roleId}" />								
				</td>
			</tr>
			-->
			<tr>
				<td align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.role2Resource.title"/></td>
			</tr>
			<tr class="ffffff">
				<td class="t_border_l t_border_r">
					
					<c:if test="${not empty requestScope.menulist }">
				  	<PRE>
						<div id=Tc></div>					
					<SCRIPT>
						var rows = new Object; 
						var rowsPidIndex = new Object; 
					  	rows = {
					  			<c:forEach var="menu" items="${menulist}" varStatus="status1">
					  			<c:forEach var="menuItem" items="${menu.childMenuItem}" varStatus="status2">
							  		<c:if test="${menuItem.id >= 0}">
							  		'${menuItem.id}' : {'id':'${menuItem.id}', 'pid':'${menuItem.parentId}', 'title':"<bean:message bundle="menuResources" key="${menuItem.name}"/>（<bean:message bundle="menuResources" key="${menuItem.desc }"/>）"}
							  		</c:if>
							  		<c:if test="${menuItem.id < 0}">
							  		'${menuItem.id}' : {'id':'${menuItem.id}', 'pid':'${menuItem.parentId}', 'title':"${menuItem.name}"}
							  		</c:if>
								<c:if test="${!(status1.last && status2.last)}">
								,
								</c:if>
								</c:forEach>
								</c:forEach>
								};
						
						<c:forEach var="menu" items="${menulist}" varStatus="status1">
						rowsPidIndex[${menu.parentId}] = new Array(
						<c:forEach var="menuItem" items="${menu.childMenuItem}" varStatus="status2">
				        '${menuItem.id}'
				        <c:if test="${!status2.last}">
						,
						</c:if>
				        </c:forEach>
						)
						</c:forEach>
					</SCRIPT>
					<SCRIPT>
						var ctree = new  treeCheckBox( 'ctree'  , rows , rowsPidIndex ); 
						ctree.iconPath='images/tree2/';
						ctree.useCheckBox=true;
						ctree.checkBoxName='menu';
						ctree.checkBoxChecked='';
						ctree.toString( Tc ); 
					</SCRIPT>
					
					<script type="text/javascript">
						 selectedIndex = new Array(
							<c:forEach var="menuItem" items="${checkMenuItem}" varStatus="status2">
					        '${menuItem.id}'
					        <c:if test="${!status2.last}">
							,
							</c:if>
					        </c:forEach>
					     )   
					     
					     function  selectCheckBox(){
					     	 var checkBoxes = document.getElementsByTagName('input'); 
					         for ( var  i = 0 ; i < checkBoxes.length; i ++ ){
					             var  obj  =  checkBoxes[i];
					             if (obj && obj.type && obj.type == "checkbox"){
					             	for( var j = 0; j < selectedIndex.length; j++){
					             		if (obj.id && obj.id == "ctree_node_checkbox_" + selectedIndex[j]){
					             			obj.checked = true;
					             		}
					             	}
					             }
					        }
					    }
					    
					    selectCheckBox();
					</script>
				</PRE>
				</c:if>							
			</td>
		</tr>
		<tr height="30px">
			<td align="center" class="t_border">
				<input type="hidden" name="gameId" value="${requestScope.gameId}" />
				<input type="hidden" name="roleId" value="${requestScope.roleInfo.roleId}" />
				<input type="submit" value="<bean:message bundle="pageResources" key="page.common.save"/>" />&nbsp;&nbsp;
				<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showRoleManage.do'"/>&nbsp;&nbsp;		
			</td>
		</tr>
	</table>
</form>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
</body>
</html>
