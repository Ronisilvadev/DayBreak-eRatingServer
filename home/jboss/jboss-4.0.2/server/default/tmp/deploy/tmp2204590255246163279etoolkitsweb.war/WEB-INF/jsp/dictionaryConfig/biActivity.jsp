<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/jquery-1.2.pack.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<c:if test="${empty targetActivity}">
	<script type="text/javascript">
	
		$(function ()
		{
			$("#subActi").attr("disabled","true" ) ;
			$("#activityID").blur(function () {
				validateID() ;
				return true ;
			});
		}) ;
		function validateID()  {
			var temp = $("#activityID").val() ;
			if(temp=='' || temp.length>12 || temp.indexOf('.')!=-1){
				$("#subActi").attr("disabled","true" ) ;
				$("#tip").html('<bean:message bundle="pageResources" key="page.dictionaryOperation.addBiActivity.dontUseTip"/>') ;
				$("#tip").css("color","red");
				return false ;
			}
			else if(!isNaN(temp)){
				$.ajax({
 					type: "POST",
 					url: "idContanis.do",
 					data:   "activityId="+temp,
 					dataType:   "html", 
 					success: function(data){
 						if(data=='sucess'){
 							$("#tip").html('<bean:message bundle="pageResources" key="page.dictionaryOperation.addBiActivity.hasIdTip"/>') ;
 							$("#tip").css("color","red"); 
 							$("#subActi").attr("disabled","true" ) ;
 							return false ;
 						} else{
 							$("#tip").html('<bean:message bundle="pageResources" key="page.dictionaryOperation.addBiActivity.nothasIdTip"/>') ;
 							$("#tip").css("color","green");
 							$("#subActi").attr("disabled",false ) ;
 							return true ;
 						}
					}
				}); 
			}else{
				$("#subActi").attr("disabled","true" ) ;
				$("#tip").css("color","red");
				$("#tip").html('<bean:message bundle="pageResources" key="page.dictionaryOperation.addBiActivity.dontUseTip"/>') ;
				return false ;
			}
		}
	</script>
	</c:if>
	<c:if test="${not empty targetActivity}">
		<script type="text/javascript">
			//不验证ID
		 	function validateID() {
		 		return true ;
		 	}
		</script>
	</c:if>
    <html:javascript formName="/addBiActivity"/>
  </head>
  <body bgcolor="#ffffff">
  <c:if test="${empty requestScope.display}">
  <html:form action="addBiActivity.do" method="post" onsubmit="return validateID()&&validateAddBiActivityForm(this);">
  		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  		
			<tr>
				<td align="center" height="30px"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><c:if test="${not empty targetActivity}"><bean:message bundle="pageResources" key="page.common.modify"/></c:if><c:if test="${empty targetActivity}"><bean:message bundle="pageResources" key="page.common.add"/></c:if><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.addActivityTitle"/></td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.activityid"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input id="activityID" name="activityId" type="text" value="<c:if test="${not empty targetActivity}">${targetActivity.activityId }</c:if>" <c:if test="${not empty targetActivity}">readonly</c:if>/>&nbsp;<div id="tip" style="display: inline;"></div>&nbsp;<bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.activityidisanumber"/>
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.startDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="beginTime" type="text" readonly="readonly" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<c:if test="${not empty targetActivity}"><fmt:formatDate value="${targetActivity.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></c:if><c:if test="${empty targetActivity}"><fmt:formatDate value="${requestScope.activityBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.endDate"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="endTime" type="text" readonly="readonly" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<c:if test="${not empty targetActivity}"><fmt:formatDate value="${targetActivity.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/></c:if><c:if test="${empty targetActivity}"><fmt:formatDate value="${requestScope.activityEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/></c:if>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.activityDesc"/>:
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityDesc" type="text" style="width:200px" <c:if test="${not empty targetActivity}">value="${targetActivity.activityDesc }"</c:if>/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit"  ID="subActi" value="<bean:message bundle="pageResources" key="page.common.save"/>" />&nbsp;&nbsp;&nbsp;
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onclick="history.go(-1);" />
				</td>
			</tr>
		</table>
		</html:form>
		
	</c:if>
	<c:if test="${not empty requestScope.display}">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="10" align="center" ></td>
			</tr>
			<tr>
				<td colspan="10" align="center" class="t_head"> <bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.configActivityTitle"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6"> 
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.activityid"/></td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.startDate"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.endDate"/> </td>
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.activityDesc"/> </td>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.operation"/> </td>
			</tr>
		<c:forEach items="${requestScope.list}" var="activity">
			<tr height="23px">
				<td align="center" class="t_border_l">
					${activity.activityId }
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activity.beginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>					
				</td>
				<td align="center" class="t_border_l">
					<fmt:formatDate value="${activity.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>	
					
				</td>
				<td align="center" class="t_border_l">
					${activity.activityDesc }
				</td>
				<td align="center" class="t_border_r">
					<a href="showAddBiActivity.do?activityId=${activity.activityId }"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.modifyDesc"/></a>
					&nbsp;&nbsp;
					<a href="showConfigGateway.do?activityId=${activity.activityId }"><bean:message bundle="pageResources" key="page.dictionaryOperation.biActivity.configGateway"/></a>
				</td>
			</tr>
		</c:forEach>
			<tr height="30px">
				<td colspan="5" align="center" class="t_border"><input type="button" value="<bean:message bundle="pageResources" key="page.common.add"/>" onclick="window.location.href='showAddBiActivity.do';"/>
					
				</td>
			</tr>
		</table>
	</c:if>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
  </body>
</html>
