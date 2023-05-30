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
			
			<c:forEach items="${requestScope.roleMenuItemList}" var="roleMenuItem" varStatus="status">
				<c:if test="${roleMenuItem.required == 1 }">
					if ( document.forms[0].${roleMenuItem.itemName }.value == "" || document.forms[0].${roleMenuItem.itemName }.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.point1"/>' + '${roleMenuItem.itemLabel }');
					  document.forms[0].${roleMenuItem.itemName }.focus();
					  return false;
					  }
				</c:if>
			</c:forEach>
			else {
				  return true;
			}
		}
		
		function changeOperType(object){
					
			var obj = document.getElementById("compensateId");
			alert(obj);
			var compensateId = obj.value;
			
			
			var url;		
			
			if(compensateId==""){
				url = "showCreateRoleCompensate.do?compensateType=${requestScope.compensateType}&dividedType=" + object.value;
			}
			if(compensateId!=""){
				url = "showEditRoleCompensate.do?compensateType=${requestScope.compensateType}&dividedType=" + object.value+"&compensateId=${requestScope.compensateId}";
			}			
			alert(url);
			//alert(object.innerHtml);
			window.location.href = url;
		}
		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="saveRoleCompensate.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleCompensate.edit"/>${title}
				<bean:message bundle="pageResources" key="page.roleCompensate.apply"/>&nbsp;&nbsp;&nbsp;&nbsp;
				<strong><bean:message bundle="pageResources" key="page.roleCompensate.inputOptional"/></strong></td>
			</tr>
			
		    <c:if test="${requestScope.dividedType > 0}">			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createPetCompensate.operType"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="type" style="width:150px;" onchange="changeOperType(this)">
						<c:forEach items="${requestScope.dividedTypeList}" var="dividedType">
						<c:if test="${dividedType.dividedType != 0}">
				  			<option value="${dividedType.dividedType }" 
				  			<c:if test="${dividedType.dividedType eq requestScope.dividedType}">
								selected
							</c:if >
				  			>${dividedType.dividedType} - ${dividedType.dividedDesc}</option>
				  		</c:if >
				  		</c:forEach>
					
				 </td>
			</tr>
			</c:if >
			<c:if test="${requestScope.gatewayNeeded > 0}">			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }"
				  			<c:if test="${gateway.gatewayId eq requestScope.roleCompensate.gatewayId}">
								selected
							</c:if >
							>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			</c:if >
				
			
			<gmweb:createRoleCompMenu roleCompMenuItemList="${requestScope.roleMenuItemList}" roleCompMenuOptionMap="${requestScope.roleMenuOptionMap}" menuValueMap="${requestScope.menuValueMap}" />
			

			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.reason"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<textarea name="reason" rows=5 cols=20 size="10240" >${requestScope.roleCompensate.reason}</textarea>
				 	<strong><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalCommentLength"/></strong>
				 	
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr1"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	 <input type="checkbox" name="commitFlag" value="1" /> <bean:message bundle="pageResources" key="page.roleCompensate.createAwardCompensate.commitAppr2"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input name="compensateId" id="compensateId" type="hidden" value="${requestScope.compensateId}" />
					<input name="compensateType" type="hidden" value="${requestScope.compensateType }" />					
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.submit"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg}</font>
		</div>
	</body>
</html>