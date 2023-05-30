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
			function cancelWorldRate () {
				var gateway = document.getElementById("gatewayId").value ;
				var str = "" ;
				if(gateway==0){
					str="<bean:message bundle="pageResources" key="page.common.allServer"/>"
				}else{
					str="<bean:message bundle="pageResources" key="page.worldOperation.cancelWorldDropRate.gatewayMessage"/>"+gateway ;
				}
				if(window.confirm("<bean:message bundle="pageResources" key="page.worldOperation.cancelWorldDropRate.cancelgatewayTip"/>"+str+"<bean:message bundle="pageResources" key="page.worldOperation.cancelWorldDropRate.cancelAllconfig"/>"))
					window.location.href='cancelWorldDropRate.do?gatewayId=' + gateway ;
			}
		</script>
	</head>
	

	<body bgcolor="#ffffff">
		<form action="showCanCancelRate.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.worldDropRate.title"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right" style="border-bottom:#AEAEB0 1px solid;"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left" style="border-bottom:#AEAEB0 1px solid;">
				 	<select id="gatewayId" name="gatewayId" style="width:150px" onchange="window.location.href='showCanCancelRate.do?gatewayId='+this.value;">
				 		<option value="0">0-<bean:message bundle="pageResources" key="page.common.allServer"/></option>
				  		<c:forEach items="${requestScope.gateways}" var="gateway">
				  			<option value="${gateway.gatewayId }" <c:if test="${ gatewayId == gateway.gatewayId}">selected</c:if>>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
		</table>
		</form>
		<c:if test="${not empty requestScope.page}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td align="center" height="30PX" colspan="10"></td>
		</tr>
			
		<tr>
			<td align="center" height="30PX"></td>
		</tr>
			<c:forEach items="${page.list}" var="dataArray" varStatus="status">
				<tr <c:choose>
					<c:when test="${status.first }">height='23px' class='h_CDE4F6'</c:when>   
					<c:when test="${status.last }">style='border-bottom:#AEAEB0 1px solid;'</c:when>
					<c:otherwise>height='23px'</c:otherwise>
				</c:choose>>
					<c:forEach items="${dataArray}" var="data" varStatus="datastatus">
						<td  <c:choose>
							<c:when test="${datastatus.last }">class='t_border_r'</c:when>
							<c:otherwise>class='t_border_l'</c:otherwise></c:choose>>
							${data }
						</td>
					</c:forEach>
				</tr>
			</c:forEach>
			<tr height="30px">
			<td colspan="11" align="center" class="t_border">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.add"/>" onClick="window.location.href='showWorldDropRate.do';"/>&nbsp;&nbsp;&nbsp;
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.cancel"/>" onClick="cancelWorldRate ();"/>
			</tr>
		</table>
		</c:if>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
  	</body>
</html>