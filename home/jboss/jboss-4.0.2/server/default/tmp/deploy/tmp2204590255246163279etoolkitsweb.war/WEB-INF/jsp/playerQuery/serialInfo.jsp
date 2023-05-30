<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/queryBatchSerialInfo"/>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">		
	
		var remarks = new Array();
		remarks[0] = '<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/>';
		remarks[1] = '<bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/>';
		
		function changeName(obj){
			document.getElementById("conditionText").innerHTML = obj.options[obj.selectedIndex].text+"：";
			var remark = document.getElementById("remark").innerHTML;
			if(obj.value == 1)document.getElementById("remark").innerHTML = remark.replaceAll(remarks[1],remarks[0]);
			else document.getElementById("remark").innerHTML = remark.replaceAll(remarks[0],remarks[1]);

		}
		
		function check(form){
			if(form["condition"].value.length > 15000){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.SerialCodes.maxLength"/>');
				return false;
			}
			return validateQuerySerialInfoForm(form);
		}
		
		function gotoPage(obj){
			obj.submit();
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="queryBatchSerialInfo.do" method="post" onsubmit="return check(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.type"/>
				 </td>
				 <td class="t_border_l" align="left" colspan="2">
				 	<select name="queryType" onchange="changeName(this)">
						<option value="1"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>：
				 </td>
				 <td class="t_border_l" align="left">
				 	<input type="text" name="activityId"/>
				 </td>
				 <td class="t_border_r" align="left">
					<span>
					<bean:message bundle="pageResources" key="page.playerQuery.serialInfo.activityTip"/>
					</span>
				</td>
			</tr>
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/>：
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="condition" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
					<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.Remart"/>
					</span>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="9" align="center" ></td>
			</tr>
			<tr>
				<td colspan="9" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNumState"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.roleName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.lv"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.queryBatchSerialInfo.recharge"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.queryBatchSerialInfo.consume"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.vipCardTime"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="serialInfo">
			<tr height="23px">
				<td align="center" class="t_border_l">${serialInfo.serialNo }</td>
				<td align="center" class="t_border_l">${serialInfo.mediaName }</td>
				<td align="center" class="t_border_l">
					<c:choose>
						<c:when test="${serialInfo.serialState == 0 }"><bean:message bundle="pageResources" key="page.common.not.used"/></c:when>
						<c:otherwise><bean:message bundle="pageResources" key="page.common.used"/></c:otherwise>
					</c:choose>
				</td>
				<td align="center" class="t_border_l">&nbsp;<c:out value="${serialInfo.userName }"/></td>
				<td align="center" class="t_border_l">&nbsp;<c:out value="${serialInfo.roleName }"/></td>
				<td align="center" class="t_border_l">
					<c:choose>
						<c:when test="${serialInfo.roleLevel == 0 }">&nbsp;</c:when>
						<c:otherwise>${serialInfo.roleLevel }</c:otherwise>
					</c:choose>
				</td>
				<td align="center" class="t_border_l">${serialInfo.recharge }</td>
				<td align="center" class="t_border_l">${serialInfo.consume }</td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${serialInfo.useTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="9" align="center" class="t_border">
				<form name="pageForm" action="queryBatchSerialInfo.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="queryType" value="${queryType}"/>
					<input type="hidden" name="activityId" value="${activityId}"/>
					<input type="hidden" name="condition" value="${condition}"/>
				</form>
				<form action="exportAllSerialInfo.do" method="post" id="exportSerial">
					<input type="hidden" name="queryType" value="${queryType}"/>
					<input type="hidden" name="activityId" value="${activityId}"/>
					<input type="hidden" name="condition" value="${condition}"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.exportAll"/>" onclick="document.getElementById('exportSerial').submit();"/>
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryBatchSerialInfo.do'"/>
		</div>
	</c:if>
</body>
</html>