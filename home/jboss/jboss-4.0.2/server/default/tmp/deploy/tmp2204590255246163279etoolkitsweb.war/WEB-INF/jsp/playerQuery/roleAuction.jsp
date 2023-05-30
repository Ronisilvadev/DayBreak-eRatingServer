<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
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
	<c:if test="${not empty requestScope.gatewayList }">
		<form action="getRoleAuction.do" method="post" onsubmit="return validateRoleAuctionForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleAuction.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.roleName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="roleName">
				 </td>
			</tr>			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.auctionType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="type">				  		
				 		<c:forEach items="${requestScope.auctionTypeList }" var="dic">
				 			<option value="${dic.opValue }">${dic.opValue } - ${dic.opText }</option>
				 		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.itemType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="itemType">				  		
				 		<c:forEach items="${requestScope.itemTypeList }" var="dic">
				 			<option value="${dic.opValue }">${dic.opValue } - ${dic.opText }</option>
				 		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		<input type="hidden" name="curPage" id="curPage" value="1"/>
	</form>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
	<form action="getRoleAuction.do" method="post" onsubmit="return validateRoleAuctionForm(this);">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="20" align="center" ></td>
		</tr>
		<tr>
			<td colspan="20" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.roleAuction.title"/></td>
		</tr>
		<c:forEach items="${requestScope.pageInfo.list}" var="parentInfo">
			<tr height="23px">			
			<c:forEach items="${parentInfo}" var="childInfo">				
				<td align="center" class="t_border_r"><c:out value="${childInfo}"/>&nbsp;</td>
			</c:forEach>	
			</tr>
		</c:forEach>
		<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="20">
					<input type="hidden" name="gatewayId" value="${commonParamPojo.gatewayId }"/>
					<input type="hidden" name="roleName" value="${commonParamPojo.roleName }"/>
					<input type="hidden" name="type" value="${commonParamPojo.type }"/>
					<input type="hidden" name="itemType" value="${commonParamPojo.itemType }"/>
					<input type="hidden" name="curPage" id="curPage"/>
					<c:if test="${requestScope.pageInfo.page>1 }"><a href="#" onclick="nextPage('${requestScope.pageInfo.page-1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="#" onclick="nextPage(document.getElementById('toPage').value); return false;">GO</a>
					<a href="#" onclick="nextPage('${requestScope.pageInfo.page+1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.pageInfo.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>		
	</table>
	<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</form>
	</c:if>
	
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>