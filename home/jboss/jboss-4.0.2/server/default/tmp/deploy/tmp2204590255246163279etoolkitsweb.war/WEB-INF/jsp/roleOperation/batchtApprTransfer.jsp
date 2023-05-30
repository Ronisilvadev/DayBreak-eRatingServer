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
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.error1"/>');
					  document.forms[0].approvalComment.focus();
					  return false;
			}
			if ( document.forms[0].approvalComment.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.error2"/>');
					  document.forms[0].approvalComment.focus();
					  return false;
			}
			if (confirm('<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.alertInfo"/>')){
				return true;
			}else{
				return false;
			}
		}
			
	</script>
	
</head>

<body bgcolor="#ffffff">
	<form action="<c:if test="${requestScope.oper == 'firstAppr' }">firstApprTransfer.do</c:if>
		<c:if test="${requestScope.oper == 'secondAppr' }">secondApprTransfer.do</c:if>" method="post">
		<input type="hidden" name="compensateId" value="${requestScope.changeIds}" />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.batchApprTransfer.title"/></td>
			</tr>
			<tr height="23px">
				<td align="right" align="center" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.flow"/> </td>
				<td class="t_border_r" align="left">
					<c:if test="${requestScope.oper == 'firstAppr' }">
						<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.firstAudit"/>
					</c:if>
					<c:if test="${requestScope.oper == 'secondAppr' }">
						<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.secondAudit"/>
					</c:if>
				</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.auditResult"/></td>
				<td class="t_border_r" align="left">
					<select name="approvalResult" class="select_01">
						<option value="1"><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.auditResult1"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.auditResult2"/></option>
					</select><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.auditResultInfo"/>
				</td>
			</tr>
			<tr height="23px">
				<td align="right" class="t_border_l" width="30%"><bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.auditComment"/> </td>
				<td class="t_border_r" align="left">
					<textarea name="approvalComment" rows="5"></textarea><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				</td>
			</tr>
			<tr height="30px">
				<td align="center" class="t_border_r" align="left" colspan="2">
					<input type="hidden" name="compensateId" value="${requestScope.compensateId }"/>
					<c:if test="${requestScope.oper == 'firstAppr' }">
						<input type="submit" onClick="return confirmAppr()" value="<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.firstAuditing"/>"/>
					</c:if>
					<c:if test="${requestScope.oper == 'secondAppr' }">
						<input type="submit" onClick="return confirmAppr()" value="<bean:message bundle="pageResources" key="page.roleOperation.apprModifyBindEmail.secondAuditing"/>"/>
					</c:if>
				</td>
			</tr>
			<tr height="10px">
			  	<td align="center" class="border_top" colspan="2">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
	</form>
		
	</body>
</html>