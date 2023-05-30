<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
		<script type="text/javascript">
		<!-- 
			function gotoPage(obj){
				var page = obj.page.options[obj.page.selectedIndex].value;
     			obj.reset();
     			obj.action = "logManage.do?method=showLog";
				obj.method = "post";
				obj.page.options[page -1].selected = true;
				obj.submit();
			}
			
			function searchSubmit(obj){
				obj.action = "logManage.do?method=showLog";
				obj.method = "post";
				obj.page.value = 1;
				if (checkForm(obj)){
					obj.submit();
				}
			}
			
			function checkForm(obj){
				var beginDate = obj.beginDate.value;
				var endDate = obj.endDate.value;
				if (beginDate.length != "" && endDate == ""){
					alert('<bean:message bundle="pageResources" key="page.logManage.log.errorEndTime"/>');
					obj.endDate.focus();
					return false;
				}
				if (beginDate.length == "" && endDate != ""){
					alert('<bean:message bundle="pageResources" key="page.logManage.log.errorBeginTime"/>');
					obj.beginDate.focus();
					return false;
				}
				
				return true;
			}
		-->
			
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="logManage.do?method=showLog" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.logManage.log.title"/></td>
			</tr>
			<tr height="30px">
				<td width="85%" class="t_border_l" style="padding-left:50px" align="left"><bean:message bundle="pageResources" key="page.logManage.log.key"/>：
					  <input name="keyWord" type="text" size="10" value="${keyWord }"/>
					  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					  <c:if test="${requestScope.searchType == 'passportName' }">
					  		<input type="radio" name="searchType" value="realName" /><bean:message bundle="pageResources" key="page.logManage.log.name"/>
					  		<input type="radio" name="searchType" value="passportName" checked /><bean:message bundle="pageResources" key="page.logManage.log.passportName"/>
					  </c:if>
					  <c:if test="${requestScope.searchType != 'passportName' }">
					  		<input type="radio" name="searchType" value="realName" checked /><bean:message bundle="pageResources" key="page.logManage.log.name"/>
					  		<input type="radio" name="searchType" value="passportName" /><bean:message bundle="pageResources" key="page.logManage.log.passportName"/>
					  </c:if>
					  &nbsp;&nbsp;&nbsp;
					  <select name="operType">
					  	<option value="0"><bean:message bundle="pageResources" key="page.logManage.log.allType"/></option>
					  	<c:if test="${not empty requestScope.logTypeList }">
						<c:forEach items="${requestScope.logTypeList}" var="logType">
					  	<option value="${logType}" <c:if test="${logType == requestScope.operType}">selected</c:if>>
							${logType}
						</option>
						</c:forEach>
						</c:if>
					  </select>
				 </td>
				 <td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" rowspan="2" align="center">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.logManage.log.search"/>" onclick="searchSubmit(document.forms[0]);"/>
				</td>
				
			</tr>
			<tr height="30px">
				<td class="t_border_l" style="border-bottom:#AEAEB0 1px solid;padding-left:60px" align="left">
					<bean:message bundle="pageResources" key="page.logManage.log.beginDate"/>：&nbsp;&nbsp;<input type="text" name="beginDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" size="10"/>&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.logManage.log.endDate"/>：<input type="text" name="endDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" size="10"/><bean:message bundle="pageResources" key="page.logManage.log.info"/>
				</td>
			</tr>
		</table>
		<br />
		<br />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="8" align="center" class="t_head"><bean:message bundle="pageResources" key="page.logManage.log.title2"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.name"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.operType"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.operTime"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.playerName"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.roleName"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.gateway"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.logManage.log.reason"/></td>
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.logManage.log.operDesc"/></td>
			</tr>
			
			<c:if test="${not empty requestScope.pageInfo }">
			<c:if test="${not empty requestScope.pageInfo.infoList }">
			<c:forEach items="${requestScope.pageInfo.infoList}" var="logInfo">
			
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">${logInfo.realName }</td>
				<td width="10%" align="center" class="t_border_l">${logInfo.operType }</td>
				<td width="10%" align="center" class="t_border_l"><fmt:formatDate value="${logInfo.operDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td width="10%" align="center" class="t_border_l">&nbsp;${logInfo.playerName }</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;${logInfo.roleName }</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;
				<c:if test="${logInfo.gatewayName == 'server0' }"><bean:message bundle="pageResources" key="page.tag.CreateGatewayOptionTag.tag1"/></c:if> 
				<c:if test="${logInfo.gatewayName == 'server1' }"><bean:message bundle="pageResources" key="page.tag.CreateGatewayOptionTag.tag2"/></c:if>
				<c:if test="${logInfo.gatewayName == 'server2' }"><bean:message bundle="pageResources" key="page.tag.CreateGatewayOptionTag.tag3"/></c:if>
				<c:if test="${logInfo.gatewayName != 'server0' && logInfo.gatewayName != 'server1' && logInfo.gatewayName != 'server2' }">${logInfo.gatewayName }</c:if>
				</td>
				<td width="10%" align="center" class="t_border_l">&nbsp;${logInfo.reason }</td>
				<td width="20%" align="center" class="t_border_r">${logInfo.operDesc }</td>
			</tr>
			</c:forEach>
			</c:if>
			</c:if>
			<tr height="30px">
			  	<td colspan="8" align="center" class="t_border">
			  		<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" /> 	
				</td>
			</tr>
			<c:if test="${empty requestScope.pageInfo.infoList }">
				<script type="text/javascript">
				<!--
					document.getElementById("page").disabled = true;
				-->
				</script>
			</c:if>
		</table>
		</form>
		<script type="text/javascript">
				<!--
					document.getElementById("keyWord").focus();
					document.onkeydown = function(e){
						var event = window.event || e;
						if(event.keyCode == 13){
							searchSubmit(document.forms[0]);
						}
					}
				-->
		</script>
	</body>
</html>
