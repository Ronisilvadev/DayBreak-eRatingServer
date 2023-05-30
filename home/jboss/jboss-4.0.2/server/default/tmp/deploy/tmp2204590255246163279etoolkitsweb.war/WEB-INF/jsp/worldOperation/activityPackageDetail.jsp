<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		function check(){
			if ( document.forms[0].item.value == "" || document.forms[0].item.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.item"/>');
					document.forms[0].item.focus();
					return false;
			}
			else {
				  return true;
			}
		}
	</script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.activityPackage }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.title1"/>“${requestScope.activityPackage.packageId }” <bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.title2"/></td>
			</tr>
			
			<c:if test="${not empty requestScope.activityPackage }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.packageId"/></td>
				<td align="center" class="t_border_r">${requestScope.activityPackage.packageId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.activityId"/></td>
				<td align="center" class="t_border_r">${requestScope.activityId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.arrChannelId"/></td>
				<td align="center" class="t_border_r">
					<c:forEach items="${requestScope.arrChannelId}" var="arrChannelId">
						<gmweb:channelId2Text channelId="${arrChannelId }" />
					</c:forEach>
				</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectId"/></td>
				<td align="center" class="t_border_r">
					<gmweb:subjectId2Text subjectId="${requestScope.activityPackage.chargeSubjectId }" />
				</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.startMoney"/></td>
				<td align="center" class="t_border_r">
					<fmt:formatNumber value="${requestScope.activityPackage.startMoney }" pattern="0.##"/>
				</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.endMoney"/></td>
				<td align="center" class="t_border_r">
					<fmt:formatNumber value="${requestScope.activityPackage.endMoney }" pattern="0.##"/>
				</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/></td>
				<td align="center" class="t_border_r">
					<c:if test="${requestScope.activityPackage.activityType == 2}">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue1"/>
					</c:if>
					<c:if test="${requestScope.activityPackage.activityType == 3}">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue2"/>
					</c:if>
					<c:if test="${requestScope.activityPackage.activityType == 4}">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue3"/>
					</c:if>
					<c:if test="${requestScope.activityPackage.activityType == 5}">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue4"/>
					</c:if>
					<c:if test="${requestScope.activityPackage.activityType == 6}">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue5"/>
					</c:if>
				</td>
			</tr>
			<c:if test="${requestScope.activityPackage.activityType == 5}">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.cumuBeginTime"/></td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${activityPackage.cumuBeginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.cumuEndTime"/></td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${activityPackage.cumuEndTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
				</td>
			</tr>
			</c:if>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="20px">
					<td colspan="5" align="center" ></td>
				</tr>
				<tr>
					<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.title1"/> “${requestScope.activityPackage.packageId } ”<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.title3"/></td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemCode"/> </td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemName"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemNum"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.beginTime"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.endTime"/></td>
				</tr>
				<c:if test="${not empty requestScope.activityPackageItemList }">
				<c:forEach items="${requestScope.activityPackageItemList}" var="activityPackageItem">
				<tr height="23px">
					<td align="center" class="t_border_l">${activityPackageItem.itemCode }</td>
					<td align="center" class="t_border_l">${activityPackageItem.itemName }</td>
					<td align="center" class="t_border_l">${activityPackageItem.itemNum }</td>
					<td align="center" class="t_border_l">
						<fmt:formatDate value="${activityPackageItem.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
					<td align="center" class="t_border_r">
						<fmt:formatDate value="${activityPackageItem.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
					</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="10px">
				  	<td colspan="5" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
			</table>
			<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>
	<c:if test="${requestScope.action == 'showIssueActivity' }">
	<form action="validateActivityPackageItem.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="20PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.addPackage"/></td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemList"/></td>
				<td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemInfo"/> <br />
					<textarea name="item" rows=8 cols=35 size="10240" ></textarea><br />
					<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.alertInfo"/><br />
					<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.exmp1"/><br />
					<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.exmp2"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.beginTime2"/></td>
				<td class="t_border_r" align="left">
					<input type="text" name="beginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.beginTime }" pattern="yyyy-MM-dd HH:mm:ss" />" />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.endTime2"/></td>
				<td class="t_border_r" align="left">
					<input type="text" name="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss" />" />
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					 <input type="hidden" name="activityId" value="${ requestScope.activityId}" />
					 <input type="hidden" name="activityName" value="${ requestScope.activityName}" />
					 <input type="hidden" name="packageId" value="${ requestScope.packageId}" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />
				</td>
			</tr>
		</table>
	</form>
		<br />
		
	</c:if>
	</c:if>
	<div align="center">
		<input type="button" onclick="window.location.href='showActivityDetail.do?action=${requestScope.action}&activityId=${requestScope.activityId }'" value="<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.back"/>"/>
	</div>
	</body>
</html>