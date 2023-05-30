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
				
				var strTitle = document.getElementById("addMsgTitle").value;	
				strTitle = trim(strTitle);
				var strContent = document.getElementById("addMsgContent").value;	
				strContent = trim(strContent);
				var strMsgTimeRange = document.getElementById("addMsgTimeRange").value;	
				strMsgTimeRange = trim(strMsgTimeRange);
				
				
				if(strTitle.length==0 || strTitle.indexOf("&")!= -1 || strTitle.indexOf("=")!= -1 ){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.errorBlankMsgTitle"/>");	
					return false;		
				}
				
				if(strTitle.length+strContent.length>200){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.titleAndContentLengthConstraint"/>");
					return false;
				}
				
				if(strMsgTimeRange.length==0 || strMsgTimeRange.length>40){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.timeRangeConstraint"/>");
					return false;
				}
				
				
				
				
					obj.action = "addGroupMsg.do";
					obj.method = "post";
					obj.submit();
				
     			return false;								
			}
			
			
			function updateCheck(){
			
				var strTitle = document.getElementById("updateMsgTitle").value;	
				strTitle = trim(strTitle);
				var strContent = document.getElementById("updateMsgContent").value;	
				strContent = trim(strContent);
				var strMsgTimeRange = document.getElementById("updateMsgTimeRange").value;	
				strMsgTimeRange = trim(strMsgTimeRange);
				
				if(strTitle.length+strContent.length>200){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.titleAndContentLengthConstraint"/>");
					return false;
				}
				
				if(strMsgTimeRange.length==0 || strMsgTimeRange.length>40){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.timeRangeConstraint"/>");
					return false;
				}
				return true;
			}
			
			function trim(str) {
  				return str.replace(/(^\s+)|(\s+$)/g, "");
			}
			
			

			
		</script>
		
	</head>

	<body bgcolor="#ffffff">
		<form action="updateGroupMsg.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        		<input type="hidden" name="gatewayId" value="${requestScope.gatewayId}"/>&nbsp;&nbsp;
        	</tr>


			<!--open the Group Message -->
        	<c:if test="${requestScope.operType == 'open' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.viewGroupMsg"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTitle"/></td>
				<td class="t_border_r">&nbsp;${requestScope.groupMsgTitle}</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgContent"/></td>
				<td class="t_border_r">
				<textarea rows=10 cols=35 size="10240" readonly >${requestScope.groupMsgContent}</textarea>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTimeRange"/></td>
				<td class="t_border_r">&nbsp;${requestScope.groupMsgTimeRange}</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 
		
	
			<!--add a new Group Message -->
			
        	
        	<c:if test="${requestScope.operType == 'add' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.addGroupMsg"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTitle"/></td>
				<td class="t_border_r"><input name="groupMsgTitle" id="addMsgTitle" type="text" value="" /> *</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgContent"/></td>
				<td class="t_border_r"><textarea name="groupMsgContent" id="addMsgContent" type="text" rows=10 cols=35 size="10240"  ></textarea></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTimeRange"/></td>
				<td class="t_border_r"><input name="groupMsgTimeRange" id="addMsgTimeRange" type="text" size="40" value="" /> <bean:message bundle="pageResources" key="page.worldOperation.groupMsg.timeInput.tips"/>  </td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="operId" type="hidden" value="${userInfo.operId }" />
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>" onclick="return changeAction(document.forms[0]);" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.login.reset"/>"   />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 


			<!--update a new Group Message -->
        	<c:if test="${requestScope.operType == 'update' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.updateGroupMsg"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTitle"/></td>
				<td class="t_border_r">${requestScope.groupMsgTitle} 
					<input name="groupMsgTitle"  type="hidden" id="updateMsgTitle"  value="${requestScope.groupMsgTitle}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgContent"/></td>
				<td class="t_border_r"><textarea name="groupMsgContent" id="updateMsgContent" rows=10 cols=35 size="10240"  >${requestScope.groupMsgContent}</textarea></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTimeRange"/></td>
				<td class="t_border_r"><input name="groupMsgTimeRange" id="updateMsgTimeRange" type="text" size="40" value="${requestScope.groupMsgTimeRange}" /> <bean:message bundle="pageResources" key="page.worldOperation.groupMsg.timeInput.tips"/>  </td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="operId" type="hidden" value="${userInfo.operId }" />
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  onclick="return updateCheck(document.forms[0]);" />&nbsp;&nbsp;
					<input type="reset" value="<bean:message bundle="pageResources" key="page.login.reset"/>"   />&nbsp;&nbsp;
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 
			





		</table>
	</form>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</body>
</html>