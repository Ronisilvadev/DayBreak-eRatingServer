<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/ajax.js"></script>
	<script type="text/javascript">
	
	
		
		function submitForm(obj){
			
			var oldGatewayId = document.getElementById("oldGatewayId").value;
			var newGatewayId = document.getElementById("newGatewayId").value;
			
			if(oldGatewayId==newGatewayId){
				alert("<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.error.duplicatedGateway"/>");
				return false;
			}
			
			var oldGatewayId = document.getElementById("oldGatewayId").value;
			var newGatewayId = document.getElementById("newGatewayId").value;
			
			if(confirm("<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.submitConfirm"/>"
			+"<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGateway"/>："+oldGatewayId+", "
			+"<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGateway"/>："+newGatewayId)==true){
				obj.submit();
			}	 	
		}
		
		function changeOperType(){
					
			var obj = document.getElementById("oldGatewayId");
			//alert(obj);
			var oldGatewayId = obj.value;
			
			var obj1 = document.getElementById("newGatewayId");
			//alert(obj);
			var newGatewayId = obj1.value;
			
			
			
			
			var url;	
			url = "showAddUnionGateway.do?taskId=${requestScope.taskId}&oldGatewayId=" +oldGatewayId+"&newGatewayId="+newGatewayId+"&ramdomCode="+Math.round(Math.random()*100);
						
			//alert(url);
			//alert(object.innerHtml);
			window.location.href = url;
		}
		
		function shutOldGateway(){
			
			var obj = document.getElementById("oldGatewayId");
			//alert(obj);
			var oldGatewayId = obj.value;			
			
			var ajax = new Ajax();
			var url="shutOldGateway.do?oldGatewayId="+oldGatewayId+"&randomCode="+Math.round(Math.random()*10000);
			
			if(confirm("<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.closeOriginalWarning"/>")==true){
			
				//alert(url);
				ajax.send(url,"get",function(request){
						var resultText = request.responseText.trim();						
					});
				
			}			
			changeOperType();			
			
		}
			
	</script>
	</head>

	<body bgcolor="#ffffff">
		
	<form action="addUnionGateway.do" method="post" name="pageForm">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ><br /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">
				
				<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.chooseGateway"/>
				</td>
			</tr>
			<tr>
				<td width="35%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.chooseSourceGateway"/>&nbsp;&nbsp;
				</td>	
				<td class="t_border_r" align="left">
					<select name="oldGatewayId" id="oldGatewayId"  style="width:250px" onchange="changeOperType();">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }"
							<c:if test="${gateway.gatewayId eq requestScope.oldGatewayId}">
								selected
							</c:if >							
							>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
					
					
				</td>
				
			</tr>
			
			<!-- 若源网关没有过期，需要让其过期 -->
			<c:if test="${requestScope.validResult eq 0}">
			<tr>
				<td width="35%" class="t_border_l" align="right">
				&nbsp;&nbsp;
				</td>	
				
				
				<td class="t_border_r" align="left">
					<font color="red">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.originalLifeTime"/>
						<fmt:formatDate value="${requestScope.oldGateway.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.stillValid"/>
					</font>
						<input type="button" id="submitButton" onclick="shutOldGateway()"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.shutOriginal"/>"  />
				</td>				
			</tr>
			</c:if >
			
			
			<tr>
				<td width="35%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.chooseDestinationGateway"/>&nbsp;&nbsp;
				</td>	
				<td class="t_border_r" align="left">
					<select name="newGatewayId" id="newGatewayId" style="width:250px" onchange="changeOperType();">
				  		<c:forEach items="${requestScope.gatewayList}" var="gateway">
				  			<option value="${gateway.gatewayId }"
				  			<c:if test="${gateway.gatewayId eq requestScope.newGatewayId}">
								selected
							</c:if >
				  			>${gateway.gatewayId} - ${gateway.gatewayName}</option>
				  		</c:forEach>
					</select>
				</td>
				
			</tr>
			<c:if test="${requestScope.validResultDest > 0}">
			<tr>
				<td width="35%" class="t_border_l" align="right">
				&nbsp;&nbsp;
				</td>	
				<td class="t_border_r" align="left">
					<font color="red">
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destlLifeTime"/>
						<fmt:formatDate value="${requestScope.newGateway.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>	
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationTips"/>
					</font>
					
				</td>				
			</tr>
			</c:if >
			
			<tr>
				<td width="35%" class="t_border_l" align="right">
				&nbsp;&nbsp;
				</td>	
				<td class="t_border_r" align="left">
					
						
						<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.alterTimeTips"/>
					
					
				</td>				
			</tr>
			
			<tr>	
				<td colspan="8" align="center" class="t_border">	
					<input name="taskId" type="hidden" value="${requestScope.taskId}"/>
 					<input type="button" id="submitButton" onclick="submitForm(document.forms[0])"  value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  />
					<input name="back" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="history.back(-1);"/>
				</td>	
			</tr>
		</table>
	</form>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" id="msg" size="3px">${msg}</font>
	</div>	
	
	</body>
</html>
