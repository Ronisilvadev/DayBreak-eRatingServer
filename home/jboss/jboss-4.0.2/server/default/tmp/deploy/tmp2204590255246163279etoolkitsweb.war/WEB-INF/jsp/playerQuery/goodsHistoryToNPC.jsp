<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript" src="js/func.js"></script>
	<title></title>
	<script type="text/javascript">
		function nextPage(curPage){
			if(isNum(curPage)){
				document.getElementById('curPage').value=curPage;
				document.forms[0].submit();
			}else{
				alert('<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.errPage"/>');
			}
		}
	</script>
</head>


  <body bgcolor="#ffffff">
  <html:form action="GoodsHistoryToNPC.do" method="post"> 
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="6" align="center" ></td>
		</tr>
		<tr>
			<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryToNPC.title"/></td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.itemId"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.NPCName"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemName"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.ItemNum"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.goodsHistoryFromNPC.Date"/></td>
		</tr>
		<c:if test="${not empty requestScope.roleLog }">
			<c:forEach items="${requestScope.roleLog.list}" var="goodsHistoryToNPC" varStatus="status">
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l">${goodsHistoryToNPC.itemId }</td>
					<td align="center" class="t_border_l">${goodsHistoryToNPC.npcName }</td>
					<td align="center" class="t_border_l">${goodsHistoryToNPC.itemName }</td>
					<td align="center" class="t_border_l">${goodsHistoryToNPC.itemNum }</td>
					<td align="center" class="t_border_l">${goodsHistoryToNPC.time }</td>
				</tr>
			</c:forEach>
		</c:if>
		<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="6">
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="hidden" name="roleName" value="${roleName }"/>
					<input type="hidden" name="npcName" value="${npcName }"/>
					<input type="hidden" name="startDate" value="${startDate }"/>
					<input type="hidden" name="endDate" value="${endDate }"/>
					<input type="hidden" name="curPage" id="curPage"/>
					<c:if test="${requestScope.roleLog.page>1 }"><a href="javascript:void(0)" onclick="nextPage('${requestScope.roleLog.page-1 }');"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="javascript:void(0)" onclick="nextPage(document.getElementById('toPage').value);">GO</a>
					<a href="javascript:void(0)" onclick="nextPage('${requestScope.roleLog.page+1 }');"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.roleLog.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
	</table>
	<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</html:form>
  </body>
</html>
