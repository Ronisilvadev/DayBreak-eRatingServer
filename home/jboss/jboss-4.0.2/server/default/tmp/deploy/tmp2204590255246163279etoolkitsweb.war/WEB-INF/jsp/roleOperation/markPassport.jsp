<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript" src="js/common.js"></script>
	<script type="text/javascript">
		String.prototype.trim=function(){ 
			return this.replace(/(^\s*)|(\s*$)/g, ""); 
		} 
		function check(){
				if(document.forms[0].strPassportList.value.trim() == "" || document.forms[0].strPassportList.value.trim()  == null){
						alert('<bean:message bundle="pageResources" key="page.roleOperation.markPassport.errorBlankInput"/>');
						document.forms[0].strPassportList.focus();
						return false;
				}else if ( document.forms[0].strPassportList.value.length > 100000){
					  	alert('<bean:message bundle="pageResources" key="page.common.errorExcessiveInput"/>');
						document.forms[0].strPassportList.focus();
						return false;
				}
				else {
					  return true;
				}
			}
	
		
		function copyToClipBoard(){ 
		
			var clipBoardContent=document.getElementById("strInvalidPassportList").value.trim(); 
			
			window.clipboardData.setData("Text",clipBoardContent); 
		} 	
		function copyValidPassportToClipBoard(){ 
		
			var clipBoardContent2=document.getElementById("strValidPassportList").value.trim(); 
			
			window.clipboardData.setData("Text",clipBoardContent2); 
		} 	
		function changeOperType(object){		
			
			var strType = object.value;			
			var url;			
			url = "showMarkPassport.do?type="+strType;		
			window.location.href = url;
		}
		
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="markPassport.do" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="3" align="center" height="30PX"></td>
			</tr>
		
			<tr>
				<td align="center" class="t_head" colspan="3">
							
							
							
							<c:if test="${requestScope.type==1}">
								<bean:message bundle="pageResources" key="page.roleOperation.markPassport.batchMark"/>
							</c:if >
							<c:if test="${requestScope.type==2}">
								<bean:message bundle="pageResources" key="page.roleOperation.markPassport.batchUnmark"/>
							</c:if >
				</td>
			</tr>
			<tr>
				<td id="conditionText" width="25%" class="t_border_l" align="right">					
                   
                   	<bean:message bundle="pageResources" key="page.roleOperation.markPassport.chooseType"/>
				 </td>
				<td  class="t_border_r" colspan="1" align="left">
					<select name="type" style="width:150px;" onchange="changeOperType(this)">						
				  			<option value="1" 
				  			<c:if test="${requestScope.type==1}">
								selected
							</c:if >
				  			>
				  				<bean:message bundle="pageResources" key="page.roleOperation.markPassport.typeMark"/>
							</option>
				  			<option value="2" 
				  			<c:if test="${requestScope.type==2}">
								selected
							</c:if >
				  			><bean:message bundle="pageResources" key="page.roleOperation.markPassport.typeUnmark"/></option>				  			
				  		
				  	</select>
							
				</td>
				<td class="t_border_r" align="left">
					
				</td>
				
			</tr>
			
			
			<tr height="30px">
				<td id="conditionText" width="25%" class="t_border_l" align="right">
					
                    <bean:message bundle="pageResources" key="page.common.playerAccount"/>
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="strPassportList" rows=10 cols=35 size="10240"  >${requestScope.strPassportList}</textarea>
				 </td>
				 <td class="t_border_r" align="left">
					<span id="remark">
					
						<bean:message bundle="pageResources" key="page.roleOperation.markPassport.inputTips"/>
					</span>
				</td>
			</tr>
			<tr height="30px">
				<td class="t_border" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
					
							<c:if test="${requestScope.type==1}">
								<input name="query" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.markPassport.beginMark"/>"  />
							</c:if >
							<c:if test="${requestScope.type==2}">
								<input name="query" type="submit" value="<bean:message bundle="pageResources" key="page.roleOperation.markPassport.beginUnmark"/>"  />
							</c:if >					
				</td>				
			</tr>
			
			
			
		</table>
	</form>
	
	
	<c:if test="${not empty requestScope.passportList}">		
			<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td colspan="3" align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="4">
					<bean:message bundle="pageResources" key="page.roleOperation.markPassport.markResult"/>
				</td>
			</tr>
			
			<tr height="30px">
				<td id="conditionText" width="15%" class="t_border_l" align="center">
					<bean:message bundle="pageResources" key="page.common.rank"/>
				 </td>
				 <td class="t_border_l" align="center" cols=35>
				 	<bean:message bundle="pageResources" key="page.common.playerAccount"/>
				 </td>
				 <td class="t_border_l" align="center">
					<bean:message bundle="pageResources" key="page.roleOperation.markPassport.checkPassportValid"/>
				</td>
				<td class="t_border_r" align="center">
					<c:if test="${requestScope.type==2}"><bean:message bundle="pageResources" key="page.roleOperation.markPassport.cancel"/></c:if><bean:message bundle="pageResources" key="page.roleOperation.markPassport.checkMarkResult"/>
				</td>
			</tr>
			
			
		
			<c:forEach items="${requestScope.checkValidList}" var="result" varStatus="recordRank" >
				<tr height="23px" class="ffffff" onmouseover="this.className='EBE9E9'" onmouseout="this.className='ffffff'">
					<td id="conditionText" width="15%" class="t_border_l" align="center">${recordRank.index+1}</td>
					<td align="center" class="t_border_l">	${requestScope.passportList[recordRank.index]}</td>
					<td align="center" class="t_border_l">	
						<c:if test="${requestScope.checkValidList[recordRank.index]>0}">
							<bean:message bundle="pageResources" key="page.common.valid"/>
						</c:if>
						<c:if test="${requestScope.checkValidList[recordRank.index] eq 0}">
							<font color="red">	
								<bean:message bundle="pageResources" key="page.common.invalid"/>
							</font>
						</c:if>
					</td>
					<td align="center" class="t_border_r">	&nbsp;
					
					<c:if test="${requestScope.checkValidList[recordRank.index]>0}">
						
						<c:if test="${requestScope.checkResult>0}">
							<bean:message bundle="pageResources" key="page.roleOperation.markPassport.markSuccess"/>
						</c:if>
						
						<c:if test="${requestScope.checkResult<=0}">
							<font color="red">
								<bean:message bundle="pageResources" key="page.roleOperation.markPassport.markFailure"/>
							</font>
						</c:if>
						
					</c:if>
					
					
					</td>
				</tr>			
			</c:forEach>
			<tr height="23px">
				<td class="t_border" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="4">
					<input type="hidden" id="strInvalidPassportList" value="${requestScope.strInvalidList}"  />
					<input type="hidden" id="strValidPassportList" value="${requestScope.strValidList}"  />
					
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.markPassport.copyValidPassportToClipBoard"/>" onclick="copyValidPassportToClipBoard();" />
					
					
					<input type="button" value="<bean:message bundle="pageResources" key="page.roleOperation.markPassport.copyInvalidPassportToClipBoard"/>" onclick="copyToClipBoard();" />
					
				
				</td>
			</tr>
			<tr height="23px">
				<td class="t_border" style="border-bottom:#AEAEB0 1px solid;" align="center"  colspan="3">
				
				
				</td>
			</tr>
			
		</table>	
		
		
		
	</c:if>
	
	<div align="center">
			
			<font color="red" size="3px">${msg}</font>
	</div>
	
	</body>
</html>