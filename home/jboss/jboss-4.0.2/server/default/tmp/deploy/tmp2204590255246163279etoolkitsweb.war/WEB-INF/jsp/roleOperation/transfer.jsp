<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
			function apprSubmit(frm) 
			{ 
				frm.action = "${requestScope.apprType}.do";
				frm.method = "post";
				frm.submit();
			}
			
			function checkAll(frm) 
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSelect"/>') 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.cancel"/>'){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSelect"/>'){
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.cancel"/>';
					frm.apprButton.disabled = false;
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSelect"/>';
					frm.apprButton.disabled = true;
				}
			}
			
			function uncheckAll(frm) 
			{ 
				var TB=TO=0; 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox') 
					{ 
						TB++; 
						if (e.checked){
							TO++;
						} 
					} 
				}
				
				if (TB == TO){
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.cancel"/>';
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSelect"/>';
				}
				
				if (0==TO)//全部未选中和选中一些时对删除按钮的disabled属性的影响 
				{ 
					frm.apprButton.disabled = true; 
				} 
				else 
				{ 
					frm.apprButton.disabled = false; 
				} 
				
			} 
		</script>
	</head>

	<body bgcolor="#ffffff">
		<c:if test="${not empty requestScope.pageInfo }">
		<form name="pageForm" action="${requestScope.operType }.do" method="post">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="11" align="center"></td>
				</tr>
				<tr height="30px">
					<td colspan="11" align="left">
						<gmweb:createCompenTitleButton operType="${requestScope.operType}" actionName="roleOperation" methodType="Transfer" />
					</td>
				</tr>
				<tr>
					<td colspan="11" align="center" class="t_head">
						${requestScope.title }
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.select"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.common.index"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.common.passport"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.transfer.outGateway"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.transfer.inGateway"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.transfer.transferID"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.proposer"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.submitTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.common.reason"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.result"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.roleOperation.common.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="transfer" varStatus="status">
					<tr height="23px">
						<td align="center" class="t_border_l">
							<input name="compensateId" type="checkbox" value="${transfer.changeId}" onclick="uncheckAll(document.forms[0]);" 
							<c:if test="${requestScope.operType != 'showFirstApprTransfer' and requestScope.operType != 'showSecondApprTransfer' }">disabled</c:if>/>
						</td>
						<td align="center" class="t_border_l">
							${status.index + 1 }
						</td>
						<td align="center" class="t_border_l">
							<c:out value="${transfer.passportName }"/>
						</td>
						<td align="center" class="t_border_l">
							${transfer.fromGatewayId }
						</td>
						<td align="center" class="t_border_l">
							${transfer.toGatewayId }
						</td>
						<td align="center" class="t_border_l">
							${transfer.orderId }
						</td>
						<td align="center" class="t_border_l">
							${transfer.operatorName }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${transfer.insertTime }"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							${transfer.reason }
						</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalResult2Text approvalResult="${transfer.approvalResult}" />
						</td>
						<td align="center" class="t_border_r">
							<gmweb:createCompenOperLink operType="${requestScope.operType}" actionName="roleOperation" methodType="Transfer" compensateId="${transfer.changeId}"/>
							<c:if test="${requestScope.operType == 'showExedTransfer' }">
								 <a href="getTransferState.do?orderId=${transfer.orderId}"><bean:message bundle="pageResources" key="page.roleOperation.transfer.excuteState"/></a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="11" align="center" class="t_border">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</td>
			</tr>
			<c:if test="${requestScope.operType == 'showTransfer' }">
			<tr height="30px">
				<td colspan="11" align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.createPropose"/>" onclick="window.location.href='showCreateTransfer.do'" />
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.operType == 'showFirstApprTransfer' or requestScope.operType == 'showSecondApprTransfer' }">
			<tr height="30px">
				<td colspan="8" align="left">
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSelect"/>"  onclick="checkAll(document.forms[0]);"/>&nbsp;&nbsp;
					<input name="apprButton" type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.modifyBindEmail.allSubmit"/>" onclick="apprSubmit(document.forms[0]);" disabled/>
				</td>
			</tr>
			</c:if>
			</table>
			
			<br />
			</form>
		</c:if>
		<div align="center">
			<font color="red"><strong><bean:message bundle="pageResources" key="page.roleOperation.transfer.alertInfo"/></strong></font>
		</div>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
