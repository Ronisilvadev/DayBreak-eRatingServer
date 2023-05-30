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
	<c:if test="${not empty requestScope.chargingGiveItem }">
	<gmweb:showGiveItemDesc />
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItemDetail.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.chargingGiveItem }">
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItemDetail.itemCode"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.itemCode}
				 </td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.productInfo.item_name"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.itemName}
				 </td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/></td>
				<td align="left" class="t_border_r">${requestScope.chargingGiveItem.activityId }</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/> 
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.activityType}
				 </td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.activityDetail.gameName"/></td>
				<td align="left" class="t_border_r">${requestScope.chargingGiveItem.gameName }</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/></td>
				<td align="left" class="t_border_r"><fmt:formatDate value="${ requestScope.chargingGiveItem.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/></td>
				<td align="left" class="t_border_r"><fmt:formatDate value="${ requestScope.chargingGiveItem.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItemDetail.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.gatewayId }
				 </td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.activityType"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.pointType }
				 </td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.activityNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.costPoint }
				 </td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.sendItemNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	${requestScope.chargingGiveItem.sendItemNum }
				 </td>
			</tr>
			</c:if>
			<tr height="10px">
			  	<td colspan="8" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<html:link action="delChargingGiveItem.do?activityType=${requestScope.chargingGiveItem.activityType}" paramId="itemCode" paramName="chargingGiveItem" paramProperty="itemCode"><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.delItem"/></html:link>
			<html:link action="showModifyChargingGiveItem.do?activityType=${requestScope.chargingGiveItem.activityType}" paramId="itemCode" paramName="chargingGiveItem" paramProperty="itemCode"><bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.modifyItem"/></html:link>
			<!-- 
			<input type="button" onclick="window.location.href='delChargingGiveItem.do?itemCode=${requestScope.chargingGiveItem.itemCode }&activityType=${requestScope.chargingGiveItem.activityType}'" value="<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.delItem"/>"/>&nbsp;&nbsp;&nbsp;
			<input type="button" onclick="window.location.href='showModifyChargingGiveItem.do?itemCode=${requestScope.chargingGiveItem.itemCode }&activityType=${requestScope.chargingGiveItem.activityType}'" value="<bean:message bundle="pageResources" key="page.worldOperation.chargingGiveItem.modifyItem"/>"/>&nbsp;&nbsp;&nbsp;
			 -->
			<input type="button" onclick="window.location.href='showChargingGiveItem.do'" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>"/>
		</div>
	</c:if>
	<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>