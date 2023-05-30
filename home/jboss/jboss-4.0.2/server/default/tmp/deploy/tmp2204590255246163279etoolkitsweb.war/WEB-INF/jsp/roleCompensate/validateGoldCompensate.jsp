<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
</head>


<body bgcolor="#ffffff">
	
	<form action="saveGoldCompensate.do" method="post">
	
	<c:if test="${not empty requestScope.contentList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.validateGoldCompensate.title"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.playerName"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleCompensate.validateGoldCompensate.compensateNum"/></td>
			</tr>
		<c:forEach items="${requestScope.contentList}" var="content">
			<tr height="23px">
				<td align="center" class="t_border_l">
					${content[0]}
				</td>
					
				<td align="center" class="t_border_r">
					${content[1]}
				</td>
			</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		
	<div align="center">
		<input type="submit" value=" <bean:message bundle="pageResources" key="page.roleCompensate.validateCreate.save"/> "/>
	</div>
	</c:if>
		<input name=gatewayId type="hidden" value="${requestScope.gatewayId }" />
		<input name="serialNumber" type="hidden" value="${requestScope.serialNumber }" />
		<input name="compensateContent" type="hidden" value="${requestScope.compensateContent }" />
		<input name="reason" type="hidden" value="${requestScope.reason }" />
		<input name="compensateId" type="hidden" value="${requestScope.compensateId }" />
		<input name="oper" type="hidden" value="${requestScope.oper }" />
		<input name="commitFlag" type="hidden" value="${requestScope.commitFlag }" />
	</form>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	</body>
</html>