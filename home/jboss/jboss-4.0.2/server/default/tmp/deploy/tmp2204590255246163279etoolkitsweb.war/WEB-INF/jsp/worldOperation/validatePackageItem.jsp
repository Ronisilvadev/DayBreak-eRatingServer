<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
	</head>

	<body bgcolor="#ffffff">

		<c:if test="${not empty requestScope.itemList}">
		<form action="addActivityPackageItem.do" method="post">
			<table width="90%" border="0" cellpadding="0" cellspacing="0"
				align="center">
				<tr height="30px">
					<td colspan="5" align="center"></td>
				</tr>
				<tr>  
					<td colspan="5" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.validatePackageItem.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemCode"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.itemNum"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.beginTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.activityPackageDetail.endTime"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.itemList}" var="item">
					<tr height="23px">
						<td align="center" class="t_border_l">
							${item[0] }
						</td>
						<td align="center" class="t_border_l">
							${item[1] }
						</td>
						<td align="center" class="t_border_l">
							${item[2] }
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${requestScope.beginTime }" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
						<td align="center" class="t_border_r">
							<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
				</c:forEach>
			<tr height="30px">
				<td colspan="5" align="center" class="t_border">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/>" />&nbsp;&nbsp;
					<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.common.back2"/>" onclick="history.go(-1);" />
				</td>
			</tr>
			</table>
			 <input type="hidden" name="activityId" value="${ requestScope.activityId}" />
			 <input type="hidden" name="activityName" value="${ requestScope.activityName}" />
			 <input type="hidden" name="packageId" value="${ requestScope.packageId}" />
			 <input type="hidden" name="item" value="${ requestScope.item}" />
			 <input type="hidden" name="beginTime" value="<fmt:formatDate value="${requestScope.beginTime }" pattern="yyyy-MM-dd HH:mm:ss" />" />
			 <input type="hidden" name="endTime" value="<fmt:formatDate value="${requestScope.endTime }" pattern="yyyy-MM-dd HH:mm:ss" />" />
		</form>			
		</c:if>
		<div align="center">
				<font color="red" size="3px">${msg }</font>
		</div>

	</body>
</html>
