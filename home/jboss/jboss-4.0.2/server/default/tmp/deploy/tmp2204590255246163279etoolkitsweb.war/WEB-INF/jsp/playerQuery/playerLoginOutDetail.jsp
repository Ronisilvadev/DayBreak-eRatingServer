<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
		
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
			if(getQurType() == 1){
				if ( document.forms[0].playerName.value.trim() == "" || document.forms[0].playerName.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.playerLoginOutDetail.errors.playerName"/>');
					  document.forms[0].playerName.focus();
					  return false;
				}
			}
			if(getQurType() == 2){
				if ( document.forms[0].playerName.value.trim() == "" || document.forms[0].playerName.value.trim()  == null){
					  alert('<bean:message bundle="pageResources" key="page.playerLoginOutDetail.errors.mac"/>');
					  document.forms[0].playerName.focus();
					  return false;
				}
			}
			if ( document.forms[0].beginDate.value.trim() == "" || document.forms[0].beginDate.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.playerLoginOutDetail.errors.beginDate"/>');
				  document.forms[0].beginDate.focus();
				  return false;
			}
			if ( document.forms[0].endDate.value.trim() == "" || document.forms[0].endDate.value.trim()  == null){
				  alert('<bean:message bundle="pageResources" key="page.playerLoginOutDetail.errors.endDate"/>');
				  document.forms[0].endDate.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
		
		function getQurType(){
			for(var i =0;i<document.forms[0].qurType.length;i++){
	      		if (document.forms[0].qurType[i].checked== true ){
	       			return document.forms[0].qurType[i].value;
	      		}
    		}
		}
		
		function selType(obj){
			if(obj == 1){
				mac.style.display='none';
				passport.style.display='';
			}
			if(obj == 2){
				passport.style.display='none';
				mac.style.display='';
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="getPlayerLoginOutDetail.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right" id="passport"><bean:message bundle="pageResources" key="page.common.passport"/>：
				 </td>
				 <td width="35%" class="t_border_l" align="right" id="mac" style="display:none"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="playerName" type="text" style="width:200px" value="${requestScope.playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.roleInfo.type"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<bean:message bundle="pageResources" key="page.common.passport"/><input type="radio" id="qurType" name="qurType" value="1" checked onclick="selType(1)"/>&nbsp;&nbsp;&nbsp;<bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/><input type="radio" id="qurType" name="qurType" value="2" onclick="selType(2)"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
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
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="12" align="center" ></td>
			</tr>
			<tr>
				<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "${playerName }" <bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.playerLoginout"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.server"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.lv"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.money"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.money"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.exp"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.inTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.outTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.IP"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.province"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="playerLoginOutDetail" varStatus="status">
			<tr height="23px">
					<td align="center" class="t_border_l"><c:out value="${playerLoginOutDetail.playerName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${playerLoginOutDetail.roleName}"/></td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.serverId }</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.roleLevel }</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.money }</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.bindMoney }</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.experience }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${playerLoginOutDetail.loginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">
						<c:if test="${empty playerLoginOutDetail.logoutTime }">
							<c:if test="${status.index == 0 }">
								<bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.online"/>
							</c:if>
							<c:if test="${status.index != 0 }">
								<bean:message bundle="pageResources" key="page.common.exception"/>
							</c:if>
						</c:if>
						<c:if test="${not empty playerLoginOutDetail.logoutTime }">
							<fmt:formatDate value="${playerLoginOutDetail.logoutTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
					</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.loginIp }&nbsp;</td>
					<td align="center" class="t_border_l">${playerLoginOutDetail.mac }&nbsp;</td>
					<td align="center" class="t_border_r">${playerLoginOutDetail.provinceCode }&nbsp;${playerLoginOutDetail.cityCode }</td>
				</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="12" align="center" class="t_border">
				<form name="pageForm" action="getPlayerLoginOutDetail.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="beginDate" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="endDate" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="playerName" value="${playerName}"/>
					<input type="hidden" name="qurType" value="${qurType}"/>
				</form>
				</td>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryPlayerLoginOutDetail.do'"/>
		</div>
	</c:if>
</body>
</html>