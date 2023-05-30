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
				if ( document.forms[0].prefix.value == "" || document.forms[0].prefix.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.prefix"/>');
					  document.forms[0].prefix.focus();
					  return false;
				}
				if ( document.forms[0].digit.value == "" || document.forms[0].digit.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.digit"/>');
					  document.forms[0].digit.focus();
					  return false;
				}
				
				if ( document.forms[0].digit.value < 9 || document.forms[0].digit.value > 16){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.digitLength"/>');
					  document.forms[0].digit.focus();
					  return false;
				}
				
				if ( document.forms[0].digit.value -  document.forms[0].prefix.value.length < 6){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.prefixLength"/>');
					  document.forms[0].digit.focus();
					  return false;
				}
				if ( document.forms[0].codeNum.value == "" || document.forms[0].codeNum.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.codeNum"/>');
					  document.forms[0].codeNum.focus();
					  return false;
				}
				if ( document.forms[0].codeNum.value > 100000){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.codeNumLength"/>');
					  document.forms[0].codeNum.focus();
					  return false;
				}
				if ( document.forms[0].batchNum.value == "" || document.forms[0].batchNum.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.batchNum"/>');
					  document.forms[0].batchNum.focus();
					  return false;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="generateActivityCode.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.title"/>
				</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.prefix"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="prefix" type="text" value="${requestScope.activityId}" style="width:200px" /><br />
				 	<strong><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.prefixDesc"/></strong>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.digit"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="digit" type="text" value="${requestScope.activityId}" style="width:200px" /><br />
				 	<strong><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.digitDesc"/></strong>
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.codeNum"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="codeNum" type="text" value="${requestScope.activityName}" style="width:200px" /><br />
				 	<strong><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.codeNumDesc"/></strong>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.batchNum"/> 
				 </td>
				<td class="t_border_r" align="left">
				 	<input name="batchNum" type="text" value="${requestScope.activityName}" style="width:200px" /><br />
				 	<strong><bean:message bundle="pageResources" key="page.worldOperation.generateActivityCode.batchNumDesc"/></strong>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityCode.do'" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>