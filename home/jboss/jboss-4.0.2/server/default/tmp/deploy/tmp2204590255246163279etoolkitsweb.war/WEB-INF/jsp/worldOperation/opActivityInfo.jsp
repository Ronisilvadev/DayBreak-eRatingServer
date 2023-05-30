<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	
</head>


<body bgcolor="#ffffff">
	<form action="opActivityInfo.do" method="post" >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">
				<c:if test="${opFlag =='modify' }">
					<bean:message bundle="pageResources" key="page.worldOperation.opActivityInfo.title1"/>
				</c:if>
				<c:if test="${opFlag =='add' }">
					<bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.title1"/>
				</c:if>
				</td>
			</tr>
			<c:if test="${opFlag =='add' }">
			<tr height="30px">
			<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.activeName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activeName" type="text" value="${actInfo.activeName}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.gatewayID"/></td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				 		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			</c:if>
			<c:if test="${opFlag =='add' || modifyContent == 'time'}">
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" readonly value="<fmt:formatDate value="${ actInfo.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" readonly value="<fmt:formatDate value="${ actInfo.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"  />
				 	<br />
				 	<bean:message bundle="pageResources" key="page.worldOperation.common.timeInfo"/>
				 </td>
			</tr>
			</c:if>
			<c:if test="${opFlag =='add' }">
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.startCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="startCmd" type="text" value="${actInfo.startCmd}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.endCmd"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endCmd" type="text" value="${actInfo.endCmd}" style="width:200px" />
				 </td>
			</tr>
			</c:if>
			<c:if test="${opFlag =='add' || modifyContent == 'circleday'}">
			<tr>
				<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.opTypeActivityInfo.circleday"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="circleday" type="text" value="${actInfo.circleday}" style="width:200px" <c:if test="${modifyContent == 'time' }">readonly</c:if> />
				 </td>
			</tr>
			</c:if>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="opFlag" value="${opFlag }"/>
					<input type="hidden" name="modifyContent" value="${modifyContent }"/>
					<input type="hidden" name="activeID" value="${actInfo.activeID }"/>
					<c:if test="${opFlag !='add' }">
						<input type="hidden" name="gatewayId" value="${gatewayId }" />
					</c:if>
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>