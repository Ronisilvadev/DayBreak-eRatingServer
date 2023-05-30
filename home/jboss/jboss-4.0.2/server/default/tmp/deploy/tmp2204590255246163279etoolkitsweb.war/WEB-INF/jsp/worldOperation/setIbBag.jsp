<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
		function check(){
				var type = document.forms[0].type.value;
				
				if (type == 0 || type == 1) {
					if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
						  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
						  document.forms[0].gatewayId.focus();
						  return false;
					}
					
					if ( document.forms[0].bagId.value == "" || document.forms[0].bagId.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.bagId"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].bagId.focus();
							return false;
					}
					
					if ( document.forms[0].itemIdList.value == "" || document.forms[0].itemIdList.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemIdList"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].itemIdList.focus();
							return false;
					}
					if ( document.forms[0].itemNumList.value == "" || document.forms[0].itemNumList.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemNumList"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].itemNumList.focus();
							return false;
					}
					if ( document.forms[0].itemOpList.value == "" || document.forms[0].itemOpList.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemOpList"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].itemOpList.focus();
							return false;
					}
				} else if (type == 2){
					if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
						  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
						  document.forms[0].gatewayId.focus();
						  return false;
					}
					if ( document.forms[0].bagId.value == "" || document.forms[0].bagId.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.bagId"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].bagId.focus();
							return false;
					}
				} else {
					if ( document.forms[0].gatewayId.value == "" || document.forms[0].gatewayId.value  == null){
						  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
						  document.forms[0].gatewayId.focus();
						  return false;
					}
				}
				return true;
			}
	</script>
</head>


<body bgcolor="#ffffff">	
	<form action="setIbBag.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.title"/>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbBag.bagId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="bagId" type="text" style="width:200px" />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.common.oprateType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="type" style="width:60px">
						<option value="0"><bean:message bundle="pageResources" key="page.common.insert"/></option>
						<option value="1"><bean:message bundle="pageResources" key="page.common.update"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.common.delete"/></option>
						<option value="4"><bean:message bundle="pageResources" key="page.common.query"/></option>
					</select>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemIdList"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemIdList" type="textarea" style="width:200px;height:120px" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.tip"/>
				 </td>
			</tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemNumList"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemNumList" type="textarea" style="width:200px;height:120px" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemNumtip"/>
				 </td>
			</tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemOpList"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemOpList" type="textarea" style="width:200px;height:120px" />
				 	<bean:message bundle="pageResources" key="page.worldOperation.setIbBag.itemOptip"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="20" align="center" ></td>
			</tr>
			<tr>
				<td colspan="20" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.setIbBag.title"/></td>
			</tr>
			<c:forEach items="${requestScope.pageInfo.list}" var="parentInfo" varStatus="parStatus">
			<tr height="23px">			
			<c:forEach items="${parentInfo}" var="childInfo" varStatus="childStatus">								
				<td align="center" class="t_border_r"><c:out value="${childInfo}"/>&nbsp;</td>				
			</c:forEach>			
			</tr>
		</c:forEach>
			<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				&nbsp;
			</td>
		</tr>
		</table>		
		</form>
		</c:if>
		
	</body>
</html>