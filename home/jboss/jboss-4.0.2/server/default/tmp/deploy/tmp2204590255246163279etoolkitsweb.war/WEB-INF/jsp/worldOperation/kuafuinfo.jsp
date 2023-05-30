<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head><link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
		</script>
  </head>
  <body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo}">
	 <form action="SelectKuafuInfo.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center"></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">
					跨服联赛名单查询
				</td>
			</tr>
		    <tr height="23px" >
				<td width="40%" align="right" class="t_border_l">
				玩家帐号ID:</td>
				<td align="left" class="t_border_r">
					<input type="text" name="userId"/>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
                    <input type="submit" id="import" value="<bean:message bundle="pageResources" key="page.common.submit"/>"/>
				</td>
			</tr>
			<tr height="23px">
				<td width="10%" align="center" class="t_border_r" colspan="2" style="border-bottom:#AEAEB0 1px solid;">
					<a href="SelectKuafuInfo.do?param=download">下载玩家信息</a>
				</td>
			</tr>
		</table>
	  </c:if>
	</form>
	<c:if test="${not empty requestScope.pageInfo}">
		 <table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">

				<td colspan="2" align="center" class="t_head">跨服联赛名单</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">玩家帐号ID</td>
				<td align="center" class="t_border_l">导入时间</td>
   			</tr>
			<c:forEach items="${requestScope.pageInfo.infoList}" var="info">
				<tr height="23px">
					<td align="center" class="t_border_l">${info.userId }</td>
				    <td align="center" class="t_border_l">${info.importTime }</td>
				</tr>
			</c:forEach>
		   <tr>
				<td colspan="2" align="center" class="t_border">
					<form name="pageForm" action="SelectKuafuInfo.do" method="post">
						<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
       				</form>
				</td>	
          </tr>	
		</table>
	 </c:if>
	<c:if test="${not empty requestScope.kuafuInfo}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" class="t_head">跨服联赛名单</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">玩家帐号ID</td>
				<td align="center" class="t_border_l">导入时间</td>
   			</tr>
			<c:forEach items="${requestScope.kuafuInfo}" var="kuaf">
				<tr height="23px">
					<td align="center" class="t_border">${kuaf.userId }</td>
				    <td align="center" class="t_border">${kuaf.importTime }</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
  </body>
</html>
