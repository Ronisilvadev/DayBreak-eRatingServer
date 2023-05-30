<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/saveAddItemCompensate"/>
</head>


<body bgcolor="#ffffff">
	<html:form action="saveAddItemCompensate.do" method="post" onsubmit="return validateAddItemCompensateForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.title2"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="gatewayId">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }" <c:if test="${requestScope.gatewayId == gateway.gatewayId }">selected</c:if>>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.ROLE_NAME"/>： 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
					<input name="roleName" type="text" value="${requestScope.AddItemCompensate.ROLE_NAME }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.ITEM_ID"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="itemId" type="text" value="${requestScope.AddItemCompensate.ITEM_ID }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.ITEM_NUM"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="itemNum" type="text" value="${requestScope.AddItemCompensate.ITEM_NUM }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.STAR"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="star" type="text" value="${requestScope.AddItemCompensate.STAR }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.LEVEL"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="level" type="text" value="${requestScope.AddItemCompensate.LEVEL }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.BIND"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="bind" >
				 		<option value="0" <c:if test="${requestScope.AddItemCompensate.BIND == '0'}">selected</c:if> ><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.bindValue0"/></option>
				 		<option value="1" <c:if test="${requestScope.AddItemCompensate.BIND == '1'}">selected</c:if> ><bean:message bundle="pageResources" key="page.roleCompensate.AddItem.bindValue1"/></option>
				 	</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.reason"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<textarea name="reason" rows=5 cols=35 size="10240" >${requestScope.AddItemCompensate.REASON }</textarea>
				 	<bean:message bundle="pageResources" key="page.roleCompensate.common.wordLength512"/>
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
					<input name="compensateId" type="hidden" value="${requestScope.AddItemCompensate.COMPENSATE_ID }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.submit"/> " />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>