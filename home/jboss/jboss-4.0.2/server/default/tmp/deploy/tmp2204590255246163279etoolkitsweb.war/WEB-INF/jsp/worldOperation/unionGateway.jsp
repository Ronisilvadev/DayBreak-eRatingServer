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
	    
		var DifferenceHour = -1;
		var DifferenceMinute = -1;
		var DifferenceSecond = -1;
		
		var Tday = new Date(${beginTime}) ;  //只能将时间的毫秒数传过来，直接传时间会有问题
		//alert(Tday);
		var daysms = 24 * 60 * 60 * 1000;
		var hoursms = 60 * 60 * 1000;
		var Secondms = 60 * 1000;
		var microsecond = 1000;
		
		var arr = new Array(13);
		var timer = 0;
		var state = 0;//state=0表示处在运行状态
		
		
		function clock()
		
		{	
			timer=timer+1;
			
			if(timer>10){
				timer=0;
			}
			//发送ajax请求，合服的运行状况
			
			if(timer==1){
				
					var ajax = new Ajax();
					var url="openUnionGateway.do?oldGatewayId="+"${unionGateway.oldGatewayId}"+"&newGatewayId="+"${unionGateway.newGatewayId}"+"&ajaxRequest=1"+"&randomCode="+Math.round(Math.random()*10000);
					//alert(url);
					ajax.send(url,"get",function(request){
						var resultText = request.responseText.trim();
						state = resultText;
						//alert(resultText);
						//var resultArray = resultText.split(";");												
						//state = resultArray[0];
						//resultArray[0] is the state, resultArray[1] is description of the Task ,e.g. 254,231,221,
						//var descArray = resultArray[1].split(",");
						//for (i=0; i<arr.length;i++){
						//	arr[i]=descArray[i];
						//}						
						//showRecordDesc();
					});
			
			}
		
			
			showTimeDesc();
			
			if(state!=0){
				document.getElementById("taskOver").style.visibility = "visible";
				return;
			}
			
			
			// document.formnow.Tnow.value= DifferenceHour DifferenceMinute + DifferenceSecond + dSecs
			setTimeout("clock()",1000);
		}
		
		
		
	
		
		
		function showTimeDesc(){
			var time = new Date();			
			var convertHour = DifferenceHour;
			var convertMinute = DifferenceMinute;
			var convertSecond = DifferenceSecond;
			var Diffms =  time.getTime()-Tday.getTime();			
			DifferenceHour = Math.floor(Diffms / daysms);
			Diffms -= DifferenceHour * daysms;
			DifferenceMinute = Math.floor(Diffms / hoursms);
			Diffms -= DifferenceMinute * hoursms;
			DifferenceSecond = Math.floor(Diffms / Secondms);
			Diffms -= DifferenceSecond * Secondms;
			var dSecs = Math.floor(Diffms / microsecond);
			if(convertHour != DifferenceHour) document.pageForm.dd.value=DifferenceHour;
			if(convertMinute != DifferenceMinute) document.pageForm.hh.value=DifferenceMinute;
			if(convertSecond != DifferenceSecond) document.pageForm.mm.value=DifferenceSecond;
			document.pageForm.ss.value=dSecs;	
		}
	
	</script>
	</head>

	<body  onload="clock();return true;" bgcolor="#ffffff">
		
	<form action="showOperUnionGatewayPlan.do" method="post" name="pageForm">
	
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="8" align="center" ><br /></td>
			</tr>
			<tr>
				<td colspan="8" align="center" class="t_head">
				
				<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.unionGateway"/>
				</td>
			</tr>		
			<tr>
				<td colspan="2" align="right" class="t_border">
				
				<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.sourceGateway"/>
				</td>
				<td colspan="6" align="left" class="t_border">
				
				${unionGateway.oldGatewayName}(${unionGateway.oldGatewayId})
				</td>
			</tr>
			<tr>
				<td colspan="2" align="right" class="t_border">
				
				<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.destinationGateway"/>
				</td>
				<td colspan="6" align="left" class="t_border">
				
				${unionGateway.newGatewayName}(${unionGateway.newGatewayId})
				</td>
			</tr>
		
			
			
			<tr>
				<td colspan="2" align="right" class="t_border">
				
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.usedTime"/>
				</td>
				<td colspan="6" align="left" class="t_border">
					<b>
						<input name="dd" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.day"/>
						<input name="hh" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.hour"/>
						<input name="mm" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.minute"/>
						<input name="ss" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.second"/>
					</b>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="right" class="t_border">
				
					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.taskBeginTime"/>
				</td>
				<td colspan="6" align="left" class="t_border">
				
				<fmt:formatDate value="${unionGateway.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="right" class="t_border">
				
					<bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/>
				</td>
				<td colspan="6" align="left" class="t_border">
				
				${unionGateway.operator}
				</td>
			</tr>
			
			
			
			
			
	


			<tr height="30px">
				<td colspan="8" align="center" class="t_border">					
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.returnToList"/>"/>&nbsp;&nbsp; 
					<input name="taskId" type="hidden" value="${unionGateway.taskId}"/>&nbsp;&nbsp; 		
				</td>
			</tr>
			
	
		</table>
		
		</form>
		
		
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<label id="taskOver" style="visibility:hidden;color:red;size:3px"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.TaskOver"/></label>
		</div>
	
	</body>
</html>
