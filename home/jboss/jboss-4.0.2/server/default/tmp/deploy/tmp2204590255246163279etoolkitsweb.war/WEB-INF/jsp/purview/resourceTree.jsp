<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
				function returnValue(id, name, pid){
					if(confirm("<bean:message bundle="pageResources" key="page.purview.resourceTree.confirmSelect"/>：\n" + name)){
						if(window.opener.document.all.resPid){
							window.opener.document.all.resPid.value = id;
							window.opener.document.all.strResPid.value = name;
							window.close();
						}
					}
				}
		</script>
	</head>

	<body>
  	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td align="center" ></td>
			</tr>
			<tr>
				<td align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.resourceTree.title"/></td>
			</tr>
			<tr class="ffffff">
				<td class="t_border_b">
					<br />
					<div onclick="returnValue('0','<bean:message bundle="pageResources" key="page.purview.resourceTree.rootResource"/>',0);" style="padding-left:10px;padding-bottom:5px;cursor:pointer">
						<img src="images/menu2.jpg"/>
						<bean:message bundle="pageResources" key="page.purview.resourceTree.rootResource"/>
					</div>
					<c:if test="${not empty requestScope.resourceList }">
					<c:forEach items="${requestScope.resourceList}" var="resourceInfo">
					<c:if test="${resourceInfo.resPid == 0 }">
						<div onClick="returnValue('${resourceInfo.resId}','<bean:message bundle="menuResources" key="${resourceInfo.resName }"/>',0);" style="padding-left:10px;padding-bottom:5px;cursor:pointer">
							<img src="images/menu2.jpg"/>
							<bean:message bundle="menuResources" key="${resourceInfo.resName }"/>（<bean:message bundle="menuResources" key="${resourceInfo.resDesc }"/>）
						</div>
						<c:forEach items="${requestScope.resourceList}" var="resourceInfo2">
							<c:if test="${resourceInfo.resId == resourceInfo2.resPid }">
								<div onClick="returnValue('${resourceInfo2.resId}','<bean:message bundle="menuResources" key="${resourceInfo2.resName }"/>','${resourceInfo.resId}');" style="padding-left:30px;padding-bottom:5px;cursor:pointer">
									<img src="images/ecard_r9_c7.jpg"/>
									<bean:message bundle="menuResources" key="${resourceInfo2.resName }"/>（<bean:message bundle="menuResources" key="${resourceInfo2.resDesc }"/>）
								</div>
								<c:forEach items="${requestScope.resourceList}" var="resourceInfo3">
									<c:if test="${resourceInfo2.resId == resourceInfo3.resPid }">
										<div onClick="returnValue('${resourceInfo3.resId}','<bean:message bundle="menuResources" key="${resourceInfo3.resName }"/>','${resourceInfo2.resId}');" style="padding-left:50px;padding-bottom:5px;cursor:pointer">
											<img src="images/menu3.jpg"/>
											<bean:message bundle="menuResources" key="${resourceInfo3.resName }"/>（<bean:message bundle="menuResources" key="${resourceInfo3.resDesc }"/>）
										</div>
									</c:if>
								</c:forEach>
							</c:if>
						</c:forEach>
					</c:if>
					</c:forEach>
					</c:if>
				</td>
			</tr>
		</table>	
	</body>
</html>

