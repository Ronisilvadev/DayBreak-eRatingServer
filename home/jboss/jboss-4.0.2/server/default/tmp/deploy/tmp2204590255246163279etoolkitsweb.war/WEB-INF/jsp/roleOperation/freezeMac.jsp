<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	
	<script type="text/javaScript">
	String.prototype.trim=function(){ 
		return this.replace(/(^\s*)|(\s*$)/g, ""); 
	} 
	function check(){
		var mac = document.getElementById('mac').value.trim();
		if(mac.length>0){
			return true;
		}else{
			alert('<bean:message bundle="pageResources" key="page.roleOperation.freezeMac.macerror"/>');
			return false;
		}
	}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${requestScope.macLogList == null}">
		<form action="showFreezeMacLog.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.freezeMac.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/>：</td>
				<td class="t_border_r" align="left">
					<input name="mac" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
	</c:if>
	
	<c:if test="${requestScope.macLogList != null}">
	<form action="showOperFreezeMac.do" method="post">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/> "${mac }" <bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.orderStatus.orderState"/></td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l">${mac }</td>
				<td align="center" class="t_border_r"><c:if test="${state==1 }"><bean:message bundle="pageResources" key="page.tag.RoleState2TextTag.tag1"/></c:if><c:if test="${state!=1 }"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.state1"/></c:if></td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="mac" type="hidden" value="${mac }"/>
					<input name="state" type="hidden" value="${state }"/>
					<c:if test="${state==1 }"><input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.freeze"/>" /></c:if>
					<c:if test="${state!=1 }"><input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.unFreezePlayer"/>" /></c:if>
				</td>
			</tr>
		</table>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="7" align="center" ></td>
			</tr>
			<tr>
				<td colspan="7" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.playerLoginOutDetail.mac"/> "${mac }" <bean:message bundle="pageResources" key="page.roleOperation.freezeMac.title2"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.operationType"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.startDate"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.planFreezetime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.freezeMac.reason"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>
			</tr>
			<c:forEach items="${requestScope.macLogList}" var="mac">
				<tr height="23px">
					<td align="center" class="t_border_l">${mac.gatewayId }</td>
					<td align="center" class="t_border_l"><c:if test="${mac.operType==1 }"><bean:message bundle="pageResources" key="page.roleOperation.validateFreezePlayers.freeze"/></c:if><c:if test="${mac.operType==2 }"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.unFreezePlayer"/></c:if></td>
					<td align="center" class="t_border_l">${mac.startTime }</td>
					<td align="center" class="t_border_l">${mac.period/60 }&nbsp;</td>
					<td align="center" class="t_border_l">${mac.reason }&nbsp;</td>
					<td align="center" class="t_border_r">${mac.oper }</td>
					</tr>
			</c:forEach>
				<tr height="30px">
			  		<td colspan="7" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
					</td>
				</tr>
		</table>
	
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showFreezeMac.do'"/>
		</div>
		</form>
	</c:if>
	</body>
</html>