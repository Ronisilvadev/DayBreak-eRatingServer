<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script language="javascript">
			
			
			function checkInput(){
				var gatewayId = trim(document.getElementsByName("gatewayId")[0].value);				
				var gatewayType = trim(document.getElementsByName("gatewayType")[0].value);				
				var gatewayCode = trim(document.getElementsByName("gatewayCode")[0].value);
				var gatewayPwd = trim(document.getElementsByName("gatewayPassword")[0].value);
				var gatewayIP = trim(document.getElementsByName("gatewayIP")[0].value);
				var gatewayPort = trim(document.getElementsByName("gatewayPort")[0].value);
				
				
				
				if(gatewayId.length <1 || gatewayType.length <1 ||  gatewayCode.length <1 || gatewayPwd.length <1 || gatewayIP.length <1 ||  gatewayPort <1 ){
					alert("<bean:message bundle="pageResources" key="page.common.errorMsgForNoInput"/>");
					return false;
				}
				
				if(gatewayCode.length >32 || gatewayPwd.length >32 ) {
					alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.maxLengthError"/>");
					return false;
				}

				//check the id				
				if(gatewayId.length >6 ) {
					alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.errorGatewayId"/>");
					return false;
				}
				var Letters = "1234567890";
    			var i;
     			var c;
     			for( i = 0; i < gatewayId.length; i ++ )
     				{
          				c = gatewayId.charAt( i );
       					if (Letters.indexOf( c ) ==-1)
       					{
       						alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.errorGatewayId"/>");
        					return false;
       					}
     			}			


				//check the password
				var LettersNumber = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    			var i;
     			var c;
     			for( i = 0; i < gatewayPwd.length; i ++ )
     				{
          				c = gatewayPwd.charAt( i );
						c = c.toUpperCase();
       					if (LettersNumber.indexOf( c ) ==-1)
       					{
       						alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.errorPassword"/>");
        					return false;
       					}
     			}

				

				//check the ip
				var iplength = gatewayIP.length; 
				var LettersIP = "1234567890."; 
				for (i=0; i < iplength; i++) 
				{ 
					 c = gatewayIP.charAt(i); 
					 if (LettersIP.indexOf(c) == -1) 
					{ 
						alert("<bean:message bundle="pageResources" key="page.common.errorIPAddress"/>");
						return false;
					} 
				}
				var cutCount = 0;
				var str1 =""; var str2=""; var str3=""; var str4="";
				var firstcut = 0; var secondcut = 0; var thirdcut = 0;

				for (i = 0;i<iplength;i++) 
				(gatewayIP.substr(i,1)==".")?cutCount++:cutCount; 
				if(cutCount!=3){
					alert("<bean:message bundle="pageResources" key="page.common.errorIPAddress"/>");
					return false;
				}

				firstcut = gatewayIP.indexOf("."); 
				thirdcut = gatewayIP.lastIndexOf("."); 

				var subip = gatewayIP.substring(0,thirdcut); 				
				secondcut = subip.lastIndexOf("."); 

				str1 = gatewayIP.substring(0,firstcut);
				str2 = gatewayIP.substring(firstcut+1,secondcut);
				str3 = gatewayIP.substring(secondcut+1,thirdcut);
				str4 = gatewayIP.substring(thirdcut+1,iplength);

				
				if (str1=="" || str2=="" ||str3== "" ||str4 == ""){
					alert("<bean:message bundle="pageResources" key="page.common.errorIPAddress"/>");
					return false;
				}
				if (str1< 0 || str1 >255 || str2< 0 || str2 >255 || str3< 0 || str3 >255 || str4< 0 || str4 >255 ){
					alert("<bean:message bundle="pageResources" key="page.common.errorIPAddress"/>");
					return false;
				}




				//check the port				
				if(gatewayPort.length >6 || gatewayPort>65535 || gatewayPort<1) {
					alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.errorGatewayPort"/>");
					return false;
				}
				var Letters = "1234567890";
    			var i;
     			var c;
     			for( i = 0; i < gatewayPort.length; i ++ )
     				{
          				c = gatewayPort.charAt( i );
       					if (Letters.indexOf( c ) ==-1)
       					{
       						alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.errorGatewayPort"/>");
        					return false;
       					}
     			}
				
				return true;				
			}
			function trim(str) {
  				return str.replace(/(^\s+)|(\s+$)/g, "");
			}
			
			

			
		</script>
		
	</head>

	<body bgcolor="#ffffff">
		<form action="addOrUpdateChargeGatewayConfig.do" method="post" onsubmit="return validateChargeGatewayConfigForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        		&nbsp;&nbsp;
        	</tr>


			<!--open the Group Message -->
        	<c:if test="${requestScope.operType == 'open' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.openGatewayConfig"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayConfig.gatewayId} 
				
					<input  type="hidden"   value="${requestScope.chargeGatewayConfig.gatewayId} " />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configType"/></td>
				<td class="t_border_r"> &nbsp;					
					<c:forEach items="${requestScope.gatewayTypeList}" var="gatewayTypeDict" varStatus="recordRank">
				  			<c:if test="${gatewayTypeDict.opValue eq requestScope.chargeGatewayConfig.gatewayType}">
				  				${gatewayTypeDict.opText}
							</c:if>
				  	</c:forEach>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessCode"/></td>
				<td class="t_border_r"> 
					<input   type="text"  size="40"  value="${requestScope.chargeGatewayConfig.gatewayCode} "  readonly/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessPwd"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayPassword}" /> 
				</td>
			</tr>			
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configIP"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayIP} " /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configPort"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayPort}" /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configState"/></td>
				<td class="t_border_r">&nbsp;&nbsp;
					
					<c:if test="${requestScope.chargeGatewayConfig.gatewayState<=3}"><bean:message bundle="pageResources" key="page.common.available"/>
					</c:if>
					<c:if test="${requestScope.chargeGatewayConfig.gatewayState == 4}"><font color="red"><bean:message bundle="pageResources" key="page.common.unavailable"/></font>
					</c:if>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 
		
	
			<!--add a new Group Message -->
			
        	
        	<c:if test="${requestScope.operType == 'add' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.addGatewayConfig"/>
				<input name="operType"  type="hidden" value="add" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">
					&nbsp;&nbsp;${requestScope.gatewayId}
					<input name="gatewayId"  type="hidden"   value="${requestScope.gatewayId}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configType"/></td>
				<td class="t_border_r" align="left">
					<select name="gatewayType"  style="width:200px">						
				  		<c:forEach items="${requestScope.gatewayTypeList}" var="gatewayTypeDict" varStatus="recordRank">
				  			<option value="${gatewayTypeDict.opValue}">${gatewayTypeDict.opText}</option>
				  		</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessCode"/></td>
				<td class="t_border_r">
					<input name="gatewayCode"  type="text"   value="gw${requestScope.gatewayId}" style="width:200px"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessPwd"/></td>
				<td class="t_border_r">
					<input name="gatewayPassword"  type="text" size="40" value="${requestScope.chargeGateway.gatewayPassword}" /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configIP"/></td>
				<td class="t_border_r">
					<input name="gatewayIP"  type="text" size="40" value="" /> 
				</td>
			</tr>			
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configPort"/></td>
				<td class="t_border_r">
					<input name="gatewayPort"  type="text" size="40" value="" /> 
				</td>
			</tr>			
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  onclick="return checkInput();" />
					<input name="reset" type="reset" value="<bean:message bundle="pageResources" key="page.login.reset"/>"  />
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 


			<!--update the charge gateway   -->
        	<c:if test="${requestScope.operType == 'update' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.updateGatewayConfig"/>
				
				<input name="operType"  type="hidden" value="update" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayConfig.gatewayId} 
					<input name="gatewayId"  type="hidden"   value="${requestScope.chargeGatewayConfig.gatewayId}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configType"/></td>
				<td class="t_border_r"> &nbsp;
					<c:forEach items="${requestScope.gatewayTypeList}" var="gatewayTypeDict" varStatus="recordRank">
				  			<c:if test="${gatewayTypeDict.opValue eq requestScope.chargeGatewayConfig.gatewayType}">
				  				${gatewayTypeDict.opText}
							</c:if>
				  	</c:forEach>
					<input name="gatewayType"  type="hidden"   value="${requestScope.chargeGatewayConfig.gatewayType}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessCode"/></td>
				<td class="t_border_r">
					<input name="gatewayCode"  type="text" size="40"  value="${requestScope.chargeGatewayConfig.gatewayCode}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configAccessPwd"/></td>
				<td class="t_border_r">
					<input name="gatewayPassword"  type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayPassword}" /> 
				</td>
			</tr>			
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configIP"/></td>
				<td class="t_border_r">
					<input name="gatewayIP" type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayIP} " /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGatewayConfig.configPort"/></td>
				<td class="t_border_r">
					<input name="gatewayPort" type="text" size="40" value="${requestScope.chargeGatewayConfig.gatewayPort}" /> 
				</td>
			</tr>			
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  onclick="return checkInput();" />
					<input name="reset" type="reset" value="<bean:message bundle="pageResources" key="page.login.reset"/>"  />
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if>
		</table>
	</form>
	<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg}</font>
		</div>
	</body>
</html>