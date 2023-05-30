<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
				if(document.forms[0].hardwareSNList.value.trim() == "" || document.forms[0].hardwareSNList.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.roleOperation.hardwareSN.errorBlankInput"/>');
						document.forms[0].hardwareSNList.focus();
						return false;
				}else if ( document.forms[0].hardwareSNList.value.length > 100000){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.hardwareSN.errorExcessiveInput"/>');
						document.forms[0].hardwareSNList.focus();
						return false;
				}
				else {
					  return true;
				}
			}
			
		
		
	</script>
</head>


<body bgcolor="#ffffff">	
	<form action="freezeHardwareSN.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			
			<tr>
				<td colspan="3" align="center" height="30PX"></td>
			</tr>
		
			
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.roleOperation.hardwareSN.freezeHardwareSN"/>
				</td>
			</tr>
			
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.hardwareSN"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="hardwareSNList" rows=10 cols=35 size="10240"  >${requestScope.hardwareSNList}</textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.roleOperation.hardwareSN.inputTips"/>
					</span>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="query" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.hardwareSN.beginFreeze"/>" />
				</td>
			</tr>			
		</table>
	</form>
	
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>	
	</body>
</html>