<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.mapResult }">
	<div id="divForm">
		<form action="queryPlayerInfoOfBaidu.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">联运账号查询</td>
			</tr>		
			<tr height="30px">
				<td class="t_border_l" align="right" width="25%">玩家账号：</td>
				 <td class="t_border_l" align="left">
				 	<textarea name="playerName"  rows=10 cols=35 size="10240"></textarea>
				 </td>
				 <td class="t_border_r" align="left">
				 	<bean:message bundle="pageResources" key="page.playerQuery.unionQuery.tip"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="提交" />
				</td>
			</tr>
		</table>
		</form>
		<div id="divMsg" align="center">
		</div>
	</div>
	<br/><br/>
	</c:if>
	<c:if test="${not empty requestScope.mapResult }">
	<div id="divResult">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="23px">
				<td colspan="2" align="center" ><br /><br /></td>
			</tr>
			<tr>
				<td colspan="2" height="23px" align="center" class="t_head">查询结果</td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l">玩家账号</td>
				<td align="center" class="t_border_r">玩家ID</td>
			</tr>
			<c:forEach var="targetPlayer" items="${mapResult}">
			<tr height="23px">
				<td align="center" class="t_border_l"><c:out value="${targetPlayer.key}"/></td>
				<td align="center" class="t_border_r">${targetPlayer.value }</td>
			</tr>
			</c:forEach>
			<tr height="30px">
			  	<td colspan="2" align="center" class="border_top"><br />&nbsp;&nbsp;&nbsp;</td>
			</tr>
		</table>
	</div>
	<div align="center">
		<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.back()"/>
	</div>
	</c:if>
	</body>
</html>