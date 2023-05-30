<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
      <script type="text/javascript" src="js/calendar/WdatePicker.js"></script>
	<title>无标题文档</title>
	<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/jquery-1.3.2.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
				if(document.forms[0].accounts.value.trim() == "" || document.forms[0].accounts.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.error1"/>');
						document.forms[0].accounts.focus();
						return false;
				}else if ( document.forms[0].accounts.value.length > 100000){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.error4"/>');
						document.forms[0].accounts.focus();
						return false;
				}else if ( document.forms[0].reason.value.length > 512){
					  	alert('<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.error2"/>');
						document.forms[0].reason.focus();
						return false;
				}
				else {
					  return true;
				}
			}
			
		
		var remarks = new Array();
		remarks[0] = '<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byAcount"/>';
		remarks[1] = '<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byId"/>';
		
		function changeName(obj){
			document.getElementById("conditionText").innerHTML = obj.options[obj.selectedIndex].text+"：";
			var remark = document.getElementById("remark").innerHTML;
			if(obj.value == 1)document.getElementById("remark").innerHTML = remark.replaceAll(remarks[1],remarks[0]);
			else document.getElementById("remark").innerHTML = remark.replaceAll(remarks[0],remarks[1]);

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
	<form action="validateFastfreezeAccount.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX" colspan="3"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">
					<c:if test="${oper == 'freeze'}"><bean:message bundle="pageResources" key="page.roleOperation.queryFreezePlayer.title"/></c:if>
					<c:if test="${oper == 'unFreeze'}"><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.title"/></c:if>
				</td>
			</tr>
			<tr>
				<td  class="t_border_l" align="right">
					<bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.choiceType"/>
				</td>
				<td class="t_border_l">
					<select name="freezeType" onchange="changeName(this)" >
						<option value="1"<c:if test="${param.freezeType==1 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byAcount"/></option>
						<option value="2"<c:if test="${param.freezeType==2 }">selected</c:if>><bean:message bundle="pageResources" key="page.roleOperation.showUnFreezePlayer.byId"/></option>
					</select>
				</td>
				<td  class="t_border_r">&nbsp;</td>
			</tr>
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.playerName"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="accounts" rows=10 cols=35 size="10240" >${param.accounts }</textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.players"/>
					</span>
				</td>
            </tr>
			<c:if test="${oper == 'freeze'}">
             <tr height="30px">
				<td id="conditionText" width="25%" class="t_border_r" align="right"><bean:message bundle="pageResources" key="page.roleOperation.common.freetimemodel"/>
				 </td>
				 <td class="t_border_r" colspan="1" style="border-bottom: 1px">
					<select name = "freeModel" onchange="change()">
						<option value="1"><bean:message bundle="pageResources" key="page.roleOperation.common.free"/></option>
						<option value="2"><bean:message bundle="pageResources" key="page.roleOperation.common.freez"/></option>
                    </select>
				 </td>
				<td width="25%" class="t_border_r" style="border: 1px">&nbsp</td>
                <!-- 	
				 <td class="t_border_r" align="left">
					<span id="remark">
						<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.players"/>
					</span>
				</td>
				 -->
			</tr>	
            
			<tr height="30px">
				 <td width="35%" class="t_border_r" align="right" rowspan="1"><bean:message bundle="pageResources" key="page.roleOperation.freezePlayer.freezeTime"/>
				 </td>
 				<div id ="showsix">
				 <td class="t_border_r" align="left" colspan="1" style="border: 1px">
                   <div id = "showone">
				 	<gmweb:createPunishTimeOption name="lastSecond" checkedValue="${requestScope.lastSecond}" />
                   </div>
				 </td>
          		</div>
				<td class="t_border_r" style="border: 1px">&nbsp</td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" align="right">&nbsp<div id = "showfoure" style="display: none"><bean:message bundle="pageResources" key="page.common.startDate"/></div></td>			
				
				 <td class="t_border_r" align="left" style="border: 1px" colspan="1" >
                     <div id = "showtwo" style="display: none">
				 	<input name="beginDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.beginDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
					</div>			 
				</td>
                <td class="t_border_r" style="border: 1px">&nbsp</td>
				
			    
			</tr>
			<tr height="30px">
                <td class="t_border_r" align="right">&nbsp<div id = "showfive" style="display: none"><bean:message bundle="pageResources" key="page.common.endDate"/></div></td>
				
				 <td class="t_border_r" align="left" style="border:1px" colspan="1" >
					<div id = "showthree" style="display: none">
				 	<input name="endDate" type="text" style="width:200px" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${requestScope.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
				    </div>
                 </td>
				<td class="t_border_r" style="border: 1px">&nbsp</td>
				
	
			</tr>
           </c:if>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					<input type="hidden" name="oper" value="${oper }"/>
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.freezePlayers.next"/>" />
				</td>
			</tr>
		</table>
	</form>
	<div align="center">
		<font color="red" size="3px">${msg }</font>
	</div>
	
	</body>
</html>