<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javaScript">
			function gotoPage(obj){
				obj.submit();
			}
			
			function check(){
			
				if ( document.forms[0].startTime.value == "" || document.forms[0].startTime.value ==null){
					  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.startTime"/>');
					  document.forms[0].startTime.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
			
		</script>
	</head>

	<body bgcolor="#ffffff">

	<form action="showHistoryNews.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.historyNews.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name=startTime type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.startTime }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit"/>" />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
		<c:if test="${not empty requestScope.pageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
					<tr height="30px">
					<td colspan="11" align="center"></td>
				</tr>
				<tr>
					<td colspan="11" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.historyNews.title2"/> 
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueNews.newsId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.gatewayId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.serverId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.intervals"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.totalTimes"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.operatorName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.state"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.historyBulletin.cancelOperName"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.issueBulletin.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.pageInfo.infoList}" var="news" varStatus="status">
					<tr height="23px" title="<bean:message bundle="pageResources" key="page.worldOperation.issueNews.newsTitle"/>${news.title}&#13<bean:message bundle="pageResources" key="page.worldOperation.issueNews.content"/>${news.content}">
						<td align="center" class="t_border_l">
							${news.newsId}
						</td>
						<td align="center" class="t_border_l">
							<gmweb:gatewayId2Text2 gatewayId="${news.gatewayId }" />
						</td>
						<td align="center" class="t_border_l">
							<gmweb:serverId2Text2 serverId="${news.serverId }" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${news.startTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${news.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_l">
							${news.intervals }
						</td>
						<td align="center" class="t_border_l">
							${news.totalTimes }
						</td>
						<td align="center" class="t_border_l">
							${news.operatorName }
						</td>
						<td align="center" class="t_border_l">
							<gmweb:bulletinAndExpState2Text state="${news.state}" />
						</td>
						<td align="center" class="t_border_l">
							${news.cancelOperName }&nbsp;
						</td>
						<td align="center" class="t_border_r">
							<a href="operNews.do?newsId=${news.newsId}&gatewayId=${news.gatewayId}&action=showHistoryNews"><bean:message bundle="pageResources" key="page.worldOperation.common.Detail"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
				<td colspan="11" align="center" class="t_border">
				<form name="pageForm" action="showHistoryNews.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />		
				</form>
				</td>
			</tr>
			<tr height="50px">
				<td align="center" colspan="9">
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back"/>" onclick="window.location.href='showIssueNews.do'" />
				</td>
			</tr>
			</table>
			
			<br />
		</c:if>

	</body>
</html>
