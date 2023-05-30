<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/setPackage"/>
	<script type="text/javascript">
		function confirmDel(){
			return confirm('<bean:message bundle="pageResources" key="page.purview.common.confirmDel"/>');
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<html:form action="setPackage.do" method="post" onsubmit="return validateSetPackageForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeActivityType"/>：</td>
				 <td class="t_border_r" align="left">
					<select name="limitType" style="width:125px">
						<c:if test="${activityType == 5}">
							<option value="1"><bean:message bundle="pageResources" key="page.common.num"/></option>
						</c:if>
						<c:if test="${activityType != 5}">
							<option value="1"><bean:message bundle="pageResources" key="page.common.num"/></option>
							<option value="2"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.money"/></option>
						</c:if>
						
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeMoneyType"/>：
				 </td>
				 <td class="t_border_r" align="left">
					<select name="subjectId" style="width:125px">
						<option value='3' selected>3-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdGold"/></option>
						<option value='4'>4-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdSiv"/></option>
						<option value='5'>5-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdYuanbao"/></option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeItemCode"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="productCode" type="text"/>
					<span>&nbsp;&nbsp;<bean:message bundle="pageResources" key="page.worldOperation.setPackage.allItem"/></span>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeLowerLimit"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="lowerLimit" type="text"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeUpperLimit"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="upperLimit" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="hidden" name="activityId" value="${activityId }" />
					<input type="hidden" name="activityType" value="${activityType }" />
					<input type="hidden" name="version" value="${requestScope.version}" />
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showOperActivityModel.do?activityId=${activityId}&version=${requestScope.version}'"/>
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
		</div>
		<br>
		<c:if test="${not empty requestScope.packageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="6" align="center"></td>
				</tr>
				<tr>
					<td colspan="6" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.title2"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeActivityType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeMoneyType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeLowerLimit"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addConsumeActivity.consumeUpperLimit"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.oper"/>
					</td>
				</tr>
				<c:forEach items="${requestScope.packageInfo}" var="pkg">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${pkg.activityId}
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${pkg.limitType == 1}"><bean:message bundle="pageResources" key="page.common.num"/></c:if>
							<c:if test="${pkg.limitType == 2}"><bean:message bundle="pageResources" key="page.playerQuery.chargeDetail.money"/></c:if>
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${pkg.subjectId == 3}"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdGold"/></c:if>
							<c:if test="${pkg.subjectId == 4}"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdSiv"/></c:if>
							<c:if test="${pkg.subjectId == 5}"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdYuanbao"/></c:if>
						</td>
						<td align="center" class="t_border_l">
							${pkg.lowerLimit}
						</td>
						<td align="center" class="t_border_l">
							${pkg.upperLimit}
						</td>
						<td align="center" class="t_border_r">
							<a href="showSetPackageItem.do?activityId=${activityId}&packageId=${pkg.packageId }&activityType=${activityType}&version=${requestScope.version}"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.setItem"/></a>&nbsp;&nbsp;&nbsp;&nbsp;
							<a href="delActivityModelPackage.do?activityId=${activityId}&packageId=${pkg.packageId }&activityType=${activityType}&version=${requestScope.version}" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.common.del"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
					  	<td colspan="6" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		</c:if>
		
	</body>
</html>