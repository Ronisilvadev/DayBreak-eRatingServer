<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript">
	    function gotoPage(obj){
			obj.submit();
		}
	  //验证IP是否合法  
		function isValidIP(strIP) {  
		    var re=/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/g; // 匹配IP地址的正则表达式  
		    if(re.test(strIP))  
		        if( RegExp.$1 <256 && RegExp.$2<256 && RegExp.$3<256 && RegExp.$4<256)   
		            return true;  
		    return false;  
		}
	</script>
	<script type="text/javascript">
		function check(){
			var ip = document.getElementById("paramIp").value;
			if(ip==''){
			    alert('<bean:message bundle="pageResources" key="page.playerQuery.queryByIp.IPnull"/>');
			    return false;
			}
			if(!isValidIP(ip)){
				alert('<bean:message bundle="pageResources" key="page.playerQuery.queryByIp.IPnull"/>');
			    return false;
			}
		}
	</script>
	
</head>


<body bgcolor="#ffffff">
       <c:if test="${empty requestScope.pageInfo}">
		<form action="queryByIp.do" method="post" onsubmit=" return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.queryByIp.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/></td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				 		<option value="0" selected>0 - <bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.IP"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="ip" id="paramIp"></input>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="startTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<fmt:formatDate value="${ requestScope.startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left">
					<input type="text" name="endTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					<!-- 
				 	<input type="text" name="endTime" value="<fmt:formatDate value="${endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})">
				    -->
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="curPage" value="1" />
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
	</c:if>
	<c:if test="${not empty requestScope.pageInfo}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="5" align="center" ></td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.queryByIp.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerPassport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.loginInfo.loginOutTime"/></td>				
			</tr>
			<c:forEach items="${requestScope.pageInfo.infoList}" var="queryByIp">
				<tr height="23px">
					<td align="center" class="t_border_l">${queryByIp.playerName}</td>
					<td align="center" class="t_border_l">${queryByIp.roleName}</td>
					<td align="center" class="t_border_l">&nbsp;<fmt:formatDate value="${queryByIp.loginTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">&nbsp;<fmt:formatDate value="${queryByIp.loginOutTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>					
				</tr>
			</c:forEach>
			<tr height="30px">
				<td colspan="12" align="center" class="t_border">
				<form name="pageForm" action="queryByIp.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="startTime" value="<fmt:formatDate value="${requestScope.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					<input type="hidden" name="endTime" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					<input type="hidden" name="ip" value="${requestScope.ip}"/>
					<input type="hidden" name="gatewayId" value="${requestScope.gatewayId}"/>
				</form>
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</c:if>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
</body>
</html>