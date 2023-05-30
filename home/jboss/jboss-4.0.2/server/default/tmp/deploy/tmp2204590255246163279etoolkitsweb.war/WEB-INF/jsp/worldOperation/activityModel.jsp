<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javaScript">
			function gotoPage(obj){
				obj.submit();
			}
			
			function confirmDel(){
				
				return confirm('<bean:message bundle="pageResources" key="page.purview.common.confirmDel"/>');
			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<c:if test="${not empty requestScope.pageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td colspan="8" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.title"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l" width="20%">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftStartTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="act">
					<tr height="23px" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'" title="<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>:${act.activityId}&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleStartTime"/>:<fmt:formatDate value="${act.roleBeginTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleEndTime"/>:<fmt:formatDate value="${act.roleEndTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13">
						<td align="center" class="t_border_l">
							${act.activityName}
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${act.activityType == '1'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/></c:if> 
							<c:if test="${act.activityType == '3'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/></c:if> 
							<c:if test="${act.activityType == '5'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/></c:if> 
							<c:if test="${act.activityType == '6'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/></c:if> 
							<c:if test="${act.activityType == '7'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/></c:if>
							<c:if test="${act.activityType == '8'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType8"/></c:if>
							<c:if test="${act.activityType == '9'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType9"/></c:if>  
							<c:if test="${act.activityType == '10'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType10"/></c:if>
							<c:if test="${act.activityType == '11'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType11"/></c:if>
							<c:if test="${act.activityType == '12'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType12"/></c:if>
							<c:if test="${act.activityType == '14'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType14"/></c:if>
							<c:if test="${act.activityType == '15'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType15"/></c:if>
							<c:if test="${act.activityType == '16'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType16"/></c:if>
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.giftBeginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							${act.giftEndTime }<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTimeInfo"/>&nbsp;
						</td>
						<td align="center" class="t_border_r">
							<a href="showOperActivityModel.do?activityId=${act.activityId}&version=${requestScope.version}" ><bean:message bundle="pageResources" key="page.common.operation"/></a>
							<c:if test="${1 == act.activityType }"><a href="showGenerateSerialCode.do?activityId=${act.activityId}&version=${requestScope.version}"><bean:message bundle="pageResources" key="page.worldOperation.serialCode.serialCode"/></a>&nbsp;&nbsp;</c:if>
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="showActivityModel.do?version=new" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input name="version" type="hidden" value="${requestScope.version}"/>
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td align="left" colspan="10">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.serialCode.addSerialActivity"/>" onclick="window.location.href='showAddActivityModel.do?version=${requestScope.version}'" />&nbsp;&nbsp;
				</td>
			</tr>
			
			</table>
			
			<br />
		</c:if>
	</body>
</html>
