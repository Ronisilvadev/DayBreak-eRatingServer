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
		function check(){
			var lowerLimit=document.getElementById("lowerLimit").value;
			var upperLimit=document.getElementById("upperLimit").value;
			var sub=document.getElementById("sub");
			
			if(lowerLimit==""||upperLimit==""){
				sub.disabled="disabled";
				return;
			}	
			if(isNaN(lowerLimit)||isNaN(upperLimit)){
				sub.disabled="disabled";
				return;
			}
			if(parseInt(lowerLimit)>parseInt(upperLimit)){
				sub.disabled="disabled";
				return;
			}		
			
			sub.disabled="";
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>
	</div>
	<html:form action="setPackage.do" method="post" onsubmit="return validateSetPackageForm(this);">
		<input type="hidden" name="activityId" value="${activityId }" />
		<input type="hidden" name="activityType" value="${activityType }" />
		<input type="hidden" name="productCode" value="0"/>
		<input type="hidden" name="version" value="${requestScope.version}" />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.setPackage.title"/></td>
			</tr>
			<tr height="30px">
				<td width="40%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.lowerLimit"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="lowerLimit" id="lowerLimit" onkeyup="check()" type="text"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.upperLimit"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="upperLimit" id="upperLimit" onkeyup="check()" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">					
					<input type="submit" id="sub" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " disabled="disabled" />&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showOperActivityModel.do?activityId=${activityId}&version=${requestScope.version}'"/>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</html:form>
		
		<c:if test="${not empty requestScope.packageInfo }">
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="4" align="center"></td>
				</tr>
				<tr>
					<td colspan="4" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.setPackage.title2"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.lowerLimit"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.upperLimit"/>
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
					  	<td colspan="4" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
		</c:if>
		
	</body>
</html>