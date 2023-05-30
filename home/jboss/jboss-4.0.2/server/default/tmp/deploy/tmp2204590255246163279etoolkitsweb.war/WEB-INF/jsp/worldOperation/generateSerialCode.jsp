<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<html:javascript formName="/generateSerialCode"/>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>
	</div>
	 <html:form action="generateSerialCode.do" method="post" onsubmit="return validateGenerateSerialCodeForm(this);">
		<input type="hidden" name="activityId" value="${activityId }" />
		<input type="hidden" name=version value="${requestScope.version }" />
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.title"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="mediaName" type="text"/>&nbsp;	
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaNametip"/></span>
				 </td>
			</tr>
			<tr height="30px">
				<td  class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.useLimit"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="useLimit" type="text" />&nbsp;
				 	<span class="tip"><bean:message bundle="pageResources" key="page.worldOperation.activityModelConfig.activityCodeLimit"/></span>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialNum"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="serialNum" type="text" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialType"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="serialType" type="radio" value="0" id="serialType0" checked="checked"/>
				 	<label for="serialType0"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialTypeDefault"/></label>
				 	<input name="serialType" type="radio" value="1" id="serialType1" />
				 	<label for="serialType1"><bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialTypeNumber"/></label>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" colspan="2">
					<input type="submit" style="margin-left: 30%" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> "/>&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityModel.do?version=${requestScope.version}'"/>
				</td>
			</tr>
		</table>
		</html:form>
		
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="6" align="center"></td>
				</tr>
				<tr>
					<td colspan="6" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCodeLog.title2"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.mediaName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.useLimit"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.generateSerialCode.serialNum"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.operatorName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityCode.insertTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.oper"/>
					</td>
				</tr>
				<c:forEach items="${requestScope.serialCodeLog}" var="log">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${log.mediaName}
						</td>
						<td align="center" class="t_border_l">
							${log.useLimit}
						</td>
						<td align="center" class="t_border_l">
							${log.serialNum }
						</td>
						<td align="center" class="t_border_l">
							${log.passportName}
						</td>
						<td align="center" class="t_border_l">
							${log.operTime}
						</td>
						<td align="center" class="t_border_r">
							<a href="downloadCodeFile.do?logId=${log.filePath }&type=1"><bean:message bundle="pageResources" key="page.worldOperation.activityCode.downloadFile"/></a>
						</td>
					</tr>
				</c:forEach>
				<tr height="30px">
					  	<td colspan="6" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
						</td>
					</tr>
			</table>
	</body>
</html>