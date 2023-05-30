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
				var reg = /^[0-9]*$/;
				var word = document.forms[0].word.value; 
				var level = document.forms[0].level.value;
				
				if (type == 0) { //增加					
					if (word == "" || word == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.word"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].word.focus();
							return false;
					}
					
					if (level == "" || level == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.level"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].level.focus();
							return false;
					}
					if (!reg.test(level)) {
						alert('<bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.levelTip"/>');
						document.forms[0].level.focus();
						return false;
					}
					
				} else if (type == 2){ //删除
					if ( document.forms[0].word.value == "" || document.forms[0].word.value  == null){
							alert('<bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.word"/><bean:message bundle="pageResources" key="page.common.non-null"/>');
							document.forms[0].word.focus();
							return false;
					}
				} 
				
				return true;
			}
	</script>
</head>


<body bgcolor="#ffffff">	
	<form action="operateDirtyWord.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.title"/>
				</td>
			</tr>
			<tr>
				<td width="35%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:230px">
						<c:forEach items="${requestScope.gatewayList}" var="gateway">
							<option value="${gateway.gatewayId }">${gateway.gatewayId }-${gateway.gatewayName }</option>
						</c:forEach>
					</select>
				 </td>
			</tr>
			<td width="35%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.common.oprateType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="type" style="width:60px">
						<option value="0"><bean:message bundle="pageResources" key="page.common.insert"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.common.delete"/></option>
					</select>
				 </td>
			</tr>
			<tr>
			<td width="35%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.word"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="word" type="text"/>				 	
				 </td>
			</tr>
			<tr>
			<td width="35%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.dirtyWord.level"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="level" type="text" style="width:60px"/>
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
		
	</body>
</html>