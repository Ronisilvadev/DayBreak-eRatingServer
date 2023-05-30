<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
	</head>

	<body bgcolor="#ffffff">

		<c:if test="${not empty requestScope.arrChargeChannelId}">
		<form action="addActivityPackage.do" method="post">
			<input type="hidden" name="beginTime" value="${beginTime }">
			<input type="hidden" name="endTime" value="${endTime }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr height="30px">
					<td colspan="4" align="center"></td>
				</tr>
				<tr>
					<td colspan="4" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
				
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.chargeChannelId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.chargeSubjectId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.startMoney"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.activityDetail.endMoney"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.arrChargeChannelId}" var="arrChargeChannelId">
				<c:forEach items="${requestScope.configList}" var="config">
					<tr height="23px">
						<td align="center" class="t_border_l">
							<gmweb:channelId2Text channelId="${arrChargeChannelId }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:subjectId2Text subjectId="${requestScope.chargeSubjectId }" />
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${config[0] == '-'}">
								99999999.99
							</c:if>
							<c:if test="${config[0] != '-'}">
								${config[0] }
							</c:if>
						</td>
						<td align="center" class="t_border_r">
							<c:if test="${config[1] == '-'}">
								99999999.99
							</c:if>
							<c:if test="${config[1] != '-'}">
								${config[1] }
							</c:if>
						</td>
					</tr>
				</c:forEach>
				</c:forEach>
			<tr height="30px">
				<td colspan="4" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />&nbsp;&nbsp;
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>" onclick="window.location.href='showAddActivityPackage.do?activityId=${activityId }&beginTime=${beginTime}&endTime=${endTime}'" />
				</td>
			</tr>
			</table>
			<c:forEach items="${requestScope.arrChargeChannelId}" var="arrChargeChannelId"> 
				<input type="checkbox" name="chargeChannelId" value ="${arrChargeChannelId}" checked style="display:none;"/>
			</c:forEach>
			 <input type="hidden" name="activityId" value="${ requestScope.activityId}" />
			 <input type="hidden" name="chargeSubjectId" value="${ requestScope.chargeSubjectId}" />
			 <input type="hidden" name="activityType" value="${ requestScope.activityType}" />
			 <input type="hidden" name="config" value="${ requestScope.config}" />
		</form>			
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
