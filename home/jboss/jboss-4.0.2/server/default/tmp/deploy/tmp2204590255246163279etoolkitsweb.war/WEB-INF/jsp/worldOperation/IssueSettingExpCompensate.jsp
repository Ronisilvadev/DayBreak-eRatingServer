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
					if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleCompensate.common.allSelect"/>') 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleCompensate.common.cancel"/>'){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == '<bean:message bundle="pageResources" key="page.roleCompensate.common.allSelect"/>'){
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleCompensate.common.cancel"/>';
					frm.apprButton.disabled = false;
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleCompensate.common.allSelect"/>';
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
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleCompensate.common.cancel"/>';
				}else{
					frm.selectAll.value = '<bean:message bundle="pageResources" key="page.roleCompensate.common.allSelect"/>';
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
					<td colspan="12" align="center"></td>
				</tr>
				<tr height="30px">
					<td colspan="12" align="left">
						<gmweb:createCompenTitleButton operType="${requestScope.operType}" actionName="worldOperation" methodType="IssueSettingExpCompensate" />
					</td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head">
						${title }
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td width="10%" align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleCompensate.common.select"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleCompensate.common.index"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.changeId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.expRate"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueSettingExp.operatorName"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="settingExp" varStatus="status">
					<tr height="23px">
						<td width="10%" align="center" class="t_border_l">
							<input name="compensateId" type="checkbox" value="${settingExp.changeId }" onclick="uncheckAll(document.forms[0]);" <c:if test="${requestScope.apprType != 'batchFirstApprIssueSettingExpCompensate' and requestScope.apprType != 'batchSecondApprIssueSettingExpCompensate' }">disabled</c:if> />
						</td>
						<td align="center" class="t_border_l">
							${status.index + 1 }
						</td>
						<td align="center" class="t_border_l">
							${settingExp.changeId}
						</td>
						<td align="center" class="t_border_l">
							<gmweb:gatewayId2Text2 gatewayId="${settingExp.gatewayId }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:serverId2Text2 serverId="${settingExp.serverId }" />
						</td>
						<td align="center" class="t_border_l">
							${settingExp.expType }
						</td>
						<td align="center" class="t_border_l">
							${settingExp.expRate }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${settingExp.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${settingExp.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:bulletinAndExpState2Text state="${settingExp.state}" />
						</td>
						<td align="center" class="t_border_l">
							${settingExp.operatorName }
						</td>
						<td align="center" class="t_border_r">
							<gmweb:createCompenOperLink operType="${requestScope.operType}" actionName="worldOperation" methodType="IssueSettingExpCompensate" compensateId="${settingExp.changeId}"/>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="12" align="center" class="t_border">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" /> 	
				</td>
			</tr>
			<c:if test="${requestScope.operType == 'showIssueSettingExpCompensate' }">
			<tr height="30px">
				<td colspan="12" align="left">
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.createAwardCompensate"/>" onclick="window.location.href='showCreateIssueSettingExpCompensate.do'" />
				</td>
			</tr>
			</c:if>
			<c:if test="${requestScope.apprType == 'batchFirstApprIssueSettingExpCompensate' or requestScope.apprType == 'batchSecondApprIssueSettingExpCompensate' }">
			<tr height="30px">
				<td colspan="12" align="left">
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.roleCompensate.common.allSelect"/>" onclick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="apprButton" type="button" value="<bean:message bundle="pageResources" key="page.roleCompensate.common.batchApprAward"/>" onclick="apprSubmit(document.forms[0]);" disabled/>
				</td>
			</tr>
			</c:if>
			</table>
		</form>
			<br />
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
