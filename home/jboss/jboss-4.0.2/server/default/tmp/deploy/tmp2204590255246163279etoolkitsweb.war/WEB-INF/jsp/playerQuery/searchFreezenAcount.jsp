<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="../inc/taglibs.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/querySearchFreezenAcount"/>
    <script type="text/javascript">
    function gotoPage(obj){
		obj.submit();
	}
    </script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="querySearchFreezenAcount.do" method="post" onsubmit="return validateQuerySearchFreezenAcountForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.Freezen.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.purview.freezen.start"/><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${ requestScope.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.purview.freezen.start"/><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${ requestScope.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="4" align="center" ></td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.Freezen.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.searchFreezenAcount.playerName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.searchFreezenAcount.freezenTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.searchFreezenAcount.freezenLongTime"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.searchFreezenAcount.freezenReason"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.searchFreezenAcount.operatorName"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="freezenInfo">
			<tr height="23px">
				<td align="center" class="t_border_l">${freezenInfo.passportName }</td>
				<td align="center" class="t_border_l">&nbsp;${freezenInfo.freeze_time }</td>
				<td align="center" class="t_border_l">&nbsp;${freezenInfo.last_seconds }</td>
				<td align="center" class="t_border_r">&nbsp;${freezenInfo.reason }</td>
				<td align="center" class="t_border_r">&nbsp;${freezenInfo.operator_name }</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="querySearchFreezenAcount.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="beginDate"  value="${requestScope.beginDate }" />
					<input type="hidden" name="endDate" value="${requestScope.endDate }"  />
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showSearchFreezenAcount.do'"/>
		</div>
	</c:if>
</body>
</html>