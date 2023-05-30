<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>无标题文档</title>
	<script type="text/javascript">
		function check(){
		        
				if ( document.forms[0].cardNums.value == "" || document.forms[0].cardNums.value  == null){
						alert('<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.error"/>');
						document.forms[0].cardNums.focus();
						return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.realCardInfoList }">
	<form action="realCardInfo.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardNum"/>：
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="cardNums" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardNumInfo"/>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	<c:if test="${not empty requestScope.realCardInfoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="4"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="4"><bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.title"/></td>
			</tr>
			<tr height="30px" class="h_CDE4F6">
				<td width="25%" class="t_border_l" align="center">
					<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardNum"/>
				</td>
				<td width="25%" class="t_border_l" align="center">
					<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState"/>
				</td>
				<td width="25%" class="t_border_l" align="center">
					<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.playerName"/>
				</td>
				<td width="25%" class="t_border_r" align="center">
					<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.time"/>
				</td>
			</tr>
			<c:forEach items="${requestScope.realCardInfoList}" var="realCardInfo" varStatus="status">
			<tr height="30px">
				<td align="center" class="t_border_l">
					${realCardInfo.cardNum }
				</td>
				<td align="center" class="t_border_l">
					${realCardInfo.cardState}
					<c:if test="${realCardInfo.cardState == 1}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1"/></c:if>
					<c:if test="${realCardInfo.cardState == 2}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState2"/></c:if>
					<c:if test="${realCardInfo.cardState == -1491}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1491"/></c:if>
					<c:if test="${realCardInfo.cardState == -1492}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1492"/></c:if>
					<c:if test="${realCardInfo.cardState == -1493 }">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1493"/></c:if>
					<c:if test="${realCardInfo.cardState == -1494}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1494"/></c:if>
					<c:if test="${realCardInfo.cardState == -1496}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1496"/></c:if>
					<c:if test="${realCardInfo.cardState == -1475}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1475"/></c:if>
					<c:if test="${realCardInfo.cardState == -1477}">-<bean:message bundle="pageResources" key="page.playerQuery.realCardInfo.cardState1477"/></c:if>
				</td>
				<td align="center" class="t_border_l">
					<c:out value="${realCardInfo.playerName }"/>&nbsp;
				</td>
				<td align="center" class="t_border_r">
					<fmt:formatDate value="${realCardInfo.cardTime }" pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;
				</td>
			</tr>
			</c:forEach>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="4">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showRealCardInfo.do'"/>
				</td>
			</tr>
		</table>
		
	</c:if>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	
	</body>
</html>