<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
  </head>
  
<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.chargerank }">
		<form  action="getChargeRank.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/></td>
				  <td class="t_border_r" align="left">
					<select name="gatewayId" style="width:200px">
						<option value="0">0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.querySum"/></td>
				<td class="t_border_r" align="left">
					<input type="text" name="querySum" style="width:200px"/>
				</td>	
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.minMoney"/></td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="minMoney" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.maxMoney"/></td>
					<td class="t_border_r" align="left">
				 	<input type="text" name="maxMoney" style="width:200px"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.begintime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="input" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate}" pattern="yyyy-MM-dd"/>" >
				 </td>
			</tr>
			<tr height="30px">
			   <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.showChargingRank.endtime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="input" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.endDate}" pattern="yyyy-MM-dd"/>" >
				 </td>	
			</tr>	
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>""/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.chargerank }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="3" align="center" ></td>
			</tr>
			<tr>
				<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.chargerank.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.PlayerQuery.chargerank.rank"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargerank.username"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.chargerank.acount"/></td>
			</tr>
		<c:forEach items="${requestScope.chargerank}" var="rank">
			<tr height="23px">
				<td align="center" class="t_border_l">${rank.rank}</td>
				<td align="center" class="t_border_l">${rank.passport_id}</td>
				<td align="center" class="t_border_l">${rank.acount}</td>
			</tr>
		</c:forEach>
			<tr height="10px">
				<td colspan="3" align="center" class="border_top">&nbsp;
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="window.location.href='showChargeRank.do'"/>
		</div>
	</c:if>
</body>
</html>
