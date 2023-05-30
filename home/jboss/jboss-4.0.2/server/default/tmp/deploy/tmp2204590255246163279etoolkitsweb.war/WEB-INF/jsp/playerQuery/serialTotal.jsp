<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/queryTotalSerialInfo"/>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.serialTotalList }">
		<html:form action="queryTotalSerialInfo.do" method="post" onsubmit="return validateQueryTotalSerialInfoForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.vipCardSummaryInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="activityId">
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.purview.userManage.start"/><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="activityBeginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${ requestScope.activityBeginTime}" pattern="yyyy-MM-dd"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.purview.userManage.start"/><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="activityEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${ requestScope.activityEndTime}" pattern="yyyy-MM-dd"/>" >
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
	
	<c:if test="${not empty requestScope.serialTotalList }">
		<table width="99%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="13" align="center" ></td>
			</tr>
			<tr>
				<td colspan="13" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.vipCardSummaryInfo.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.date"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.activeName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.activityAmount"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.totalFirstLogin"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.firstLogin"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.totalChargeNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.totalChargeMoney"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.chargeNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.chargeMoney"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.dayLost"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.sevenDayLost"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.serialTotal.remainAmount"/></td>
			</tr>
		<c:forEach items="${requestScope.serialTotalList}" var="serialTotalInfo">
			<tr height="23px">
				<td align="center" class="t_border_l"><fmt:formatDate value="${serialTotalInfo.statDate}" pattern="yyyy-MM-dd"/></td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.activityName }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.mediaName }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.activityAmount }</td>
				<td align="center" class="t_border_l">${serialTotalInfo.totalFirstLogin }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.firstLogin }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.totalChargeNum }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.totalChargeMoney }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.chargeNum }</td>
				<td align="center" class="t_border_l">${serialTotalInfo.chargeMoney }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.dayLost }</td>
				<td align="center" class="t_border_l">&nbsp;${serialTotalInfo.sevenDayLost }</td>
				<td align="center" class="t_border_r">&nbsp;${serialTotalInfo.remainAmount }</td>
			</tr>
		</c:forEach>
			<tr height="10px">
				<td colspan="13" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1)"/>
		</div>
	</c:if>
</body>
</html>