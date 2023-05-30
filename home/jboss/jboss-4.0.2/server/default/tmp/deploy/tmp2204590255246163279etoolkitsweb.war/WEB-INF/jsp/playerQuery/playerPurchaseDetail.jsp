<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/getPlayerPurchaseDetail"/>
	<script type="text/javascript">
		function gotoPage(obj){
			obj.submit();
		}
		function exportData(){
			document.forms[0].action = "exportPlayerPurchaseDetail.do";
			document.forms[0].submit();
		}
	</script>
</head>

<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.pageInfo }">
		<html:form action="getPlayerPurchaseDetail.do" method="post" onsubmit="return validateGetPlayerPurchaseDetailForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.title"/> </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="playerName" type="text" style="width:200px" />
				 </td>
			</tr>
			<c:if test = "${requestScope.moneyType==1}">
			<tr height="30px">
				<td class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.playerQuery.showQueryPlayerPurchaseDetail"/>
				</td>
				<td class="t_border_l">
					<select name="moneyType">
						<option value="2"<c:if test="${param.moneyType==2 }">selected</c:if>><bean:message bundle="pageResources" key="page.playerQuery.showQueryPlayerPurchaseDetail.gameMoney"/></option>
						<option value="1"<c:if test="${param.moneyType==1 }">selected</c:if>><bean:message bundle="pageResources" key="page.playerQuery.showQueryPlayerPurchaseDetail.renMoney"/></option>
					</select>
				</td>
				<td  class="t_border_r">&nbsp;</td>
			</tr>
          </c:if>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.pageInfo }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"><bean:message bundle="pageResources" key="page.playerQuery.accountDetail.player"/> "${playerName}" <bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.purchase"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.purchaseID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.roleID"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.role"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.IP"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.code"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerItem.itemNum"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.num"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.purchaseTime"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.monryType"/></td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.playerQuery.playerPurchaseDetail.money"/></td>
			</tr>
		<c:forEach items="${requestScope.pageInfo.infoList}" var="purchaseDetail">
			<tr height="23px">
				<td align="center" class="t_border_l">${purchaseDetail.purchaseId }</td>
				<td align="center" class="t_border_l">${purchaseDetail.roleId }</td>
				<td align="center" class="t_border_l"><c:out value="${purchaseDetail.roleName }"/>&nbsp;</td>
				<td align="center" class="t_border_l">${purchaseDetail.purchaseIp }</td>
				<td align="center" class="t_border_l">${purchaseDetail.productCode }</td>
				<td align="center" class="t_border_l">${purchaseDetail.productName }</td>
				<td align="center" class="t_border_l">${purchaseDetail.productNum }</td>
				<td align="center" class="t_border_l"><fmt:formatDate value="${purchaseDetail.purchaseTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td align="center" class="t_border_l">
					<gmweb:subjectId2Text subjectId="${purchaseDetail.subjectId }" />
				</td>
				<td align="center" class="t_border_r">${purchaseDetail.costAmount }</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="10" align="center" class="t_border">
				<form name="pageForm" action="getPlayerPurchaseDetail.do" method="post">
					<gmweb:paginationInfo pageNum="${requestScope.pageNum }" currentPage="${requestScope.pageInfo.currentPage }" pageSize="${requestScope.pageInfo.pageSize }" recordCount="${requestScope.pageInfo.recordCount }" pageCount="${requestScope.pageInfo.pageCount }" />
					<input type="hidden" name="beginDate" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="endDate" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd"/>" />
					<input type="hidden" name="playerName" value="${playerName}"/>
                    <input type="hidden" name="moneyType" value="${requestScope.moneyType}"/>
				</form>
				</td>
				<tr height="30px">
				    <td colspan="10" align="center" class="t_border" >
						<bean:message bundle="pageResources" key="page.tag.showSumMoney.tag"/>:
							${requestScope.sum}
						<!--
					    <gmweb:showSumMoney infoList="${requestScope.pageInfo.infoList}"></gmweb:showSumMoney>
					    -->
				    </td>
			    </tr>
			</tr>
		</table>
		<br />
		<div align="center">
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.export"/>" onclick="exportData()"/>
			<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="window.location.href='showQueryPlayerPurchaseDetail.do'"/>
		</div>
	</c:if>
</body>
</html>