<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	
</head>

<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.gatewayList }">
		<form action="corpsStorage.do" method="post" onsubmit="return validateCorpsDetailNewForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.corpsStorage.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.corpsName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="corpsName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.corpsType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="corpsType">				  		
				 		<c:forEach items="${requestScope.dicList }" var="dic">
				 			<option value="${dic.opValue }">${dic.opValue } - ${dic.opText }</option>
				 		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${not empty requestScope.corpsStorageList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="20" align="center" ></td>
		</tr>
		<tr>
			<td colspan="20" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.corpsStorage.title"/> </td>
		</tr>
		
		<c:forEach items="${requestScope.corpsStorageList}" var="parentInfo" varStatus="prtStatus">
			<tr height="23px">
			<c:forEach items="${parentInfo}" var="childInfo" varStatus="childStatus">				
				<c:if test="${prtStatus.index == 0}">
					<td align="center" class="t_border_r"><c:out value="${childInfo}"/>&nbsp;</td>	
				</c:if>				
				<c:if test="${prtStatus.index != 0}">
					<c:if test="${childStatus.index == 0}">
						<td align="center" class="t_border_r"><a href="corpsItem.do?itemId=${childInfo}&corpsName=${requestScope.corpsName}&corpsType=${requestScope.corpsType}&gatewayId=${requestScope.gatewayId}">${childInfo}</a>&nbsp;</td>
					</c:if>
					<c:if test="${childStatus.index != 0}">
						<td align="center" class="t_border_r"><c:out value="${childInfo}"/>&nbsp;</td>
					</c:if>	
				</c:if>				
			</c:forEach>	
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>"   onclick="Javascript:history.back(-1);">
			</td>
		</tr>
	</table>
	</c:if>
	
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>