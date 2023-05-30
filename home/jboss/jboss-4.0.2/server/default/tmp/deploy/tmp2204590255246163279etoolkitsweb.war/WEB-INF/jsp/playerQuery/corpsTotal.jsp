<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
	function corpsDetail(name){
		document.getElementById('corpsName').value=name;
		document.forms[0].action = 'corpsDetail.do';
		document.forms[0].submit();
	}
	
	function CorpsMember(name){
		document.getElementById('corpsName').value=name;
		document.forms[0].action = 'corpsMember.do';
		document.forms[0].submit();
	}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${not empty requestScope.gatewayList }">
		<form action="corpsTotal.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
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
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	<c:if test="${not empty requestScope.corpsTotalList }">
	<form method="post">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="7" align="center" ></td>
		</tr>
		<tr>
			<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.title"/> </td>
		</tr>
				
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.index"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.name"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.lv"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.count"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.creator"/></td>
			<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.creatorTime"/></td>
			<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.operationType"/></td>
		</tr>
			<c:forEach items="${requestScope.corpsTotalList}" var="corpsTotal" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${corpsTotal.corpsName }"/></td>
					<td align="center" class="t_border_l">${corpsTotal.corpsLevel }</td>
					<td align="center" class="t_border_l">${corpsTotal.corpsCount }</td>
					<td align="center" class="t_border_l">${corpsTotal.corpsCreator }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${corpsTotal.corpsCreatetime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_r">
						<a onmouseover="this.style.cursor='hand'" onclick="corpsDetail('${corpsTotal.corpsName }')"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.detail"/></a>&nbsp;&nbsp;
						<a onmouseover="this.style.cursor='hand'" onclick="CorpsMember('${corpsTotal.corpsName }')"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.people"/></a>
					</td>
				</tr>
			</c:forEach>
		<tr height="5px">
			<td colspan="7" class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" >
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>"   onclick="window.location.href='showCorpsTotal.do'">
				<input type="hidden" name="gatewayId" value="${gatewayId }"/>
				<input type="hidden" id="corpsName" name="corpsName"/>
			</td>
		</tr>
	</table>
	</form>
	</c:if>
	<c:if test="${not empty requestScope.corpsDetailList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="2" align="center" ></td>
		</tr>
		<tr>
			<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.title"/> </td>
		</tr>
		<c:forEach items="${requestScope.corpsDetailList}" var="corpsDetail" varStatus="status">
			<tr height="23px">
				<td align="center" class="t_border_l">${corpsDetail.name }</td>
				<td align="center" class="t_border_r">${corpsDetail.value }&nbsp;</td>
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>"   onclick="Javascript:history.back(-1);">
			</td>
		</tr>
	</table>
	</c:if>
	<c:if test="${not empty requestScope.corpsMemberList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr height="30px">
			<td colspan="50" align="center" ></td>
		</tr>
		<tr>
			<td colspan="50" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.corpsTotal.title"/> </td>
		</tr>
		<c:forEach items="${requestScope.corpsMemberList}" var="corpsMember" varStatus="status">
			<tr height="23px" >
				<c:forEach items="${corpsMember}" var="corpsMemberInfo" varStatus="status2">
					<td align="center" class="t_border_r">${corpsMemberInfo.name }：${corpsMemberInfo.value }</td>
				</c:forEach>
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="50">
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