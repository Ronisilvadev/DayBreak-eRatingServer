<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
	
		function confirmDel() {
			var end = true ;
			if (confirm('<bean:message bundle="pageResources" key="page.worldOperation.alertInfo.delActivity"/>')){
				<c:if test="${today.time < activity.endTime.time}">
					if(!confirm('<bean:message bundle="pageResources" key="page.worldOperation.alertInfo.tip"/>'))
						return ;
				</c:if>
				
				   
				window.location.href='delActivity.do?activityId=${requestScope.activity.activityId }';
			}
			return false;
		}
	</script>
	
</head>

<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.activity }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.activity }">
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.activityId }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.gameName"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.gameName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/></td>
				<td align="center" class="t_border_r">${requestScope.activity.activityName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.activity.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/></td>
				<td align="center" class="t_border_r"><fmt:formatDate value="${ requestScope.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="30px">
					<td align="center" class="t_border_l" width="30%">
						<bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID" />
					</td>
					<td class="t_border_r" align="left" colspan="2">
						<c:if test="${activity.gatewayType eq 1 }">
						    <input type="checkbox" id="AllGateway" name="AllGateway" value="1" onclick="checkAll(document.forms[0]);" checked disabled /><bean:message bundle="pageResources" key="page.common.allServer"/>  
						    <br/>
						</c:if>
					    <c:if test="${activity.gatewayType eq 2 }">
							<c:forEach items="${requestScope.gatewayList}" var="gateway" varStatus="status">
							<c:if test="${0==status.index%3 and status.index>0}">
								<br/>
							</c:if>
							<div style="width:160px;height:17px;overflow:hidden;float:left;"><input type="checkbox" id="AllGateway" name="gatewayId" value="${gateway.gatewayId}" checked disabled />&nbsp;${gateway.gatewayId}-${gateway.gatewayName}</div>
							</c:forEach>
						</c:if>
					</td>
			</tr>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		<c:if test="${requestScope.action == 'showIssueActivity' }">
		<div align="center">
			<input type="button" onclick="confirmDel();" value="<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.cancelActivity"/>"/>&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="window.location.href='showModifyActivity.do?activityId=${requestScope.activity.activityId}'" value="<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.modifyTime"/>"/>
		</div>
		</c:if>
		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="10" align="center" ></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.activity"/> <strong>${requestScope.activity.activityName }</strong> <bean:message bundle="pageResources" key="page.worldOperation.activityDetail.point"/></td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.chargeChannelId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.chargeSubjectId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.activityType"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.pointType"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.startMoney"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.endMoney"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.beginTime"/></td>
				 	<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.pointRate"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.pointQuotiety"/></td>
				</tr>
				<c:if test="${not empty requestScope.activityPointList }">
				<c:forEach items="${requestScope.activityPointList}" var="activityPoint">
				<tr height="23px">
						<td align="center" class="t_border_l">
							<gmweb:channelId2Text channelId="${activityPoint.chargeChannelId }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:subjectId2Text subjectId="${activityPoint.chargeSubjectId }" /> 
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${activityPoint.activityType == 1}">
								<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.pointActivity"/>
							</c:if>
							<c:if test="${activityPoint.activityType == 2}">
								<bean:message bundle="pageResources" key="page.worldOperation.addActivityPoint.Accumulative"/>
							</c:if>
							<c:if test="${activityPoint.activityType != 1 and activityPoint.activityType != 2 }">
								${activityPoint.pointType }
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							${activityPoint.pointType }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatNumber value="${activityPoint.startMoney }" pattern="0.##"/>
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatNumber value="${activityPoint.endMoney }" pattern="0.##"/>
						</td>
						<td align="center" class="t_border_l">&nbsp;
							<fmt:formatDate value="${ activityPoint.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
						</td>
						<td align="center" class="t_border_l">
						&nbsp;
							<fmt:formatDate value="${ activityPoint.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
						</td>
						<td align="center" class="t_border_l">${activityPoint.pointMultiple }</td>
						<td align="center" class="t_border_r">${activityPoint.pointQuotiety }</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="10" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		<c:if test="${requestScope.action == 'showIssueActivity' }">
		<div align="center">
			<input type="button" onclick="window.location.href='showAddActivityPoint.do?activityId=${requestScope.activity.activityId }'" value="<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.addPointActivity"/>"/>
		</div>
		</c:if>
		<br />
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="20px">
					<td colspan="6" align="center" ></td>
				</tr>
				<tr>
					<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.activity"/> <strong>${requestScope.activity.activityName }</strong> <bean:message bundle="pageResources" key="page.worldOperation.activityDetail.package"/> </td>
				</tr>
				
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.chargeSubjectId"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.activityType"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.startMoney"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.endMoney"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.packageId"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/></td>
				</tr>
				
				<c:if test="${not empty requestScope.activityPackageList }">
				<c:forEach items="${requestScope.activityPackageList}" var="activityPackage">
				<tr height="23px">
					<td align="center" class="t_border_l">
						<gmweb:subjectId2Text subjectId="${activityPackage.chargeSubjectId }" />
					</td>
					<td align="center" class="t_border_l">
						<c:if test="${activityPackage.activityType == 2}">
							<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue1"/>
						</c:if>
						<c:if test="${activityPackage.activityType == 3}">
							<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue2"/>
						</c:if>
						<c:if test="${activityPackage.activityType == 4}">
							<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue3"/>
						</c:if>
						<c:if test="${activityPackage.activityType == 5}">
							<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue4"/>
						</c:if>
					    <c:if test="${activityPackage.activityType == 6}">
						    <bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue5"/>
					    </c:if>
					</td>
					<td align="center" class="t_border_l">
						<fmt:formatNumber value="${activityPackage.startMoney }" pattern="0.##"/>
					</td>
					<td align="center" class="t_border_l">
						<fmt:formatNumber value="${activityPackage.endMoney }" pattern="0.##"/>
					</td>
					<td align="center" class="t_border_l">
						${activityPackage.packageId }
					</td>
					<td align="center" class="t_border_r">
						<a href="showActivityPackageDetail.do?activityId=${requestScope.activity.activityId }&packageId=${activityPackage.packageId }&action=${requestScope.action }"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
					</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="6" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
				</tr>
		</table>
		<c:if test="${requestScope.action == 'showIssueActivity' }">
		<div align="center">
			<input type="button" onclick="window.location.href='showAddActivityPackage.do?activityId=${requestScope.activity.activityId }&beginTime=<fmt:formatDate value="${ requestScope.activity.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&endTime=<fmt:formatDate value="${ requestScope.activity.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>'" value="<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.addPackageActivity"/>"/>
		</div>
		</c:if>
		<div align="center">
		<br /><br />
			<input type="button" onclick="window.location.href='${requestScope.action }.do'" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back3"/>"/>
		</div>
	</c:if>
	</body>
</html>