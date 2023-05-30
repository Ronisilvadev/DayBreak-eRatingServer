<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javaScript">
			function check(){
				if ( document.forms[0].roleName.value == "" || document.forms[0].roleName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.roleName"/>');
					  document.forms[0].roleName.focus();
					  return false;
				}
				if ( document.forms[0].skillId.value == "" || document.forms[0].skillId.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.skillId"/>');
					  document.forms[0].skillId.focus();
					  return false;
				}
				if ( document.forms[0].skillName.value == "" || document.forms[0].skillName.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.skillName"/>');
					  document.forms[0].skillName.focus();
					  return false;
				}
				if ( document.forms[0].skillLevel.value == "" || document.forms[0].skillLevel.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.skillLevel"/>');
					  document.forms[0].skillLevel.focus();
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
				else {
					  return true;
				}
			}
			
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="saveSkillCompensate.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.roleCompensate.createSkillCompensate.title"/></td>
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
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.roleName"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="roleName" type="text" value="${requestScope.skillCompensate.ROLE_NAME }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.skillId"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="skillId" type="text" value="${requestScope.skillCompensate.SKILL_ID }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.skillName"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="skillName" type="text" value="${requestScope.skillCompensate.SKILL_NAME }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.skillLevel"/> 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="skillLevel" type="text" value="${requestScope.skillCompensate.SKILL_LEVEL }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleCompensate.common.reason"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<textarea name="reason" rows=5 cols=35 size="10240" >${requestScope.skillCompensate.REASON }</textarea>
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
					<input name="compensateId" type="hidden" value="${requestScope.skillCompensate.COMPENSATE_ID }" />
					<input name="oper" type="hidden" value="${requestScope.oper }" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.common.submit"/> " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>