<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
    
  </head>
    
  <body bgcolor="#ffffff">
  	<!-- 未配置的 -->
  	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  		<tr>
			<td align="center" height="30px"></td>
		</tr>
		<tr>
			<td align="center" class="t_head" colspan="5"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.addConfig"/></td>
		</tr>
			<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayId2"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayProvider"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayName"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.common.operation"/>
					</td>
				</tr>
				<c:if test="${not empty requestScope.gateways }">
				<c:forEach items="${requestScope.gateways}" var="gateway" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${gateway.gatewayId }
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${gateway.gatewayType == 1 }">
								<bean:message bundle="pageResources" key="page.common.officialRegion"/>
							</c:if>
							<c:if test="${gateway.gatewayType == 0 }">
								<bean:message bundle="pageResources" key="page.common.expRegion"/>
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${gateway.gatewayProvider == 1 }">
								<bean:message bundle="pageResources" key="page.common.dianxin"/>
							</c:if>
							<c:if test="${gateway.gatewayProvider == 2 }">
								<bean:message bundle="pageResources" key="page.common.wangtong"/>
							</c:if>
							<c:if test="${gateway.gatewayProvider == 3 }">
								<bean:message bundle="pageResources" key="page.common.shuangxian"/>
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							${gateway.gatewayName }
						</td>
						<td align="center" class="t_border_r" >
							<a href="javascript:window.location='addConfigGateway.do?activityId=${activityId }&gatewayId=${gateway.gatewayId }&gatewayName='+encodeURI('${gateway.gatewayName }') ;"><bean:message bundle="pageResources" key="page.common.add"/></a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="23px">
					<td align="center" colspan="5" class="t_border_r"  style="border-bottom:#AEAEB0 1px solid;">
						<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1) ;"/>
					</td>
				</tr>
		
  	</table>
  	<!-- 已配置的 -->	
  	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  		<tr>
			<td align="center" height="30px"></td>
		</tr>
		<tr>
			<td align="center" class="t_head" colspan="5"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.addedConfig"/></td>
		</tr>
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_l">
				<bean:message bundle="pageResources" key="page.common.gatewayId2"/>
			</td>
			<td align="center" class="t_border_l">
				<bean:message bundle="pageResources" key="page.common.gatewayName"/>
			</td>
			<td align="center" class="t_border_r">
				<bean:message bundle="pageResources" key="page.common.operation"/>
			</td>
		</tr>
			<c:if test="${not empty requestScope.configsGateways }">
				<c:forEach items="${requestScope.configsGateways}" var="gateway" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;">
							${gateway.gatewayId }
						</td>
						<td align="center" class="t_border_l" style="border-bottom:#AEAEB0 1px solid;">
							${gateway.gatewayName }
						</td>
						<td align="center" class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">
							<a href="delConfigGateway.do?activityId=${activityId }&gatewayId=${gateway.gatewayId }"><bean:message bundle="pageResources" key="page.common.del"/></a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
  	</table>
  </body>
</html>
