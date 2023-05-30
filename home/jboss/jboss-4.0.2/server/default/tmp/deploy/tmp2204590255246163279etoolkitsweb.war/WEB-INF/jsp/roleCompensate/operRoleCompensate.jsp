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
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.apprPoingCompensate.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.roleCompensate }">
			
			
			<c:if test="${requestScope.roleCompensate.dividedType != 0}">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.roleCompensate.createPetCompensate.operType"/>
				 </td>
				<td align="center" class="t_border_r">
					${requestScope.dividedTypeDesc} &nbsp;
				</td>
			</tr>
			</c:if>
			<gmweb:showRoleCompMenuValue roleMenuItemList="${requestScope.roleMenuItemList}" roleMenuOptionMap="${requestScope.roleMenuOptionMap}" menuValueMap="${requestScope.menuValueMap}" />
			
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operPetCompensate.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.roleCompensate.reason }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName"/></td>
				<td align="center" class="t_border_r">${requestScope.roleCompensate.passportName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.roleCompensate.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
		
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />&nbsp;&nbsp;
			<!-- 未提交状态 -->
			<c:if test="${requestScope.roleCompensate.state==0 }">
				
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag2"/>" onclick="window.location.href='showEditRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag3"/>" onclick="window.location.href='submitRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag4"/>" onclick="window.location.href='delRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
				
				
			</c:if>
			<!-- 提交状态,等待第一次审批 -->
			<c:if test="${requestScope.roleCompensate.state==1 }">
				
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag5"/>" onclick="window.location.href='cancelRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag6"/>" onclick="window.location.href='show2FirstApprRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
				
			</c:if>
			<!-- 一次over, 等待第二次审批 -->
			<c:if test="${requestScope.roleCompensate.state==2 }">
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag7"/>" onclick="window.location.href='show2FirstApprRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
			</c:if>
			<!-- 二次over -->
			<c:if test="${requestScope.roleCompensate.state==100 }">
				<!--执行该审批-->
				<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag8"/>" onclick="window.location.href='exeRoleCompensate.do?compensateType=${requestScope.roleCompensate.compensateType}&compensateId=${requestScope.roleCompensate.compensateId}'" />&nbsp;&nbsp;
			</c:if>		
			
		</div>		
		
	</body>
</html>