<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
       <script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<title>无标题文档</title>
	
	<script type="text/javaScript">
			
			function check(){
			
				if ( document.forms[0].reason.value == "" || document.forms[0].reason.value  == null){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.reason"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				if ( document.forms[0].reason.value.length > 512){
					  alert('<bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.reasonLimit"/>');
					  document.forms[0].reason.focus();
					  return false;
				}
				
				else {
					  return true;
				}
			}
		function change(){
		var obj=document.getElementById("freeModel");
		
		if(obj.value==1){
			document.getElementById("showone").style.display="";
			document.getElementById("showtwo").style.display="none";
			document.getElementById("showthree").style.display="none";
			document.getElementById("showfoure").style.display="none";
			document.getElementById("showfive").style.display="none";
			document.getElementById("showsix").style.display="";
			
		}
		if(obj.value==2){
			document.getElementById("showone").style.display="none";
			document.getElementById("showsix").style.display="";
			document.getElementById("showtwo").style.display="";
			document.getElementById("showthree").style.display="";
			document.getElementById("showfoure").style.display="";
			document.getElementById("showfive").style.display="";
		}
		}		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="freezePlayer.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<c:out value="${playerName }"/>
				 	<input name="playerId" type="hidden" value="${playerId }" />
				 	<input name="playerName" type="hidden" value="${playerName }" />
				 </td>
			</tr>
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_r" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.freetimemodel"/>
				 </td>
				 <td class="t_border_r" style="border-bottom: 1px">
					<select name = "freeModel" onchange="change()">
						<option value="1"><bean:message bundle="pageResources" key="page.roleOperation.common.free"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.roleOperation.common.freez"/></option>
                    </select>
				 </td>
                <!-- 	
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.players"/>
					</span>
				</td>
				 -->
			</tr>
			<tr height="30px">
				 <td width="35%" class="t_border_r" align="right" rowspan="1" style="border: 1px"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.freezeTime"/>
				 </td>
 				<div id ="showsix">
				 <td class="t_border_r" align="left" colspan="1" >
                   <div id = "showone">
				 	<gmweb:createPunishTimeOption name="lastSecond" checkedValue="${requestScope.lastSecond}" />
                   </div>
				 </td>
          		</div>
			</tr>
			<tr height="30px">
				 <td class="t_border_r" align="right" style="border: 1px" colspan="1" >&nbsp<div id = "showfoure" style="display: none"><bean:message bundle="pageResources" key="page.common.startDate"/></div></td>
				 <td class="t_border_r" align="left"  colspan="1" >
                     <div id = "showtwo" style="display: none">
				 	<input name="beginDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
					</div>			 
				</td>
			</tr>
			<tr height="30px">
                <td class="t_border_r" align="right" style="border: 1px" colspan="1" >&nbsp<div id = "showfive" style="display: none"><bean:message bundle="pageResources" key="page.common.endDate"/></div></td>
				 <td class="t_border_r" align="left" style="border: 1px" colspan="1" >
					<div id = "showthree" style="display: none">
				 	<input name="endDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				    </div>
                 </td>
			</tr>	
			<tr height="30px">
				 <td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.freezeReason"/>
				 </td>
				 <td class="t_border_r" align="left">
				  	<textarea cols="35" rows="10" name="reason" ></textarea>
				  	<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.wordLimit"/>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.beginFreeze"/>" />
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>