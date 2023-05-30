<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head><link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script language="javascript">
		function onfileChange (val){
			if(val.value.indexOf(".xls")!=val.value.length-4){
				alert("<bean:message bundle="pageResources" key="page.dictionary.importItem.extMarch"/>") ;
				document.getElementById('import').disabled = true ;
				val.value="" ;
				return ;
			}
				document.getElementById('import').disabled = false ;
				return ;
		}
	</script>
  </head>
  
  <body bgcolor="#ffffff">
	 <form action="importFromFile.do" method="post" enctype="multipart/form-data">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.dictionary.importItem.title"/>
				</td>
			</tr>
			<tr height="23px" >
				<td width="40%" align="right" class="t_border_l">
				<bean:message bundle="pageResources" key="page.dictionary.importItem.gmorBi"/></td>
				<td align="left" class="t_border_r">
					<select name="targetDatabase">
						<option value="0" selected><bean:message bundle="pageResources" key="page.dictionary.importItem.gm"/></option>
						<!-- <option value="1"><bean:message bundle="pageResources" key="page.dictionary.importItem.bi"/></option>
						 -->
					</select>
				</td>
			</tr>
			<tr height="23px">
				<td width="40%" align="right" class="t_border_l">
				<bean:message bundle="pageResources" key="page.dictionary.importItem.fromFile"/></td>
				<td align="left" class="t_border_r">
					<input name="targetFile" type="file" onchange=" onfileChange(this) ;"  />
				</td>
			</tr>
			<tr height="23px">
				<td width="40%" align="right" class="t_border_l">
				<bean:message bundle="pageResources" key="page.worldOperation.importItem.format"/></td>
				<td align="left" class="t_border_r">
					<table  border="0" cellpadding="0" cellspacing="0" align="left" width="48%">
						<tr height="23px">
							<td width="50%" align="left" colspan="2">
							<bean:message bundle="pageResources" key="page.worldOperation.importItem.formattip"/>
							</td>
						</tr>
						<tr height="23px">
							<td width="50%" align="center" class="t_border_l">
							i-993</td>
							<td  align="center" class="t_border_r">
							life pill
							</td>
							
						</tr>
						<tr height="23px">
							<td width="50%" align="center" class="t_border_l">
							99874</td>
							<td  align="center" class="t_border_r">
							silver knife
							</td>
						</tr>
						<tr height="23px">
							<td width="50%" align="center" class="t_border_l">
							...</td>
							<td align="center" class="t_border_r">
							...
							</td>
						</tr>
					</table>
					
				</td>
			</tr>
			<tr height="23px">
				<td width="10%" align="center" class="t_border_r" colspan="2" style="border-bottom:#AEAEB0 1px solid;">
					<input type="submit" id="import" value="<bean:message bundle="pageResources" key="page.common.submit"/>" disabled="disabled"/>
				</td>
			</tr>
		</table>
	</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
  </body>
</html>
