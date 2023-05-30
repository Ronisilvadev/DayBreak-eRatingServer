<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title>无标题文档</title>
		<script type="text/javascript" src="js/func.js"></script>
		<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
		<script type="text/javascript">
		//检查网关，至少选择一个网关
		function checkGateway(){
			var gateway = document.getElementsByName("gatewayId");
			var flag = false;
			
			for (var i=0; i<gateway.length; i++){
		  		if(gateway[i].checked){
		  			flag = true;
		  		}		  	
		  	}	
		  	if(!flag){
		  		alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.gateway"/>');
				return false; 
		  	} else {
		  		return true;
		  	}
		}
		</script>
		<html:javascript formName="/worldDropRate"/>
	</head>


	<body bgcolor="#ffffff">
		<html:form action="worldDropRate.do" method="post" onsubmit="return checkGateway() && validateWorldDropRateForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.worldDropRate.title"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.gatewayId"/>：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
								<gmweb:createGatewayCheckboxTag name="gatewayId"
							checkedValue="${requestScope.gatewayId}"
							gatewayList="${requestScope.gatewayList}" showAllGateway="1" />
		
				 </td>
			</tr>
			<tr>
			<td class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.cancelWorldDropRate.title.pleaseInputConfig"/>
				 </td>
				 <td class="t_border_l" width="200x">
				 	<textarea name="itemId" style="width:200px;" rows="5" ></textarea>
				 </td>
				 <td class="t_border_r"  >
				 	<bean:message bundle="pageResources" key="page.worldOperation.worldDropRate.itemid.tip"/>
				 </td>
				 
			</tr>
			
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/> 
				 </td>
				 <td class="t_border_r" align="left"  colspan="2">
				 	<input name="startTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>  
				 </td>
				 <td class="t_border_r" align="left"  colspan="2">
				 	<input name="endTime" type="text" readonly onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:200px" value="<fmt:formatDate value="${ requestScope.endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
				<input type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.back"/>" onClick="history.go(-1);"/>
					
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
  	</body>
</html>
