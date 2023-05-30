<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/func.js"></script>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
		function check(){
			var len = document.forms[0].chargeChannelId.length; 
	        var checked = false; 
	
	        for (i = 0; i < len; i++) 
	        { 
	            if (document.forms[0].chargeChannelId[i].checked == true) 
	            { 
	                checked = true; 
	                break; 
	            } 
	        } 
	        
	        if (!checked && document.forms[0].activityType.value != "4" && document.forms[0].activityType.value != "5" && document.forms[0].activityType.value != "6") 
	        { 
	            alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityType"/>'); 
	            return false; 
	        } 
	        
			if ( document.forms[0].config.value == "" || document.forms[0].config.value  == null){
					alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.config"/>');
					document.forms[0].config.focus();
					return false;
			}
			
			else {
				  return true;
			}
		}
		
		function changeActivityType(object){
			if (object.value == "4" || object.value == "5" || object.value == "6"){
				var checkBox = document.getElementsByName('chargeChannelId');
				for (var i = 0;i < checkBox.length;i++){
					checkBox[i].disabled = true;
				} 
			}else{
				var checkBox = document.getElementsByName('chargeChannelId');
				for (var i = 0;i < checkBox.length;i++){
					checkBox[i].disabled = false;
				} 
			}
			
			if(object.value == "5"){
				document.getElementById("trBeginTime").style.display = "block";
				document.getElementById("trEndTime").style.display = "block";
			}
			else{
				document.getElementById("trBeginTime").style.display = "none";
				document.getElementById("trEndTime").style.display = "none";
			}
			if(object.value == "6"){
				document.getElementById("hiddendiv2").style.display = "";
				document.getElementById("hiddendiv1").style.display = "none";
				document.getElementById("hiddendiv3").style.display = "none";
				document.getElementById("hiddendiv4").style.display = "";	
			}else{
				document.getElementById("hiddendiv2").style.display = "none";
				document.getElementById("hiddendiv1").style.display = "";
				document.getElementById("hiddendiv3").style.display = "";
				document.getElementById("hiddendiv4").style.display = "none";
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="validateActivityPackage.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.title"/></td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/> </td>
				 <td class="t_border_r" align="left">
					 ${requestScope.activityId}
					 <input type="hidden" name="activityId" value="${ requestScope.activityId}" />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/></td>
				<td class="t_border_r" align="left">
					 ${requestScope.activityName}
					 <input type="hidden" name="activityName" value="${ requestScope.activityName}" />
				</td>
			</tr>
			<c:if test="${gameId>700 && gameId!=706 && gameId!=710 && gameId!=734 && gameId!=749 && gameId!=15 && gameId!=515 && gameId!= 769 && gameId!= 774 && gameId!=786}">
			<tr style="display:none">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeChannelId"/></td>
				<td class="t_border_r" align="left">
					<gmweb:createChannelIdCheckBox name="chargeChannelId" checkedValue="10" />
				</td>
			</tr>
			</c:if>
			<c:if test="${gameId<=700 || gameId==706 || gameId==710 || gameId==734 || gameId==749 || gameId==15 || gameId==515 || gameId==769 || gameId==774 || gameId ==786}">
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeChannelId"/></td>
				<td class="t_border_r" align="left">
					<gmweb:createChannelIdCheckBox name="chargeChannelId" checkedValue="0" />
				</td>
			</tr>
			</c:if>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectId"/></td>
				<td class="t_border_r" align="left">
					<select name="chargeSubjectId" style="width:125px">
						<option value='3' selected>3-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdGold"/></option>
						<!-- 
						<option value='4'>4-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdSiv"/></option>
						<option value='5'>5-<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.chargeSubjectIdYuanbao"/></option>
						 -->
					</select>
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityType"/></td>
				<td class="t_border_r" align="left">
					<select name="activityType" style="width:125px" onchange="changeActivityType(this)">
						<option value='2'><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue1"/></option>
						<option value='3'><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue2"/></option>
						<option value='4'><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue3"/></option>
						<option value='5'><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue4"/></option>
						<option value='6'><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.activityTypeValue5"/></option>
					</select>
				</td>
			</tr>
			<tr id="trBeginTime" style="display:none">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.cumuBeginTime"/></td>
				<td class="t_border_r" align="left">
					<input name="beginTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:120px" value="${requestScope.beginTime}" />
				</td>
			</tr>
			<tr id="trEndTime" style="display:none">
				<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.cumuEndTime"/></td>
				<td class="t_border_r" align="left">
					<input name="endTime" type="text" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width:120px" value="${requestScope.endTime}" />
				</td>
			</tr>
			<tr>
				<td width="25%" class="t_border_l" align="right" ><div id="hiddendiv3"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.config"/></div>&nbsp&nbsp</td>
				<td class="t_border_r" align="left">&nbsp&nbsp
					<div id="hiddendiv1">
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.configInfo1"/><br />
					<textarea name="config" rows=10 cols=35 size="10240" ></textarea><br />
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.configInfo2"/><br />
					50,100<br />
					100,200<br />
					200,-）
					</div>
				</td>
			</tr>
			<tr>	
				<td width="25%" class="t_border_l" align="right"><div id="hiddendiv4" style="display: none"><bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.config"/></div>&nbsp&nbsp</td>
				<td class="t_border_r" align="left">&nbsp&nbsp
					<div id="hiddendiv2" style="display: none">
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.configInfo1"/><br/>					
					<input type="text" name="config1"/><br/>
					<bean:message bundle="pageResources" key="page.worldOperation.addActivityPackage.configInfo3"/><br/>
					200,10000）
					<div>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="window.location.href='showActivityDetail.do?activityId=${requestScope.activityId}&action=showIssueActivity'"/>
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		<script type="text/javascript">
			document.forms[0].chargeChannelId.disabled = true;
	</script>
	</body>
</html>