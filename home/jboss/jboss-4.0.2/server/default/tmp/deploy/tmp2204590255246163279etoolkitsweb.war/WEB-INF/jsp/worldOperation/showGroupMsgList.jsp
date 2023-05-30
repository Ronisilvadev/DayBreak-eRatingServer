<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
	<!--
	
			
			function confirmDel(){
				return confirm("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.deleteConfirm"/>");
			}
			function confirmDelAll(){
				return confirm("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.deleteAllConfirm"/>");
			}
			
					
			function searchSubmit(obj){
				
				if(document.getElementById("qurType").value =="2"){
					
					var strTitle = document.getElementById("keyWord").value;	
					strTitle = trim(strTitle);
					
					if(strTitle.length>0&&strTitle.indexOf("&")== -1 && strTitle.indexOf("=")== -1 ){
						document.forms[0].action = "querySpecificGroupMsg.do";
						obj.method = "post";
						obj.submit();
						return true;
					}
				
					alert("<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.errorBlankMsgTitle"/>");
     				return false;	
					
				}
				else{
					document.forms[0].action = "queryAllGroupMsg.do";
					obj.method = "post";				
					obj.submit();
					
				}
				
			}
			
			function selType(obj){
			if(obj == 1){
				document.getElementById("qurType").value ="1";
				document.getElementById("keyWord").style.visibility = "hidden";
			}
			if(obj == 2){
				document.getElementById("qurType").value ="2";
				document.getElementById("keyWord").style.visibility = "visible";

			}
		}
			function trim(str) {
  				return str.replace(/(^\s+)|(\s+$)/g, "");
			}
			
		-->
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	
		<form action="delAllGroupMsg.do" method="post" name="pageForm">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.searchGroupMsg"/></td>
			</tr>
			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="gatewayId" style="width:200px">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }">${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				 </td>
			</tr>
			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.searchScope"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="radio" id="qurType" name="qurType"  checked onclick="selType(1)"/><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.scopeAll"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 	<input type="radio" id="qurType" name="qurType"  onclick="selType(2)"/><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.scopeTitleAssign"/><input name="keyWord" type="text" value="${keyWord }" style="width:200px; visibility:hidden" />
				 </td>
			</tr>
			
			
			<tr>
			<td colspan="2" class="t_border_r" align="center" style="border-bottom:#AEAEB0 1px solid;">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.purview.common.searchTitle"/>" onclick="return searchSubmit(document.forms[0]);"/>
			</td>
			</tr>
		</table>


		<c:if test="${not empty requestScope.pageInfo}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="6" align="center" ></td>
			</tr>
			<tr>
				<td colspan="6" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgList"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.rank"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTitle"/></td>
				<td width="30%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgContent"/></td>
				<td width="20%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.groupMsg.GroupMsgTimeRange"/></td>				
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag1"/></td>
			</tr>

			<c:if test="${not empty requestScope.pageInfo.list }">
			<c:forEach items="${requestScope.pageInfo.list}" var="groupInfo" begin="1" varStatus="recordRank">
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					${recordRank.index}
				</td>
				<td width="20%" align="center" class="t_border_l">
				
				
				<c:if test="${fn:length(groupInfo[0])>20}">${fn:substring(groupInfo[0],0,20)} ...
				</c:if>
				<c:if test="${fn:length(groupInfo[0])<=20}">${ groupInfo[0]}
				</c:if>
				</td>
				<td width="30%" align="center" class="t_border_l">
				<c:if test="${fn:length(groupInfo[1])>30}">${fn:substring(groupInfo[0],0,30)} ...
				</c:if>
				<c:if test="${fn:length(groupInfo[1])<=30}">${ groupInfo[1]}
				</c:if>
				</td>
				<td width="20%" align="center" class="t_border_l">${groupInfo[2]}</td>				
				<td width="20%" align="center" class="t_border_r">
					<a href="openGroupMsg.do?gatewayId=${requestScope.gatewayId}&groupMsgTitle=${groupInfo[0]}&groupMsgContent=${groupInfo[1]}&groupMsgTimeRange=${groupInfo[2]}"><bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag2"/></a>&nbsp;
					<a href="showUpdateGroupMsg.do?gatewayId=${requestScope.gatewayId}&groupMsgTitle=${groupInfo[0]}&groupMsgContent=${groupInfo[1]}&groupMsgTimeRange=${groupInfo[2]}" ><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/></a>&nbsp;
					<a href="delOneGroupMsg.do?groupMsgTitle=${groupInfo[0]}&gatewayId=${requestScope.gatewayId}" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.del"/></a>
				</td>
			</tr>
			
			
			</c:forEach>
			</c:if>




			<tr height="30px">
				<td colspan="6" align="center" class="t_border">
					
					<input name="add" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.addGroupMsg"/>" onclick="javascript:document.location.href='showAddGroupMsg.do?gatewayId=${requestScope.gatewayId}';" />&nbsp;&nbsp;
					<input name="deleteButton" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.groupMsg.deleteAllGroupMsg"/>"  onclick="return confirmDelAll();"/>&nbsp;&nbsp;	
					 	
				</td>
			</tr>
			
	
		</table>
		</c:if>
		</form>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<script type="text/javascript">
				<!--
					document.getElementById("keyWord").focus();
					document.onkeydown = function(e){
						var event = window.event || e;
						if(event.keyCode == 13){
							searchSubmit(document.forms[0]);
						}
					}
				-->
		</script>
		
	
	</body>
</html>
