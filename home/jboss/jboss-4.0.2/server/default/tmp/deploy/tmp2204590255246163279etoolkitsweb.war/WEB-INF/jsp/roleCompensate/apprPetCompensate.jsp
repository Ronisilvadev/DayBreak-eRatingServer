<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javaScript">
		function confirmAppr(){
			if ( document.forms[0].approvalComment.value == "" || document.forms[0].approvalComment.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.approvalComment"/>');
					  document.forms[0].approvalComment.focus();
					  return false;
			}
			if ( document.forms[0].approvalComment.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleCompensate.errors.approvalCommentLength"/>');
					  document.forms[0].approvalComment.focus();
					  return false;
			}
			if (confirm('<bean:message bundle="pageResources" key="page.roleCompensate.errors.alertInfo"/>')){
				return true;
			}else{
				return false;
			}
		}
			
	</script>
	
</head>

<body bgcolor="#ffffff">
	<form action="<c:if test="${requestScope.oper == 'firstAppr' }">firstApprPetCompensate.do</c:if>
		<c:if test="${requestScope.oper == 'secondAppr' }">secondApprPetCompensate.do</c:if>" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleCompensate.apprPenCompensate.title"/></td>
			</tr>
			<tr height="23px">
				<td align="right" align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.oper"/> </td>
				<td class="t_border_r" align="left">
					<c:if test="${requestScope.oper == 'firstAppr' }">
						<bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.firstAppr"/>
					</c:if>
					<c:if test="${requestScope.oper == 'secondAppr' }">
						<bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.secondAppr"/>
					</c:if>
				</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalResult"/></td>
				<td class="t_border_r" align="left">
					<select name="approvalResult" class="select_01">
						<option value="1"><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalResult1"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalResult2"/></option>
					</select><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalResultInfo"/>
				</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalComment"/> </td>
				<td class="t_border_r" align="left">
					<textarea name="approvalComment" rows="5"></textarea><bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.approvalCommentLength"/>
				</td>
			</tr>
			<tr height="30px">
				<td align="center" class="t_border_r" align="left" colspan="2">
					<input type="hidden" name="compensateId" value="${requestScope.compensateId }"/>
					<c:if test="${requestScope.oper == 'firstAppr' }">
						<input type="submit" onclick="return confirmAppr()" value="<bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.firstAppring"/>"/>
					</c:if>
					<c:if test="${requestScope.oper == 'secondAppr' }">
						<input type="submit" onclick="return confirmAppr()" value="<bean:message bundle="pageResources" key="page.roleCompensate.apprAwardCompensate.secondAppring"/>"/>
					</c:if>
				</td>
			</tr>
			<tr height="10px">
			  	<td align="center" class="border_top" colspan="2">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</form>
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="8" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.title2"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalNum"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName2"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalComment"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult2"/></td>
				</tr>
				<c:if test="${not empty requestScope.petCompensateLogList }">
				<c:forEach items="${requestScope.petCompensateLogList}" var="petCompensateLog" varStatus="state">
				<tr height="23px">
						<td align="center" class="t_border_l">${state.index + 1 }</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalNum2Text approvalNum="${petCompensateLog.approvalNum}" />
						</td>
						<td align="center" class="t_border_l">${petCompensateLog.operatorName }</td>
						<td align="center" class="t_border_l"><fmt:formatDate value="${ petCompensateLog.approvalTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center" class="t_border_l">${petCompensateLog.approvalComment }</td>
						<td align="center" class="t_border_r">
							<gmweb:approvalResult2Text approvalResult="${petCompensateLog.approvalResult}" />
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleCompensate.apprPoingCompensate.title"/></td>
			</tr>
			<c:if test="${not empty requestScope.petCompensate }">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.roleCompensate.common.roleName"/>
				 </td>
				<td align="center" class="t_border_r">${requestScope.petCompensate.roleName }</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.roleCompensate.createPetCompensate.operType"/>
				 </td>
				<td align="center" class="t_border_r">
					<c:if test="${requestScope.petCompensate.operType == 'changePet'}"><bean:message bundle="pageResources" key="page.roleCompensate.createPetCompensate.changePet"/></c:if>
					<c:if test="${requestScope.petCompensate.operType == 'createPet'}"><bean:message bundle="pageResources" key="page.roleCompensate.createPetCompensate.createPet"/></c:if>
				</td>
			</tr>
			
			<gmweb:showPetMenuValue petMenuItemList="${requestScope.petMenuItemList}" petMenuOptionMap="${requestScope.petMenuOptionMap}" menuMap="${requestScope.menuValueMap}" />
			
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operPetCompensate.reason"/></td>
				<td align="center" class="t_border_r">${requestScope.petCompensate.reason }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.operatorName"/></td>
				<td align="center" class="t_border_r">${requestScope.petCompensate.operatorName }</td>
			</tr>
			<tr height="23px">
				<td align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleCompensate.operAwardCompensate.approvalResult"/></td>
				<td align="center" class="t_border_r">
					<gmweb:approvalResult2Text approvalResult="${requestScope.petCompensate.approvalResult}" />
				</td>
			</tr>
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>
	</body>
</html>