<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<html:javascript formName="/playerNames2Ids"/>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript" src="js/jquery-1.2.pack.js"></script>
	<script type="text/javascript">		
		var remarks = new Array();
		remarks[0] = '<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byAcount"/>';
		remarks[1] = '<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byId"/>';
		remarks[2] = '<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byRoleId"/>';
		
		function changeName(obj){
			document.getElementById("conditionText").innerHTML = obj.options[obj.selectedIndex].text+"：";
			var remark = document.getElementById("remark").innerHTML;
			if(obj.value == 1) {				
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[1],remarks[0]);
				remark = document.getElementById("remark").innerHTML;
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[2],remarks[0]);
			} else if(obj.value == 2) {
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[0],remarks[1]);
				remark = document.getElementById("remark").innerHTML;
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[2],remarks[1]);				
			} else {
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[0],remarks[2]);
				remark = document.getElementById("remark").innerHTML;
				document.getElementById("remark").innerHTML = remark.replaceAll(remarks[1],remarks[2]);	
			}
		}		
	</script>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.playerInfoList }">
		<html:form action="playerNames2Ids.do" method="post" onsubmit="return validatePlayerNames2IdsForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3"><bean:message bundle="pageResources" key="page.playerQuery.playerNames2Ids.title"/></td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.playerQuery.playerNames2Ids.queryType"/>
				 </td>
				 <td class="t_border_l" align="left" >
					<select name="queryType" onchange="changeName(this)">
						<option value="1"><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byAcount"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byId"/></option>
						<option value="3"><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byRoleId"/></option>
					</select>
				 </td>
				 <td class="t_border_r" align="left">
					&nbsp;
				</td>
			</tr>			
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>：
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="playerNames" rows=10 cols=35 size="10240" ></textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.playerQuery.playerNames2Ids.addRemark"/>
					</span> 
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.playerInfoList }">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr height="30px">
				<td colspan="2" align="center" ></td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.common.queryResult"/></td>
			</tr>
			<tr height="23px" class="h_CDE4F6">
				<td align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.playerPassport"/></td>
				<c:choose>				
				<c:when test="${queryType == 3}">
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.roleID"/></td>
				</c:when>
				<c:otherwise>
				<td align="center" class="t_border_r"><bean:message bundle="pageResources" key="page.common.playerID"/></td>
				</c:otherwise>
				</c:choose>
			</tr>
		<c:forEach items="${requestScope.playerInfoList}" var="playerInfo">
			<tr height="23px">
					<td align="center" class="t_border_l">
						<c:if test="${playerInfo.playerName == null}">
							<font color="red"><bean:message bundle="pageResources" key="page.common.unbeknownPassport"/></font>
						</c:if>
						<c:if test="${playerInfo.playerName != null}">
							<c:out value="${playerInfo.playerName } "/>
						</c:if>
					</td>
					<td align="center" class="t_border_r">
						<c:if test="${playerInfo.playerId == 0}">
							<font color="red"><bean:message bundle="pageResources" key="page.common.unbeknownPassport"/></font>
						</c:if>
						<c:if test="${playerInfo.playerId != 0}">
							${playerInfo.playerId } 
						</c:if>
					</td>
				</tr>
		</c:forEach>
		<tr height="30px">
			  	<td colspan="2" align="center" class="border_top">&nbsp;&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<div align="center">
			<input type="button" onclick="window.location.href='showPlayerNames2Ids.do'" value="<bean:message bundle="pageResources" key="page.common.back"/>"/>
		</div>
	</c:if>
	</body>
</html>