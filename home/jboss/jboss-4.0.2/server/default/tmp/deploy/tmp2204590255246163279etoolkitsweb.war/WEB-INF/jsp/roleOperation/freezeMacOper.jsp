<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javaScript">
	String.prototype.trim=function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	} 
	function check(){
		var mac = document.getElementById('reason').value.trim();
		if(mac.length>0){
			return true;
		}else{
			alert('<bean:message bundle="pageResources" key="page.roleOperation.freezeMacOper.reason"/>');
			return false;
		}
	}
	</script>
</head>


<body bgcolor="#ffffff">
<c:if test="${state==1 }">
	<form action="freezeMac.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.freezeMac.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${mac }
				 	<input name="mac" type="hidden" value="${mac }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				<td class="t_border_r" align="left">
					<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="30px" style="display:none">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" name="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.freezeTime"/>
				 </td>
				 <td class="t_border_r" align="left">
					 <gmweb:createPunishTimeOption name="period" checkedValue="${requestScope.lastSecond}" />
				 </td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.freezeMac.reason"/>：
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="reason" ></textarea>
				  	<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.beginFreeze"/>" />
				</td>
			</tr>
		</table>
		</form>
</c:if>
<c:if test="${state!=1 }">
	<form action="unfreezeMac.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.unFreezePlayer"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	${mac }
				 	<input name="mac" type="hidden" value="${mac }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：</td>
				<td class="t_border_r" align="left">
					<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.freezeMac.reason"/>：
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="reason" ></textarea>
				  	<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.unFreezePlayer"/>" />
				</td>
			</tr>
		</table>
		</form>
</c:if>
	</body>
</html>