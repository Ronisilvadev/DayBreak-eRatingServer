<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">	
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	
		<form action="showAddOrUpdateChargeGatewayConfig.do?operType=add&gatewayId=${requestScope.gatewayId}" method="post" name="pageForm">

		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.showGatewayConfigList"/>
				</td>
				
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/>
				</td>
				<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configType"/>
				</td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessCode"/>
				</td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessPwd"/>
				</td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configIP"/>
				</td>
				<td width="15%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configPort"/>
				</td>				
				<td width="20%" align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.worldOperation.activitySettingInfo.oper"/>
				</td>				
			</tr>		
			
		<c:if test="${not empty requestScope.chargeGatewayConfigList}">
			<c:forEach items="${requestScope.chargeGatewayConfigList}" var="result" varStatus="recordRank" >
			<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
				<td width="10%" align="center" class="t_border_l">
					${result.gatewayId}
				</td>
				<td width="10%" align="center" class="t_border_l">					
					<c:forEach items="${requestScope.gatewayTypeList}" var="gatewayTypeDict" varStatus="recordRank">
				  			<c:if test="${gatewayTypeDict.opValue eq result.gatewayType}">
				  				${gatewayTypeDict.opText}
							</c:if>
				  	</c:forEach>
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
					${result.gatewayIP}
				</td>
				<td width="10%" align="center" class="t_border_l">
					${result.gatewayPort}
				</td>					
				<td width="15%" align="center" class="t_border_r">
					<a href="openChargeGatewayConfig.do?operType=open&gatewayId=${result.gatewayId}&gatewayType=${result.gatewayType}">
						<bean:message bundle="pageResources" key="page.tag.CreateCompenOperLinkTag.tag2"/>
 					</a>&nbsp;
 					
					<a href="showAddOrUpdateChargeGatewayConfig.do?operType=update&gatewayId=${result.gatewayId}&gatewayType=${result.gatewayType}">
						<bean:message bundle="pageResources" key="page.worldOperation.onlineGm.modify"/>
					</a>&nbsp;
					
					
					<c:if test="${result.gatewayState > 3}">
							<a href="freezeOrUnfreezeChargeGatewayConfig.do?operType=unfreeze&gatewayId=${result.gatewayId}&gatewayType=${result.gatewayType}">
								<font color="red">
									<bean:message bundle="pageResources" key="page.common.unfreeze"/>
								</font>
							</a>&nbsp;
					</c:if>
				
				
					<c:if test="${result.gatewayState <= 3}">
							<a href="freezeOrUnfreezeChargeGatewayConfig.do?operType=freeze&gatewayId=${result.gatewayId}&gatewayType=${result.gatewayType}">
								<bean:message bundle="pageResources" key="page.common.freeze"/>
							</a>&nbsp;
					</c:if>
					
					
										
				</td>
			</tr>
			</c:forEach>
	</c:if>
	<c:if test="${empty requestScope.chargeGatewayConfigList}">
		<tr height="30px" class="ffffff">
				<td colspan="8" align="center" class="t_border" ><bean:message bundle="pageResources" key="page.common.queryGotNoResults"/>
</td>
			</tr>
	</c:if>	

			<tr height="30px">
				<td colspan="8" align="center" class="t_border">					
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.addGatewayConfig"/>
"/>&nbsp;&nbsp; 
					<input name="goBack" type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.backToGatewayList"/>
" onclick="javascript:document.location.href='showChargeGatewayList.do'"/>	
				</td>
			</tr>
			
	
		</table>	
		
		</form>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
		
	
	</body>
</html>
