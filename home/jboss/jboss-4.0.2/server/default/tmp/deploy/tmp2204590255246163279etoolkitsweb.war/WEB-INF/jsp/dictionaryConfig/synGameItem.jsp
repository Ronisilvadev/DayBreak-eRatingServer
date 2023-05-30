<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
    
    <title></title>
    <link href="css/main.css" rel="stylesheet" type="text/css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<script type="text/javascript">
		function onValuechange (evt){
				evt=evt?evt:(window.event?window.event:null);
			var select = document.getElementById("targetGameId") ;
			document.getElementById('submit').disabled= select.selectedIndex < 0 ;
		}
	</script>
  </head>
  
  <body bgcolor="#ffffff">
  	<c:if test="${not empty games}">
  	<form action="synGameItem.do" method="post">
  	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  		
			<tr height="30px">
				<td colspan="3" align="center"></td>
			</tr>
			<tr>
				<td colspan="3" align="center" class="t_head">
					<bean:message bundle="pageResources" key="page.dictionaryConfig.gatewayConfig.title"/>
				</td>
			</tr>
			<tr height="23px" >
				<td width="33%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.dictionary.synGameItem.currentGame"/></td>
				<td align="center" class="t_border_l">${current.gameName }</td>
				<td align="center" class="t_border_r">&nbsp;</td>
			</tr>
			<tr height="60px" >
				<td width="33%" align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.dictionary.synGameItem.pleaseSelectGames"/>
				</td>
				<td align="center" class="t_border_l">
					<select id="targetGameId" name="targetGameId" multiple="multiple" style="height: 60px;" onchange="onValuechange(event);" >
						<c:forEach items="${games}" var="targetGame">
							<option value="${targetGame.gameId }">${targetGame.gameId } - ${targetGame.gameName }</option>
						</c:forEach>
					</select> 
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.dictionary.synGameItem.tip"/>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="3" align="center" class="t_border">
					<input id="submit" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" disabled="disabled"/>
				</td>
			</tr>
		
   	</table>
   	</form>
   	</c:if>
   	<br />
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
  </body>
</html>
