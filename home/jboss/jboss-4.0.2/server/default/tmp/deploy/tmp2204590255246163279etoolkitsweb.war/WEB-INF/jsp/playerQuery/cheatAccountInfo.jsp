<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">		
		function check(form){
			if(form.ipCount.value == 0 || !isNum(form.ipCount.value)){
				alert('<bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.ipCountCheck"/>');
				return false;
			}
		}
		
		function exportData(){
			document.forms[0].action = "exportCheatAccountInfo.do";
			document.forms[0].submit();
		}
		
		function back(){
			document.forms[0].action = "showQueryCheatAccountInfo.do";
			document.forms[0].submit();
		}
		
		function gotoPage(obj){
			document.forms[0].action = "queryCheatAccountInfo.do";
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<form action="queryCheatAccountInfo.do" method="post" onsubmit="return check(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.title"/></td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.queryDate"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<input type="text" name="queryDate" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${queryDate}" >
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.ipCount"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="text" name="ipCount" value="${ipCount }">
				 </td>
			</tr>
			<tr height="30px" style="display:none">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.macCount"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="text" name="macCount" value="${macCount}">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.export"/> " onclick="exportData()"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.cheatAccount.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l">网关</td>
				<td align="center" class="t_border_l">MAC</td>
				<td align="center" class="t_border_l">账号</td>
				<td align="center" class="t_border_l">角色名称</td>
				<td align="center" class="t_border_l">角色门派</td>
				<td align="center" class="t_border_l">角色级别</td>
				<td align="center" class="t_border_l">金钱数</td>
				<td align="center" class="t_border_r">充值金额</td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="cheatAccount">
			<tr height="23px">
				<td align="center" class="t_border_l">${cheatAccount.gatewayId }</td>
				<td align="center" class="t_border_l">${cheatAccount.mac }</td>
				<td align="center" class="t_border_l"><c:out value="${cheatAccount.userName }"/></td>
				<td align="center" class="t_border_l"><c:out value="${cheatAccount.roleName }"/></td>
				<td align="center" class="t_border_l">${cheatAccount.roleOccupation }</td>
				<td align="center" class="t_border_l">${cheatAccount.roleLevel }</td>
				<td align="center" class="t_border_l">${cheatAccount.money }</td>
				<td align="center" class="t_border_r">${cheatAccount.totalCharge }</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="8" align="center" class="t_border">
				<form name="pageForm" action="queryCheatAccountInfo.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="ipCount" value="${ipCount}"/>
					<input type="hidden" name="macCount" value="${macCount}"/>
					<input type="hidden" name="queryDate" value="${queryDate}"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.export"/> " onclick="exportData()"/>
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="back()"/>
		</div>
	</c:if>
</body>
</html>