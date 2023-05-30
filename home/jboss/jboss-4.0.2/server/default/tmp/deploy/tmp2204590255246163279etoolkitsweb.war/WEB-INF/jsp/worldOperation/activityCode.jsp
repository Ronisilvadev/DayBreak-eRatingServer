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
			
		</script>
	</head>

	<body bgcolor="#ffffff">
		<c:if test="${not empty requestScope.pageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="10" align="center"></td>
				</tr>
				<tr>
					<td colspan="10" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.title"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
				
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.logId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.planGenNo"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.successGenNo"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.operatorName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.insertTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.downloadFile"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="activityCodeLog">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${activityCodeLog.logId}
						</td>
						<td align="center" class="t_border_l">
							${activityCodeLog.planGenNo}
						</td>
						<td align="center" class="t_border_l">
							${activityCodeLog.successGenNo}
						</td>
						<td align="center" class="t_border_l">
							${activityCodeLog.operatorName}
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${activityCodeLog.insertTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_r">
							<a href="downloadCodeFile.do?logId=${activityCodeLog.logId}"><bean:message bundle="pageResources" key="page.worldOperation.activityCode.downloadCodeFile"/></a>
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="showActivityCode.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
				</form>
				</td>
			</tr>
			<tr height="30px">
				<td align="left" colspan="10">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.activityCode.activityCodeGenerate"/>" onclick="window.location.href='showActivityCodeGenerate.do'" />&nbsp;&nbsp;
				</td>
			</tr>
			</table>
			
			<br />
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
