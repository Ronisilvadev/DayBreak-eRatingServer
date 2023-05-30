<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/queryPlayerResInfo"/>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.registerInfoPojo }">
		<html:form action="queryPlayerResInfo.do" method="post" onsubmit="return validatequeryPlayerResInfoForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td class="t_border_r" align="left">
					<input name="playerName" type="text" style="width:200px" />
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.registerInfoPojo }">
		<table width="98%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.playerQuery.playerResInfo"/>
				</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.passport"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.registertime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.shenfenzheng"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.shenfenzheng"/><bean:message bundle="pageResources" key="page.common.fangchenmi"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerName"/><bean:message bundle="pageResources" key="page.common.fangchenmi"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.orderDetail.chargeAmount"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerinfo.bindmail"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.mobile"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.telephone"/></td>
			</tr>
			<tr height="23px">
					<td align="center" class="t_border_l">&nbsp;<c:out value="${registerInfoPojo.passportName}"/></td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.registerTime}</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.idCode}</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.realName}</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.idCode2}</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.realName2}</td>
					<td align="center" class="t_border_l">&nbsp;${chargeMoneyPojo.chargeMoney }</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.bindMail}</td>
					<td align="center" class="t_border_l">&nbsp;${registerInfoPojo.mobile}</td>
					<td align="center" class="t_border_r">&nbsp;${registerInfoPojo.telephone}</td>
				</tr><tr height="30px">
			  	<td colspan="10" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
			
				<div align="center">
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryPlayerResInfo.do'"/>
				</div>
	</c:if>
	</body>
</html>