<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/querySummarySerialInfo"/>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">		
	
		var remarks = new Array();
		remarks[0] = '<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/>';
		remarks[1] = '<bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/>';
		
		function changeName(obj){
			document.getElementById("conditionText").innerHTML = obj.options[obj.selectedIndex].text+"：";
			var remark = document.getElementById("remark").innerHTML;
			if(obj.value == 1)document.getElementById("remark").innerHTML = remark.replaceAll(remarks[1],remarks[0]);
			else document.getElementById("remark").innerHTML = remark.replaceAll(remarks[0],remarks[1]);
		}
		
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.serialSummaryList }">
		<html:form action="querySummarySerialInfo.do" method="post" onsubmit="return validateQuerySummarySerialInfoForm(this);">
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
				 	<input type="input" name="activityBeginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${ requestScope.activityBeginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.purview.userManage.start"/><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input type="input" name="activityEndTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${ requestScope.activityEndTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" >
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
	
	<c:if test="${not empty requestScope.serialSummaryList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="4" align="center" ></td>
			</tr>
			<tr>
				<td colspan="4" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.vipCardSummaryInfo.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.passportNum"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.loginNum"/></td>
			</tr>
		<c:forEach items="${requestScope.serialSummaryList}" var="serialInfo">
			<tr height="23px">
				<td align="center" class="t_border_l">${serialInfo.mediaName }</td>
				<td align="center" class="t_border_l">&nbsp;${serialInfo.serialNum }</td>
				<td align="center" class="t_border_l">&nbsp;${serialInfo.passportNum }</td>
				<td align="center" class="t_border_r">&nbsp;${serialInfo.roleNum }</td>
			</tr>
		</c:forEach>
			<tr height="10px">
				<td colspan="4" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showQuerySummarySerialInfo.do'"/>
		</div>
	</c:if>
</body>
</html>