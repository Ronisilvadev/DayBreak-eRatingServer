<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<html:javascript formName="/addActivityModel"/>
	<script type="text/javascript">
		
	</script>
</head>


<body bgcolor="#ffffff">
	<div align="center">
		<font color="red" size="3px"><html:errors/></font>
		<font color="red" size="3px">${msg }</font>
	</div>
	
	<form action="mute2ActivityModel.do" method="post"  >
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2">
					<input name="activityId" type="hidden" value="${serial.activityId}"/>
				</td>
			</tr>
			<tr>
					<td colspan="8" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.activityModel.activityMute"/>
						
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftStartTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTime"/>
					</td>				
				</tr>
				<tr height="23px" >
					<td align="center" class="t_border">
						${serial.activityName}
					</td>
					<td align="center" class="t_border">
						<c:if test="${serial.activityType == '1'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/></c:if> 
						<c:if test="${serial.activityType == '3'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/></c:if> 
						<c:if test="${serial.activityType == '5'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/></c:if> 
						<c:if test="${serial.activityType == '6'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/></c:if> 
						<c:if test="${serial.activityType == '7'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/></c:if>  
						<c:if test="${serial.activityType == '8'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType8"/></c:if>  
					</td>
					<td align="center" class="t_border">
						
						<fmt:formatDate value="${serial.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
					</td>
					<td align="center" class="t_border">
						
						<fmt:formatDate value="${serial.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
					</td>
					<td align="center" class="t_border">
						
						<fmt:formatDate value="${serial.giftBeginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
					</td>
					<td align="center" class="t_border">						
						${serial.giftEndTime }<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTimeInfo"/>&nbsp;
					</td>									
				</tr>
				
		</table>
		
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>				
				 
			</tr>
			<tr>
					<td colspan="8" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.worldOperation.activityModel.muteList"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftStartTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.oper"/>
					</td>
					
				</tr>
				<c:forEach items="${requestScope.muteList}" var="act">
					<tr height="23px" title="<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>:${act.activityId}&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleStartTime"/>:<fmt:formatDate value="${act.roleBeginTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleEndTime"/>:<fmt:formatDate value="${act.roleEndTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13">
						<td align="center" class="t_border">
							${act.activityName}
						</td>
						<td align="center" class="t_border">
							<c:if test="${act.activityType == '1'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/></c:if> 
							<c:if test="${act.activityType == '3'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/></c:if> 
							<c:if test="${act.activityType == '5'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/></c:if> 
							<c:if test="${act.activityType == '6'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/></c:if> 
							<c:if test="${act.activityType == '7'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/></c:if>
							<c:if test="${act.activityType == '8'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType8"/></c:if>  
						</td>
						<td align="center" class="t_border">
							<fmt:formatDate value="${act.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border">
							<fmt:formatDate value="${act.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border">
							<fmt:formatDate value="${act.giftBeginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border">
							${act.giftEndTime }<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTimeInfo"/>&nbsp;
						</td>
						<td align="center" class="t_border">
							&nbsp;
							<a href="mute2ActivityModel.do?activityId1=${act.activityId}&activityId=${serial.activityId}&operType=1" onclick="return confirmDel();">
							<bean:message bundle="pageResources" key="page.common.del"/>
							</a>
						</td>
					</tr>
				</c:forEach>
		</table>
		
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="2"></td>				
				 
			</tr>
			<tr>
					<td colspan="8" align="center" class="t_head">
						
						<bean:message bundle="pageResources" key="page.worldOperation.activityModel.noMuteList"/>
					</td>
				</tr> 
				<tr height="23px" class="h_CDE4F6">
					<td align="center" class="t_border_l">						
						<bean:message bundle="pageResources" key="page.common.choice"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.actType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.startTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.endTime"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftStartTime"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTime"/>
					</td>
					
					
				</tr>
				<c:forEach items="${requestScope.list}" var="act">
					<tr height="23px" title="<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>:${act.activityId}&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleStartTime"/>:<fmt:formatDate value="${act.roleBeginTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13<bean:message bundle="pageResources" key="page.worldOperation.serialCode.roleEndTime"/>:<fmt:formatDate value="${act.roleEndTime}"	pattern="yyyy-MM-dd HH:mm:ss" />&#13">
						<td align="center" class="t_border_l">
							<input name="activityIds" type="checkbox" value="${act.activityId}"/>
						</td>
						<td align="center" class="t_border_l">
							${act.activityName}
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${act.activityType == '1'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType1"/></c:if> 
							<c:if test="${act.activityType == '3'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType3"/></c:if> 
							<c:if test="${act.activityType == '5'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType5"/></c:if> 
							<c:if test="${act.activityType == '6'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType6"/></c:if> 
							<c:if test="${act.activityType == '7'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType7"/></c:if>  
							<c:if test="${act.activityType == '8'}"><bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityType8"/></c:if>
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.beginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.endTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_l">
							<fmt:formatDate value="${act.giftBeginTime }"	pattern="yyyy-MM-dd HH:mm:ss" />&nbsp;
						</td>
						<td align="center" class="t_border_r">
							${act.giftEndTime }<bean:message bundle="pageResources" key="page.worldOperation.serialCode.giftEndTimeInfo"/>&nbsp;
						</td>
						
					</tr>
				</c:forEach>
				<tr>
		  				<td colspan="8" align="center" class="t_border">
		  					<input type="submit" value='<bean:message bundle="pageResources" key="page.common.submit"/>'/>
		  					<input type="button" value=' <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> ' onclick="window.location.href='showOperActivityModel.do?activityId=${serial.activityId}&version=new'"/>
		  				</td>
	  			</tr>
		</table>		
		</form>
	</body>
</html>