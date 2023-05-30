<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script language="javascript">
			
			function changeAction(obj){
				obj.action = "modifyResource.do";
				obj.method = "post";
				obj.submit();
				return true;
			}
			
			function delParent(){
				var resPid = document.getElementById("resPid");
				var strResPid = document.getElementById("strResPid");
				
				resPid.value = "";
				strResPid.value = "";
			}
			
		</script>
		<html:javascript formName="/addResource"/>
	</head>

	<body bgcolor="#ffffff">
	<html:form action="addResource.do" method="post" onsubmit="return validateResourceForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        	</tr>
        	<c:if test="${empty requestScope.resourceInfo }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.resourceAdd.title"/></td>
		  	</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceName"/>：</td>
				<td class="t_border_r"><input name="resName" type="text" style="width:120px" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceDesc"/>：</td>
				<td class="t_border_r"><input name="resDesc" type="text" style="width:120px" /></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceType"/>：</td>
				<td class="t_border_r">
					<select name="resType" style="width:120px">
						<option value="0" selected><bean:message bundle="pageResources" key="page.purview.resourceAdd.menuType"/></option>
						<option value="1"><bean:message bundle="pageResources" key="page.purview.resourceAdd.systemType"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.purview.resourceAdd.backType"/></option>
					</select> *
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceUrl"/>：</td>
				<td class="t_border_r"><input name="resUrl" type="text" style="width:320px" /></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceParent"/>：</td>
				<td class="t_border_r">
					<input id="resPid" name="resPid" type="hidden" style="width:120px" />
					<input id="strResPid" name="strResPid" type="text" style="width:120px" readOnly/>
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.choice"/>" onclick="javascript:window.open('showResourceTree.do');" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.cancel"/>" onclick="delParent();" />
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1)" />
				</td>
			</tr>
			</c:if>
			
			<c:if test="${not empty requestScope.resourceInfo }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.resourceAdd.title2"/></td>
		  	</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceName"/>：</td>
				<td class="t_border_r">
					<input name="resName" type="text" style="width:120px" value="${requestScope.resourceInfo.resName }" /> *
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceDesc"/>：</td>
				<td class="t_border_r">
					<input name="resDesc" type="text" style="width:120px" value="${requestScope.resourceInfo.resDesc }" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceType"/>：</td>
				<td class="t_border_r">
					<select name="resType" style="width:120px">
						<option value="0" <c:if test="${requestScope.resourceInfo.resType == 0 }">selected</c:if>><bean:message bundle="pageResources" key="page.purview.resourceAdd.menuType"/></option>
						<option value="1" <c:if test="${requestScope.resourceInfo.resType == 1 }">selected</c:if>><bean:message bundle="pageResources" key="page.purview.resourceAdd.systemType"/></option>
						<option value="2" <c:if test="${requestScope.resourceInfo.resType == 2 }">selected</c:if>><bean:message bundle="pageResources" key="page.purview.resourceAdd.backType"/></option>
					</select>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceUrl"/>：</td>
				<td class="t_border_r">
					<input name="resUrl" type="text" style="width:320px" value="${resourceInfo.resUrl }" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.purview.resourceManage.resourceParent"/>：</td>
				<td class="t_border_r">
					<input name="resPid" type="hidden" style="width:120px" value="${resourceInfo.resPid }" />
					<input name="strResPid" type="text" readOnly style="width:120px" value="<c:if test="${not empty resourceInfo.parentResourceName }"><bean:message bundle="menuResources" key="${resourceInfo.parentResourceName }"/></c:if>" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.choice"/>" onclick="javascript:window.open('showResourceTree.do');" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.cancel"/>" onclick="delParent();" />
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.submit"/>" onclick="changeAction(document.forms[0])")/>&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.common.reset"/>" />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);" />
					<input name="resId" type="hidden" value="${resourceInfo.resId }" />
				</td>
			</tr>
			</c:if>
		</table>
	</html:form>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>
