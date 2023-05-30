<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javaScript">
		function check(){
			var beginDate = document.forms[0].beginDate.value;
			var endDate = document.forms[0].endDate.value;
			beginDate = new Date(beginDate.replace(/-/g,"/"));
			endDate = new Date(endDate.replace(/-/g,"/"));
			var date = (endDate-beginDate)/(24*60*60*1000);
			if ( document.forms[0].activityId.value == "" || document.forms[0].activityId.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.activityId"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			if ( document.forms[0].activityId.value.length != 10){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.activityIdLength"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			if ( document.forms[0].items.value == "" || document.forms[0].items.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.items"/>');
				  document.forms[0].items.focus();
				  return false;
			}
			if ( document.forms[0].items.value.length > 4000){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.itemsLength"/>');
				  document.forms[0].items.focus();
				  return false;
			}
			if ( document.forms[0].playerNames.value == "" || document.forms[0].playerNames.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.playerNames"/>');
				  document.forms[0].playerNames.focus();
				  return false;
			}
			if ( document.forms[0].playerNames.value.length > 20000){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.playerNamesLength"/>');
				  document.forms[0].playerNames.focus();
				  return false;
			}
			if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.reason"/>');
				  document.forms[0].reason.focus();
				  return false;
			}
			if ( document.forms[0].reason.value.length > 512){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.reasonLength"/>');
				  document.forms[0].reason.focus();
				  return false;
			}
			if ( document.forms[0].beginDate.value == "" || document.forms[0].beginDate.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.beginDate"/>');
				  document.forms[0].beginDate.focus();
				  return false;
			}
			if ( document.forms[0].endDate.value == "" || document.forms[0].endDate.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.endDate"/>');
				  document.forms[0].endDate.focus();
				  return false;
			}
			if (date<0){
				alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.timeInfo"/>');
				document.forms[0].beginDate.focus();
				return false;
			}
			else {
				  return true;
			}
		}
		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="newValidateCreate.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="gatewayId">
				 		<option value="0" <c:if test="${requestScope.gatewayId == 0 }">selected</c:if>>0 - <bean:message bundle="pageResources" key="page.roleCompensate.common.allGateway"/></option>
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }" <c:if test="${requestScope.gatewayId == gateway.gatewayId }">selected</c:if>>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
					<bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.gatewayInfo"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.activityId"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="activityId" type="text" value="${requestScope.activityId }" /><br/>
				 	<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.tip"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.items"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="items" rows=8 cols=35 size="10240" >${requestScope.items }</textarea>
				 	
				 </td>
				 <td class="t_border_r" align="left">
				<bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.itemsInfo"/> <br />
					i-88001,5<br />
					i-88002,3
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.playerNames"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="playerNames" rows=8 cols=35 size="10240" >${requestScope.playerNames }</textarea>
				 </td>
				 <td class="t_border_r" align="left">
				<bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.playerNamesInfo"/><br />
				user1<br />
				user2
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.reason"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<textarea name="reason" rows=5 cols=35 size="10240" >${requestScope.reason }</textarea>
				 	<bean:message bundle="pageResources" key="page.roleCompensate.common.wordLength512"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="beginDate" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${requestScope.beginDate }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.endTime"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="endDate" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="${requestScope.endDate}" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr1"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	 <input type="checkbox" name="commitFlag" value="1" <c:if test="${requestScope.commitFlag == '1' }">checked</c:if> /><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="compensateId" type="hidden" value="${requestScope.compensateId }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.next"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>