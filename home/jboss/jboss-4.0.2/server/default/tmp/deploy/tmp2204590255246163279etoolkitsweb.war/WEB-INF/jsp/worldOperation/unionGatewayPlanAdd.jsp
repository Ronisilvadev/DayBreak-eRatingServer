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
			var v_taskName = document.getElementById("taskName").value;
			//alert(trim(v_taskName));
			if(trim(v_taskName).length<1 ||trim(v_taskName).length>256 ){
					alert("<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.nameConstrict"/>");
					return false;
			}
			obj.submit();
		}
		
		function trim(str) {
 		 	return str.replace(/(^\s+)|(\s+$)/g, "");
		}
			
	</script>
	</head>

	<body bgcolor="#ffffff">
	
	<c:if test="${ empty requestScope.unionGatewayPlan}">
	
	<form action="addUnionGatewayPlan.do" method="post" >
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ><br /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">				
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.addPlan"/>
				</td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.planName"/>
				</td>	
				<td class="t_border_r" align="left">
					<input name="taskName" id="taskName" type="text"></input>
					
					
				</td>
				
			</tr>
			
			
			<tr>	
				<td colspan="8" align="center" class="t_border">	
					
 					<input type="button" id="submitButton" onclick="submitForm(document.forms[0])"  value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  />
					<input name="back" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="history.back(-1);"/>
				</td>	
			</tr>
		</table>
	</form>
	</c:if>
	
	
	<c:if test="${not empty requestScope.unionGatewayPlan}">
	
	<form action="modifyUnionGatewayPlan.do" method="post" >
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ><br /></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head">				
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.eddPlan"/>
				</td>
			</tr>
			<tr>
				<td width="45%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.planName"/>
				</td>	
				<td class="t_border_r" align="left">
					<input name="taskName" id="taskName" type="text" value="${requestScope.unionGatewayPlan.taskName}"/>
					
					
				</td>
				
			</tr>
			
			
			<tr>	
				<td colspan="8" align="center" class="t_border">	
					<input name="taskId"  type="hidden" value="${requestScope.unionGatewayPlan.taskId}"></input>
 					<input type="button" id="submitButton" onclick="submitForm(document.forms[0])"  value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  />
 					&nbsp;&nbsp;&nbsp;
					<input name="back" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="history.back(-1);"/>
				</td>	
			</tr>
		</table>
	</form>
	</c:if>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" id="msg" size="3px">${msg}</font>
	</div>	
	
	</body>
</html>
