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
	
		function check(form){
			if(form["serialNos"].value.length > 15000){
				alert('<bean:message bundle="pageResources" key="page.worldOperation.SerialCodes.maxLength"/>');
				return false;
			}
			if(form["mediaName"].value == null | form["mediaName"].value == '') {
				alert('<bean:message bundle="pageResources" key="page.worldOperation.updateMediaName.mediaNametip"/>')
				return false ;
			}
			return true;
		}
		
		function gotoPage(obj){
			obj.submit();
		}
		function switchInput(){
			var fileInput=document.getElementById("fileInput");
			var pageInput=document.getElementById("pageInput");
			var selInput=document.getElementById("selInput").value;
			if(selInput==1){
				fileInput.style.display="";
				pageInput.style.display="none";
			}else{
				fileInput.style.display="none";
				pageInput.style.display="";
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<div align="center">
			<font color="red" size="3px"><html:errors /></font>
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<form action="updateSerialMedia.do" method="post" enctype="multipart/form-data" onsubmit="return check(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.updateSerialMedia.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/>：
				 </td>
				 <td class="t_border_r align="left" colspan="2">
				 	<input name="mediaName" style="width: 50%"/> 
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.updateMediaName.inputType"/>
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select id="selInput" onchange="switchInput()" style="width: 50%">
				 		<option value="1"><bean:message bundle="pageResources" key="page.worldOperation.updateMediaName.excelInput"/>：</option>
				 		<option value="2"><bean:message bundle="pageResources" key="page.worldOperation.updateMediaName.pageInput"/>：</option>
				 	</select>
				 </td>
			</tr>
			<tr height="30px" id="fileInput">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.CardFile"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="targetFile" type="file" style="width: 100%" /><br/>
				 	<span class="tip">
				 		<bean:message bundle="pageResources" key="page.worldOperation.updateMediaName.fileTip"/>
				 	</span>
				 </td>
			</tr>
			<tr height="30px" id="pageInput" style="display: none;">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/>：
				 </td>
				 <td class="t_border_4" align="left" colspan="2">
				 	<textarea name="serialNos" rows=15 cols=35 size="10240" style="width: 100%" ></textarea><br/>
				 	<span class="tip">
						<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.Remart"/>
					</span>
				 </td>				
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
	</c:if>
</body>
</html>