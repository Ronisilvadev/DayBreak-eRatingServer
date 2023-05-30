<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
	
		function check(){
			if ( document.forms[0].activityId.value == "" || document.forms[0].activityId.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
	</script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.chargingGiveItem }">
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

		<form action="synChargeGiveItem.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.operProduct.sychro"/><bean:message bundle="pageResources" key="page.dictionary.game.gameName"/>： 
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemCode" type="hidden" value="${requestScope.itemCode}" style="width:200px" />
				 	<input name="srcGameId" type="hidden" value="${requestScope.srcGameId}" style="width:200px" />
				 	<input name="srcActivityType" type="hidden" value="${requestScope.srcActivityType}" style="width:200px" />
				 	<input name="gameId" type="hidden" value="${requestScope.gameId}" style="width:200px" />
				 	<input name="gameName" type="text" readonly value="${requestScope.gameName}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/>ID：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text"  style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="history.back(1)" />
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