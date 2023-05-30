<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>

	<script type="text/javaScript">
			
			function check(){
			
				if ( document.forms[0].description.value == "" || document.forms[0].description.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.error.remark"/>');
					  document.forms[0].description.focus();
					  return false;
				}
				
				else {
					  return true;
				}
			}
			
	</script>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript">
		function nextPage(curPage){
			if(isNum(curPage)){
				document.getElementById('curPage').value=curPage;
				document.forms[0].submit();
			}else{
				alert('<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.errPage"/>');
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">

		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<form action="showEndTask.do" method="post">
			<tr height="30px">
				<td colspan="5" align="center" ></td>
			</tr>
			<tr>
				<td colspan="5" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo9"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.endTask.taskID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.endTask.taskName"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.endTask.isEnd"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.common.oper"/></td>
			</tr>
			<c:if test="${not empty requestScope.pageLog.list }">
			<c:forEach items="${requestScope.pageLog.list}" var="taskInfo" varStatus="status">
			<tr height="23px">
				<td align="center" class="t_border_l">${status.index + 1 }</td>
				<td align="center" class="t_border_l">${taskInfo.taskId }</td>
				<td align="center" class="t_border_l">${taskInfo.taskName }</td>
				<td align="center" class="t_border_l">
					<c:if test="${taskInfo.finishType == 0 }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.tasking"/></c:if>
					<c:if test="${taskInfo.finishType == 1 }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.state1"/></c:if>
					<c:if test="${taskInfo.finishType == 2 }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.finished"/></c:if>
					<c:if test="${taskInfo.finishType == 3 }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.state3"/></c:if>
					<c:if test="${taskInfo.finishType == 4 }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.state4"/></c:if>
				</td>
				<td align="center" class="t_border_r">
					<a href="endTask.do?roleName=${requestScope.roleName }&roleId=${requestScope.roleId }&gatewayId=${requestScope.gatewayId }&serverId=${requestScope.serverId }&playerName=${requestScope.playerName }&taskId=${taskInfo.taskId  }&taskName=${taskInfo.taskName  }"><bean:message bundle="pageResources" key="page.roleOperation.endTask.endTask"/></a>
				</td>
			</tr>	
			</c:forEach>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="right" colspan="20">
					<input type="hidden" name="gatewayId" value="${gatewayId }"/>
					<input type="hidden" name="roleId" value="${roleId }"/>
					<input type="hidden" name="roleName" value="${roleName }"/>
					<input type="hidden" name="playerName" value="${playerName }"/>
					<input type="hidden" name="serverId" value="${roleId }"/>
					<input type="hidden" name="curPage" id="curPage"/>
					<c:if test="${requestScope.pageLog.page>1 }"><a href="#" onclick="nextPage('${requestScope.pageLog.page-1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.Front"/></a></c:if>
					<input type="text" style="width:21pt" name="toPage" id="toPage"/><a href="#" onclick="nextPage(document.getElementById('toPage').value); return false;">GO</a>
					<a href="#" onclick="nextPage('${requestScope.pageLog.page+1 }'); return false;"><bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.next"/></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.cur"/>${requestScope.pageLog.page }<bean:message bundle="pageResources" key="page.playerQuery.roleItemOperate.page"/>&nbsp;&nbsp;&nbsp;
				</td>
			</tr>		
			</c:if>			
		</form>	
		</table>
		
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="12" align="center" ></td>
				</tr>
				<tr>
					<td colspan="12" align="center" class="t_head"><bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo5"/> "${roleName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo10"/></td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.index"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.passport"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.role"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.service"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.common.operTime"/></td>
					<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.roleOperation.endTask.taskName"/></td>
					<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/></td>
				</tr>
				<c:if test="${not empty requestScope.endTaskLogList }">
				<c:forEach items="${requestScope.endTaskLogList}" var="endTaskLog" varStatus="status">
				<tr height="23px">
					<td align="center" class="t_border_l">${status.index + 1 }</td>
					<td align="center" class="t_border_l"><c:out value="${endTaskLog.passportName }"/></td>
					<td align="center" class="t_border_l"><c:out value="${endTaskLog.roleName }"/></td>
					<td align="center" class="t_border_l">${endTaskLog.gatewayId }</td>
					<td align="center" class="t_border_l"><fmt:formatDate value="${endTaskLog.operateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
					<td align="center" class="t_border_l">${endTaskLog.taskName }</td>
					<td align="center" class="t_border_r">${endTaskLog.operatorName }</td>
				</tr>
				</c:forEach>
				</c:if>
				<tr height="5px">
					  	<td colspan="12" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
				</tr>
		</table>
		
		<div align="center">
			<input type="button" onClick="window.location.href='showQueryEndTask.do'" value="<bean:message bundle="pageResources" key="page.roleOperation.common.backToQuery"/>"/>
		</div>
	</body>
</html>