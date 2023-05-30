<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
		function searchSubmit(obj){
	
	
			var gatewayName = document.getElementsByName("gatewayId")[0].value;
		
			if(gatewayName.length>0){
				document.forms[0].action = "searchChargeGatewayByName.do";
				obj.method = "post";
				obj.submit();
				
				return true;		
			}		
			alert("<bean:message bundle="pageResources" key="page.common.errorMsgForNoInput"/>");
     		return false;			
				
		}
		
		
		function confirmFreeze(id,name){
		
			var gatewayId    = id;
			var gatewayName  = name;			
			if(confirm("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.confirmFreeze"/>"
				+"<bean:message bundle="pageResources" key="page.common.gatewayId2"/>："+id+", "
				+"<bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/>："+name
				+"(<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.freezeTips"/>)")==true){
				document.location.href="freezeOrUnfreezeChargeGateway.do?operType=freeze&chargeGatewayId="+id;
			}
		}
		
		function confirmUnfreeze(id,name){
		
			if(confirm("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.confirmUnfreeze"/>"
			+"<bean:message bundle="pageResources" key="page.common.gatewayId2"/>："+id+", "
			+"<bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/>："+name
			+"(<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.unfreezeTips"/>)")==true){
				document.location.href="freezeOrUnfreezeChargeGateway.do?operType=unfreeze&chargeGatewayId="+id;
			}
		}
	
	
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<form action="showAddOrUpdateChargeGateway.do?operType=add" method="post" name="pageForm">

		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="2" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.searchChargeGatewayByID"/>
				</td>
			</tr>
			
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.common.gatewayId2"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gatewayId"  type="text" size="40" value="" />
				 </td>
			</tr>		
			
			
			<tr>
			<td colspan="2" class="t_border_r" align="center" style="border-bottom:#AEAEB0 1px solid;">
					<input name="search" type="button" value="<bean:message bundle="pageResources" key="page.purview.common.searchTitle"/>" onclick="return searchSubmit(document.forms[0]);"/>
			</td>
			</tr>
		</table>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head">
				<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.showChargeGatewayList"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="8%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td width="8%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.locatedDistrict"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessCode"/></td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessPwd"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayIP"/></td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayMAC"/></td>
				<td width="24%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.oper"/></td>				
			</tr>		
			
			
	<c:if test="${not empty requestScope.chargeGatewayList}">
		<c:forEach items="${requestScope.chargeGatewayList}" var="result" varStatus="recordRank" >
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					${result.gatewayId} 
				</td>
				<td width="10%" align="center" class="t_border_l">
				${result.zoneId}-${requestScope.chargeGatewayZoneList[recordRank.index]} 
				</td>
				<td width="15%" align="center" class="t_border_l">
										
					<c:if test="${fn:length(result.gatewayCode)>10}">
						${fn:substring(result.gatewayCode,0,10)} ...
					</c:if>
					<c:if test="${fn:length(result.gatewayCode)<=10}">
						${result.gatewayCode}
					</c:if>
				</td>
				<td width="15%" align="center" class="t_border_l">
					
					<c:if test="${fn:length(result.gatewayPassword)>10}">
						${fn:substring(result.gatewayPassword,0,10)} ...
					</c:if>
					<c:if test="${fn:length(result.gatewayPassword)<=10}">
						${result.gatewayPassword}
					</c:if>
				</td>
				<td width="15%" align="center" class="t_border_l">
					
					<c:if test="${fn:length(result.gatewayName)>10}">
						${fn:substring(result.gatewayName,0,10)} ...
					</c:if>
					<c:if test="${fn:length(result.gatewayName)<=10}">
						${result.gatewayName}
					</c:if>
				</td>
				<td width="10%" align="center" class="t_border_l">
					${result.gatewayIP} 
				</td>
				<td width="10%" align="center" class="t_border_l">
					${result.gatewayMAC} 
				</td>				
				<td width="15%" align="center" class="t_border_r">
				
							<a href="openChargeGateway.do?operType=open&chargeGatewayId=${result.gatewayId}"><bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag2"/></a>&nbsp;
							<a href="showAddOrUpdateChargeGateway.do?operType=update&chargeGatewayId=${result.gatewayId}"><bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/></a>&nbsp;
							
					<c:if test="${result.gatewayState==1}">		
										
							<br/>
							<a href="#" onclick="return confirmFreeze('${result.gatewayId}','${result.gatewayName}')"><bean:message bundle="pageResources" key="page.common.freeze"/></a>&nbsp;
							<a href="showChargeGatewayConfigList.do?gatewayId=${result.gatewayId}"><bean:message bundle="pageResources" key="page.common.configure"/></a>&nbsp;
					</c:if>		
				
					<c:if test="${result.gatewayState!=1}">
														
							<a href="#" onclick="return confirmUnfreeze('${result.gatewayId}','${result.gatewayName}')" >
							<br/>
							<font color="red"><bean:message bundle="pageResources" key="page.common.unfreeze"/></font></a>&nbsp;						
							<font color="gray"><bean:message bundle="pageResources" key="page.common.configure"/>&nbsp;</font>
					</c:if>
				
				
				</td>
			</tr>
		</c:forEach>
	</c:if>
	
	<c:if test="${empty requestScope.chargeGatewayList}">
					<td colspan="8" align="center" class="t_border">					
						<bean:message bundle="pageResources" key="page.common.queryGotNoResults"/>	
					</td>
	</c:if>

			<tr height="30px">
				<td colspan="8" align="center" class="t_border">					
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.addChargeGateway"/>"/>&nbsp;&nbsp; 	
				</td>
			</tr>
			
	
		</table>
		
		</form>
		
		
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg}</font>
		</div>
	
	</body>
</html>
