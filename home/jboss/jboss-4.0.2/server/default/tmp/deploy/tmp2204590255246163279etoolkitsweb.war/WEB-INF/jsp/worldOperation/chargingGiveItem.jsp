<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "showChargingGiveItem.do";
				obj.method = "post";
				obj.page.value = 1;
				obj.submit();
			}
			
		</script>
	</head>

	<body bgcolor="#ffffff">
		<c:if test="${not empty requestScope.pageInfo}">
		<gmweb:showGiveItemDesc />
		<form name="pageForm" action="showChargingGiveItem.do" method="post">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr>
					<td colspan="2" align="center" height="30PX"></td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.title"/></td>
				</tr>
				<tr height="30px">
					<td width="75%" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:50px" align="left">
					  	<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/>
					  	<select name="activityType" style="width:100px">
					  		<option value="-1" <c:if test="${requestScope.activityType == -1}">selected</c:if> ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.all"/></option>
					  	<c:forEach var="activityType" items="${requestScope.activityTypeList}">
							<option value="${activityType }" <c:if test="${requestScope.activityType == activityType}">selected</c:if> >${activityType }</option>
						</c:forEach>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.activityType"/>
					  	<select name="pointType" style="width:100px">
					  		<option value="-1" <c:if test="${requestScope.activityType == -1}">selected</c:if> ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.all"/></option>
					  		<c:forEach var="pointType" items="${requestScope.pointTypeList}">
							<option value="${pointType }" <c:if test="${requestScope.pointType == pointType}">selected</c:if>>${pointType }</option>
						</c:forEach>
						</select>
					</td>
					<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
						<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.title"/>" onclick="return searchSubmit(document.forms[0]);"/>
					</td>
				</tr>
			</table>
			
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr height="30px">
					<td colspan="7" align="center"></td>
				</tr>
				<tr>
					<td colspan="7" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.title2"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.productCode"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.product.productName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.activityId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueActivity.gameName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="chargingGiveItem" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${chargingGiveItem.itemCode}
						</td>
						<td align="center" class="t_border_l">
							${chargingGiveItem.itemName}
						</td>
						<td align="center" class="t_border_l">
							${chargingGiveItem.activityId}
						</td>
						<td align="center" class="t_border_l">
							${requestScope.gameNameMap[chargingGiveItem.gameId] }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${chargingGiveItem.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${chargingGiveItem.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_r">
							<html:link action="showChargingGiveItemDetail.do?activityType=${chargingGiveItem.activityType}" paramId="itemCode" paramName="chargingGiveItem" paramProperty="itemCode"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></html:link>
							<html:link action="showSynChargeGiveItemGames.do?activityType=${chargingGiveItem.activityType}" paramId="itemCode" paramName="chargingGiveItem" paramProperty="itemCode"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/></html:link>	
							<!-- 
							<a href="showChargingGiveItemDetail.do?itemCode=${chargingGiveItem.itemCode}&activityType=${chargingGiveItem.activityType}"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
							<a href="showSynChargeGiveItemGames.do?itemCode=${chargingGiveItem.itemCode}&activityType=${chargingGiveItem.activityType}"><bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/></a>
							 -->						
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="7" align="center" class="t_border">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</td>
			</tr>
			<tr height="30px">
				<td align="left" colspan="7">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.addChargingGiveItem"/>" onclick="window.location.href='showAddChargingGiveItem.do'" />
				</td>
			</tr>
			</table>
			</form>
			<br />
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
