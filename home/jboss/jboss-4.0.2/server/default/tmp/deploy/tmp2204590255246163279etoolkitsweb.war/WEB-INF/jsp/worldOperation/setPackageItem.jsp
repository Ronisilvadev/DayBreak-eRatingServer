<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/setPackageItem"/>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>
	</div>
	<html:form action="setPackageItem.do" method="post" onsubmit="return validateSetPackageItemForm(this);">
		<input type="hidden" name="packageId" value="${packageId }" />
		<input type="hidden" name="activityId" value="${activityId }" />
		<input type="hidden" name="activityType" value="${activityType }" />
		<input type="hidden" name="version" value="${requestScope.version }" />
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.title"/></td>
			</tr>
			<c:if test="${activityType >= 5&&activityType<8}">
				<tr height="30px">
					<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.giveType"/>：
					 </td>
					 <td class="t_border_r" align="left">
						<select onchange="changeItem(this)" style="width:125px">
							<option value="1"><bean:message bundle="pageResources" key="page.common.item"/></option>
							<option value="2"><bean:message bundle="pageResources" key="page.common.point"/></option>
						</select>
					 </td>
				</tr>
			<script language="javascript">
				function changeItem(obj){
					if(obj.value == 1){
						document.getElementById("trItemCode").style.display = "block";
						document.getElementById("trItemName").style.display = "block";
						document.getElementById("itemCode").value = "";
						document.getElementById("itemName").value = "";
						document.getElementById("itemNum").value = "";
						document.getElementById("tdItemNum").innerHTML = '<bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemNum"/>：';
					}
					else{
						document.getElementById("trItemCode").style.display = "none";
						document.getElementById("trItemName").style.display = "none";
						document.getElementById("itemCode").value = "0";
						document.getElementById("itemName").value = '<bean:message bundle="pageResources" key="page.common.point"/>';
						document.getElementById("itemNum").value = "";
						document.getElementById("tdItemNum").innerHTML = '<bean:message bundle="pageResources" key="page.common.pointNum"/>：';
					}
				}
			</script>
			</c:if>
			<tr id="trItemCode" height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemCode"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input id="itemCode" name="itemCode" type="text"/>
				 </td>
			</tr>
			<tr id="trItemName" height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input id="itemName" name="itemName" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td id="tdItemNum" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemNum"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="itemNum" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" colspan="2">					
					<input type="submit" style="margin-left:35%" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showSetPackage.do?activityId=${activityId}&activityType=${activityType}&version=${requestScope.version}'"/>
				</td>
			</tr>
		</table>
		</html:form>

		<br>
		<c:if test="${not empty requestScope.packageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="4" align="center"></td>
				</tr>
				<tr>
					<td colspan="4" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.title3"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemCode"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.itemNum"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.oper"/>
					</td>
				</tr>
				<c:forEach items="${requestScope.packageInfo}" var="pkg">
					<tr height="23px">
						<td align="center" class="t_border_l">
							<c:if test="${pkg.itemCode == 's_point'}">0</c:if>
							<c:if test="${pkg.itemCode != 's_point'}">${pkg.itemCode}</c:if>
						</td>
						<td align="center" class="t_border_l">
							${pkg.itemName}
						</td>
						<td align="center" class="t_border_l">
							${pkg.itemNum }
						</td>
						<td align="center" class="t_border_r">
							<a href="delActivityModelPackageItem.do?activityId=${activityId}&activityType=${activityType }&packageId=${packageId }&itemCode=${pkg.itemCode}&version=${requestScope.version}" onclick="return confirmDel();"><bean:message bundle="pageResources" key="page.common.del"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
					  	<td colspan="4" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		</c:if>
		
	</body>
</html>