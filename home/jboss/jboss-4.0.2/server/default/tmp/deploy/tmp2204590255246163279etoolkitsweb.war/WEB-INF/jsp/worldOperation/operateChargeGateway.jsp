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
				var gatewayId = trim(document.getElementsByName("gatewayIdd")[0].value);				
				var gatewayZone = trim(document.getElementsByName("gatewayZone")[0].value);
				var gatewayName = trim(document.getElementsByName("gatewayName")[0].value);
				var gatewayCode = trim(document.getElementsByName("gatewayCode")[0].value);
				var gatewayPwd = trim(document.getElementsByName("gatewayPwd")[0].value);
				var gatewayIP = trim(document.getElementsByName("gatewayIP")[0].value);
				var gatewayMac = trim(document.getElementsByName("gatewayMac")[0].value);
				
				
				
				if(gatewayId.length <1 || gatewayZone.length <1 || gatewayName.length <1 || gatewayCode.length <1 || gatewayPwd.length <1 || gatewayIP.length <1 ||  gatewayMac <1 ){
					alert("<bean:message bundle="pageResources" key="page.common.errorMsgForNoInput"/>");
					return false;
				}
				
				if(gatewayName.length >32 ||gatewayCode.length >32 || gatewayPwd.length >32 ) {
					alert("<bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.maxLengthError"/>");
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

				//check the mac



				if (gatewayMac.length != 17)
				{
					alert("<bean:message bundle="pageResources" key="page.common.errorMAC"/>");
					return false;	
				}

				var LettersMAC = "ABCDEF1234567890";    			
     			for( i = 0; i < gatewayMac.length; i ++ )
     			{
          				c = gatewayMac.charAt( i );
						c = c.toUpperCase();

						if((i+1)%3 == 0 ){
							if(c !="-"){
								alert("<bean:message bundle="pageResources" key="page.common.errorMAC"/>");
								return false;
							}
						}

						if((i+1)%3 != 0 ){

							if (LettersMAC.indexOf(c) == -1) 
							{ 
								alert("<bean:message bundle="pageResources" key="page.common.errorMAC"/>");
								return false;
							}
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
		<form action="addOrUpdateChargeGateway.do" method="post" onsubmit="return validateChargeGatewayForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
        	<tr>
        		<td colspan="2" height="30px"></td>
        		&nbsp;&nbsp;
        	</tr>


			<!--open the Group Message -->
        	<c:if test="${requestScope.operType == 'open' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.openChargeGateway"/>
				
				<input type="hidden"  value="${requestScope.gatewayId}"/></td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayList.gatewayId} 
					
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.locatedDistrict"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayList.zoneId}-${requestScope.chargeGatewayZone}
					
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayList.gatewayName}
					
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessCode"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayCode}" readonly/> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessPwd"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayPassword}" readonly/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayIP"/></td>
				<td class="t_border_r">
					<input  type="text" size="40"  value="${requestScope.chargeGatewayList.gatewayIP}" readonly/> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayMAC"/></td>
				<td class="t_border_r">
					<input  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayMAC}" readonly/> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayState"/></td>
				<td class="t_border_r">&nbsp;&nbsp;
					
					<c:if test="${requestScope.chargeGatewayList.gatewayState==1}"><bean:message bundle="pageResources" key="page.common.available"/>
					</c:if>
					<c:if test="${requestScope.chargeGatewayList.gatewayState!=1}"><font color="red"><bean:message bundle="pageResources" key="page.common.unavailable"/></font>
					</c:if>
				</td>
			</tr>
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 
		
	
			<!--add a new Group Message -->
			
        	
        	<c:if test="${requestScope.operType == 'add' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.addChargeGateway"/>
				
				<input name="operType"  type="hidden" value="add" />
				</td>
				
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">
				<input name="gatewayIdd"  type="text"  size="40" value="" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.locatedDistrict"/></td>
				<td class="t_border_r" align="left">
					<select name="gatewayZone"  style="width:230px">
						<c:forEach items="${requestScope.gatewayZoneList}" var="gatewayZone">
				  			<option value="${gatewayZone.zoneId }">${gatewayZone.zoneId } - ${gatewayZone.zoneName}</option>
				  		</c:forEach>
					</select>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/></td>
				<td class="t_border_r">
					<input name="gatewayName"  type="text" size="40" value="" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessCode"/></td>
				<td class="t_border_r">
					<input name="gatewayCode"  type="text" size="40" value="" /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessPwd"/></td>
				<td class="t_border_r">
					<input name="gatewayPwd"  type="text" size="40" value="" /><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessPwdInputTips"/>
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayIP"/></td>
				<td class="t_border_r">
					<input name="gatewayIP"  type="text" size="40" value="" /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayMAC"/></td>
				<td class="t_border_r">
					<input name="gatewayMac"  type="text" size="40" value="" /><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayMACInputTips"/>
				</td>
			</tr>
					
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="add" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  onclick="return checkInput();"/>
					<input name="reset" type="reset" value="<bean:message bundle="pageResources" key="page.login.reset"/>"  />
					<input name="goback" type="button" value="<bean:message bundle="pageResources" key="page.tag.CreateCompenOperButtonTag.tag1"/>" onclick="javascript:history.go(-1);" />
				</td>
			</tr>
			</c:if> 


			<!--update the charge gateway   -->
        	<c:if test="${requestScope.operType == 'update' }">
			<tr>
				<td colspan="2" align="center" class="t_head"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.updateChargeGateway"/>
				<input name="operType"  type="hidden" value="update" />
				<input name="gatewayIdd"  type="hidden" value="${requestScope.chargeGatewayList.gatewayId}" />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayId2"/></td>
				<td class="t_border_r">&nbsp;&nbsp;${requestScope.chargeGatewayList.gatewayId} 					
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.locatedDistrict"/></td>
				<td class="t_border_r" align="left">${requestScope.groupMsgTitle} 
					<select name="gatewayZone" style="with:230px">
						<c:forEach items="${requestScope.gatewayZoneList}" var="gatewayZone">
							<c:if test="${gatewayZone.zoneId eq requestScope.chargeGatewayList.zoneId}" var="equalResult" scope="page">
								<option value="${gatewayZone.zoneId}" selected>${gatewayZone.zoneId}-${gatewayZone.zoneName}</option>
							</c:if>
							
							<c:if test="${ equalResult eq false}">
								<option value="${gatewayZone.zoneId}">${gatewayZone.zoneId}-${gatewayZone.zoneName}</option>
							</c:if>
							
						</c:forEach>
					</select>	
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.showPassportGateway.gatewayName"/></td>
				<td class="t_border_r">${requestScope.groupMsgTitle} 
					<input name="gatewayName"  type="text"  size="40" value="${requestScope.chargeGatewayList.gatewayName} " />
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessCode"/></td>
				<td class="t_border_r">
					<input name="gatewayCode"  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayCode} " /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.worldOperation.chargeGateway.gatewayAccessPwd"/></td>
				<td class="t_border_r">
					<input name="gatewayPwd"  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayPassword}" /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayIP"/></td>
				<td class="t_border_r">
					<input name="gatewayIP"  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayIP} " /> 
				</td>
			</tr>
			<tr height="30px">
				<td width="30%" align="right" class="t_border_l"><bean:message bundle="pageResources" key="page.common.gatewayMAC"/></td>
				<td class="t_border_r">
					<input name="gatewayMac"  type="text" size="40" value="${requestScope.chargeGatewayList.gatewayMAC}" /> 
				</td>
			</tr>
						
						
			<tr height="30px">
				<td colspan="2" align="center" class="t_border">
					<input name="update" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.common.submit2"/>"  onclick="return checkInput();"/>
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