<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/queryRoleTopN"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="queryRoleTopN.do" method="post" onsubmit="return validateQueryRoleTopNForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<gmweb:createGatewayOption name="gatewayId" checkedValue="${ requestScope.gatewayId}" gatewayList="${requestScope.gatewayList}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.type"/></td>
				 <td class="t_border_r" align="left">
				 	<select name="orderType" style="width:230px">
						<option value="level" <c:if test="${requestScope.orderType == 'level'}">selected</c:if>><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.lv"/></option>
						<option value="money" <c:if test="${requestScope.orderType == 'money'}">selected</c:if>><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.money"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">Top N：</td>
				 <td class="t_border_r" align="left">
				 	<select name="topN" style="width:230px">
						<option value="10" <c:if test="${requestScope.topN == 10}">selected</c:if>>TOP 10</option>
						<option value="20" <c:if test="${requestScope.topN == 20}">selected</c:if>>TOP 20</option>
						<option value="50" <c:if test="${requestScope.topN == 50}">selected</c:if>>TOP 50</option>
						<option value="100" <c:if test="${requestScope.topN == 100}">selected</c:if>>TOP 100</option>
						<option value="200" <c:if test="${requestScope.topN == 200}">selected</c:if>>TOP 200</option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.Occupaction"/>:</td>
				 <td class="t_border_r" align="left">
				 	<select name="occupaction" style="width:230px">
				 		<option value="-1"><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.allOccupaction"/></option>
						<c:forEach var="occap" items="${requestScope.occupations}">
							<option value="${occap.opValue }">${occap.opText }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	
	<c:if test="${not empty requestScope.roleTopNList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="11" align="center" ></td>
			</tr>
			<tr>
				<td colspan="11" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.roleTopN.result"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.lv"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.exp"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.occuptationTotal.job"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.sex"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.createTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.logoutTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.onlineTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.money"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.money"/></td>
			</tr>
			
			<c:forEach items="${requestScope.roleTopNList}" var="roleInfo" varStatus="status">
			<tr height="23px">
				<td align="center" class="t_border_l">${status.index + 1 }</td>
				<td align="center" class="t_border_l"><c:out value="${roleInfo.roleName}"/></td>
				<td align="center" class="t_border_l">${roleInfo.roleLevel }</td>
				<td align="center" class="t_border_l">${roleInfo.experience }</td>
				<td align="center" class="t_border_l">
					<gmweb:roleOccupationAndNation2Text key="${roleInfo.roleOccupation }" valueMap="${requestScope.occupationMap }" />
				</td>
				<td align="center" class="t_border_l"><gmweb:roleGender2Text roleGender="${roleInfo.roleGender }" /></td>
				<td align="center" class="t_border_l"><fmt:formatDate value="${ roleInfo.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align="center" class="t_border_l"><fmt:formatDate value="${ roleInfo.lastLogoutTime}" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;</td>
				<td align="center" class="t_border_l">${roleInfo.totalOnlineSecond }</td>
				<td align="center" class="t_border_l">${roleInfo.money1 }</td>
				<td align="center" class="t_border_r">${roleInfo.money2 }</td>
			</tr>
			</c:forEach>
			
			<tr>
				<td colspan="11" align="center" class="t_head">&nbsp;</td>
			</tr>
		</table>
	</c:if>
	
	</body>
</html>