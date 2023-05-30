<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<script type="text/javascript">
	
		function check(){
			if ( document.forms[0].activityId.value == "" || document.forms[0].activityId.value  == null){
				  alert('<bean:message bundle="pageResources" key="page.worldOperation.errors.activityId"/>');
				  document.forms[0].activityId.focus();
				  return false;
			}
			else {
				  return true;
			}
		}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="synchronizationActivity.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/>
				</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityId"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="srcActivityId" type="text" readonly value="${requestScope.activityId}" style="width:200px" /><br />
				 </td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" ><bean:message bundle="pageResources" key="page.worldOperation.addActivity.activityName"/>
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityName" type="text" readonly value="${requestScope.activityName}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.operProduct.sychro"/><bean:message bundle="pageResources" key="page.dictionary.game.gameName"/>： 
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="gameId" type="hidden" value="${requestScope.gameId}" style="width:200px" />
				 	<input name="gameName" type="text" readonly value="${requestScope.gameName}" style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.worldOperation.activityInfo.sychro"/>ID：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input name="activityId" type="text"  style="width:200px" />
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.submit2"/> " />&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" value=" <bean:message bundle="pageResources" key="page.worldOperation.common.back2"/> " onclick="history.back(1)" />
				</td>
			</tr>
		</table>
		</form>

	</body>
</html>