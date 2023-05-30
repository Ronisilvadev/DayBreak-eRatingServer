<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv= "refresh "   content= "60 "/> 
		<meta http-equiv="pragma" content="no-cache"/>
		<meta http-equiv="cache-control" content="no-cache"/>
		<meta http-equiv="expires" content="0"/>
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
					var url="showOperUnionGatewayPlan.do?taskId="+"${unionGatewayPlan.taskId}"+"&ajax=ajax"+"&randomCode="+Math.round(Math.random()*10000);
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
				setTimeout("redirect()",600);
				return;
			}
			
			
			// document.formnow.Tnow.value= DifferenceHour DifferenceMinute + DifferenceSecond + dSecs
			setTimeout("clock()",1000);
		}
		
		
		function redirect(){
			var url="showOperUnionGatewayPlan.do?taskId="+"${unionGatewayPlan.taskId}";
			window.location.href=url;
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
			//alert(DifferenceHour+"；"+DifferenceMinute+"；"+DifferenceSecond);
			if(convertHour != DifferenceHour) document.getElementById("dd").value=DifferenceHour;
			if(convertMinute != DifferenceMinute) document.getElementById("hh").value=DifferenceMinute;
			if(convertSecond != DifferenceSecond) document.getElementById("mm").value=DifferenceSecond;
			document.getElementById("ss").value=dSecs;
			
			
		}
	
	</script>

	
</head>


<body  onload="
	<c:if test="${requestScope.unionGatewayPlan.backStatus==0 }">	clock();
	</c:if>return true;" bgcolor="#ffffff">


		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.unionPlan"/></td>
			</tr>
			<c:if test="${not empty requestScope.unionGatewayPlan }">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.planName"/>
				 </td>
				<td align="center" class="t_border_r">${unionGatewayPlan.taskName}&nbsp;</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakeStatus"/>
								
										
				</td>
				<td align="center" class="t_border_r">
										<c:if test="${requestScope.unionGatewayPlan.backStatus==-1 }">
														<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusUnbake"/>
										</c:if>
										<!-- 正在执行状态 -->
										<c:if test="${requestScope.unionGatewayPlan.backStatus==0 }">				
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusBaking"/>
										</c:if>
										<!-- 正常结束 -->
										<c:if test="${requestScope.unionGatewayPlan.backStatus==1 }">	
										   					<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakedOK"/>	
										</c:if>
										<!-- 异常结束 -->
										<c:if test="${requestScope.unionGatewayPlan.backStatus==2 }">
															<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakedError"/>
										</c:if>	</td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakeOperator"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;${requestScope.unionGatewayPlan.backOperator}&nbsp;</td>
			</tr>
				<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.lastBakeTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGatewayPlan.backTimeE}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
			</tr>
			<c:if test="${requestScope.unionGatewayPlan.backStatus==0 }">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.currentBakeTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGatewayPlan.backTimeB}" pattern="yyyy-MM-dd HH:mm:ss"/> &nbsp;</td>
			</tr>
			</c:if>
			
			
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exeStatus"/>
								
										
				</td>
				<td align="center" class="t_border_r">
										<c:if test="${requestScope.unionGatewayPlan.exeStatus==-1 }">
												<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusUnexe"/>
										</c:if>
										<!-- 正在执行状态 -->
										<c:if test="${requestScope.unionGatewayPlan.exeStatus==0 }">				
												<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusExeing"/>
										</c:if>
										<!-- 正常结束 -->
										<c:if test="${requestScope.unionGatewayPlan.exeStatus==1 }">	
										   		<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exedOK"/>
										</c:if>
										<!-- 异常结束 -->
										<c:if test="${requestScope.unionGatewayPlan.exeStatus==2 }">
												<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exedError"/>
										</c:if>	</td>
			</tr>
			
		
		
			
			
			
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.common.startTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGatewayPlan.exeTimeB}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.common.endTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;<fmt:formatDate value="${requestScope.unionGatewayPlan.exeTimeE}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			</tr>
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.roleOperation.moveRole.GMOper"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;${requestScope.unionGatewayPlan.exeOperator}&nbsp;</td>
			</tr>
			
			<c:if test="${requestScope.unionGatewayPlan.backStatus==0 }">
			<tr height="23px">
				<td width="35%" class="t_border_l" align="center"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakeUsedTime"/>
				 </td>
				<td align="center" class="t_border_r">&nbsp;
					<b>
						<input id="dd" name="dd" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.day"/>
						<input id="hh" name="hh" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.hour"/>
						<input id="mm" name="mm" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.minute"/>
						<input id="ss" name="ss" type="text" style="border:0;" size=1/><bean:message bundle="pageResources" key="page.common.second"/>
					</b> &nbsp;</td>
			</tr>
			</c:if>
			
			
			
			
			
			
			
			<tr height="10px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
			</c:if>
		</table>

		<div align="center">
			<!-- 返回 -->
			<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="window.location.href='showUnionGatewayPlanList.do'" />&nbsp;&nbsp;
			<!-- 未备份 -->
			<c:if test="${requestScope.unionGatewayPlan.backStatus==-1 }">	

				<input type="button"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.bakeData"/>" onclick="window.location.href='bakeUnionGatewayPlan.do?taskId=${requestScope.unionGatewayPlan.taskId}'" />&nbsp;&nbsp;
			</c:if>
			<!-- 正在执行状态 -->
			<c:if test="${requestScope.unionGatewayPlan.backStatus==0 }">				
				<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusBaking"/>" disabled />&nbsp;&nbsp;
			</c:if>
			<!-- 正常结束 -->
			<c:if test="${requestScope.unionGatewayPlan.backStatus==1 or requestScope.unionGatewayPlan.backStatus==2   }">	
			   <input type="button"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.reBake"/>" onclick="window.location.href='bakeUnionGatewayPlan.do?taskId=${requestScope.unionGatewayPlan.taskId}'" />&nbsp;&nbsp;
			</c:if>
			
			<c:if test="${requestScope.unionGatewayPlan.exeStatus==-1 }">	

				<input type="button"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.exePlan"/>" onclick="window.location.href='exeUnionGatewayPlan.do?taskId=${requestScope.unionGatewayPlan.taskId}'" />&nbsp;&nbsp;
			</c:if>
			<!-- 正在执行状态 -->
			<c:if test="${requestScope.unionGatewayPlan.exeStatus==0 }">				
				<input type="button" value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.statusExeing"/>" disabled />&nbsp;&nbsp;
			</c:if>
			<!-- 正常结束 -->
			<c:if test="${requestScope.unionGatewayPlan.exeStatus==1 or requestScope.unionGatewayPlan.exeStatus==2   }">	
			   <input type="button"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.reExePlan"/>" onclick="window.location.href='exeUnionGatewayPlan.do?taskId=${requestScope.unionGatewayPlan.taskId}'" />&nbsp;&nbsp;
			</c:if>
		   
			<input type="button"  value="<bean:message bundle="pageResources" key="page.worldOperation.unionGateway.configViewPlan"/>" onclick="window.location.href='showUnionGatewayList.do?taskId=${requestScope.unionGatewayPlan.taskId}'" />&nbsp;&nbsp;
			

		</div>
		
		
		
		
		
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<label id="taskOver" style="visibility:hidden;color:red;size:3px"><bean:message bundle="pageResources" key="page.worldOperation.unionGateway.planbakedOver"/></label>
			
			<font color="red" size="3px">${msg}</font>
	</div>	
	</body>
</html>