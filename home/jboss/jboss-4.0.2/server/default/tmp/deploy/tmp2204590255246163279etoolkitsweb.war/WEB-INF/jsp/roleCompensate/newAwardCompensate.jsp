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
			function ok (obj){			
				if(confirm("<bean:message bundle='pageResources' key='page.worldOperation.alertInfo.del'/>")){		
					
					window.location.href='newDeleteActivityAwardComp.do?compensateId='+obj+'';
				}else{
				    return false;
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
					<td colspan="7" align="center"></td>
				</tr>
				<tr height="30px">
						<td colspan="7" align="left">
							<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenTitleButtonTag.tag1'/>"
								onclick="window.location.href='showNewAwardCompensate.do'"  />
							<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenTitleButtonTag.tag4'/>"
								onclick="window.location.href='showNewAppredAwardCompensate.do'" />
							<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenTitleButtonTag.tag5'/>"
								onclick="window.location.href='showNewExedAwardCompensate.do'" />
							<input type="button" value="<bean:message bundle='pageResources' key='page.tag.CreateCompenTitleButtonTag.tag6'/>"
								onclick="window.location.href='showNewDeledAwardCompensate.do'" />
						</td>
					</tr>
		     <tr>
                        <td colspan="7" align="center" class="t_head">
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
						<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.operatorName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.insertTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.reason"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.approvalResult"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.roleCompensate.common.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="awardCompensate" varStatus="status">
					<tr height="23px">
						<td width="10%" align="center" class="t_border_l">
							<input name="compensateId" type="checkbox" value="${awardCompensate.compensateId }" onclick="uncheckAll(document.forms[0]);" <c:if test="${requestScope.apprType != 'batchFirstApprAwardCompensate' and requestScope.apprType != 'batchSecondApprAwardCompensate' }">disabled</c:if> />
						</td>
						<td align="center" class="t_border_l">
							${status.index + 1 }
						</td>
						<td align="center" class="t_border_l">
							${awardCompensate.operatorName }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${awardCompensate.insertTime }"
								pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							${awardCompensate.reason }
						</td>
						<td align="center" class="t_border_l">
							<gmweb:approvalResult2Text approvalResult="${awardCompensate.approvalResult}" />
						</td>	
											
						 <td align="center" class="t_border_r">
						
                          <c:if test="${requestScope.type==1 or requestScope.type==4}">
                            <a href="newOperAwardCompensate.do?oper=init&compensateId=${awardCompensate.compensateId}&type=${requestScope.type}"><bean:message bundle='pageResources' key='page.common.operation'/></a>
                         </c:if>
                           <c:if test="${requestScope.type==2 or requestScope.type==3}">
                            <a href="newOperAwardCompensate.do?oper=init&compensateId=${awardCompensate.compensateId}&type=${requestScope.type}"><bean:message bundle='pageResources' key='page.roleOperation.common.queryInfo'/></a>
                         </c:if>
                       
                      <c:if test="${awardCompensate.state==0 or awardCompensate.state==1 or awardCompensate.state==2 or awardCompensate.state==100 }">
                            <a href ="#" onclick="ok(${awardCompensate.compensateId});"><bean:message bundle="pageResources" key="page.common.del"/></a>
                          </c:if>                          
                          
                        </td>
						
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="7" align="center" class="t_border">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</td>
			</tr>
					<c:if test="${requestScope.operType == 'showAwardCompensate' }">
						<tr height="30px">
							<td colspan="7" align="left">
								<input type="button"
									value="<bean:message bundle="pageResources" key="page.roleCompensate.awardCompensate.createAwardCompensate"/>"
									onclick="window.location.href='showNewCreateAwardCompensate.do'" />
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
