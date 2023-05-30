<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
  <head>
 		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<link rel="stylesheet" href="../css/common.css" type="text/css" />
	<style type="text/css">
	.zxx_list_title{background:#eeeeee; border:1px solid #cccccc; padding:1em;}
	.zxx_list_content{padding:1em;}
	#tinybox{position:absolute; display:none; padding:10px; background:#ffffff url(images/preload.gif) no-repeat 50% 50%; border:10px solid #e3e3e3; z-index:2000;}
	#tinymask{position:absolute; display:none; top:0; left:0; height:100%; width:100%; background:#000000; z-index:1500;}
	#tinycontent{background:#ffffff; font-size:1.1em;}
	</style>
		<script type="text/javascript" src="js/jquery-1.2.pack.js"></script>
		<script type="text/javascript" src="js/tinybox.js"></script>
		<script type="text/javaScript">
			function showdiv(optionName,optionCode,optionValue){
				$.ajax({
 					type: "POST",
 					url: "showConfigOptionInfo.do",
 					data:   "option_code="+optionCode,
 					dataType:   "xml", 
 					success: function(data){
 						 	var options = data.getElementsByTagName("option") ;
 						 	var content="<table width=\"200px\" height=\"150px\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">" ;
 						 	content=content+"<tr height=\"23px\"><td align=\"center\" class=\"t_border_l\">"+"<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionCode"/></td>" ;
 						 	content=content+"<td align=\"center\" class=\"t_border_r\">"+optionCode+"</td></tr>" ;
 						 	content=content+"<tr height=\"23px\"><td align=\"center\" class=\"t_border_l\">"+"<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionName"/></td>" ;
 						 	content=content+"<td align=\"center\" class=\"t_border_r\">"+optionName+"</td></tr>" ;
 						 	content=content+"<tr height=\"23px\"><td align=\"center\" class=\"t_border_l\">"+"<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionValue"/></td>" ;
 						 	content=content+"<td align=\"center\" class=\"t_border_r\"><select name=\"optionValue\" id=\"optionValue\"> " ;
 						 	for(var i=0;i<options.length ;i++ ){
 						 		var str = options[i].text ;
 						 		content=content+"<option value=\""+str.substring(0,str.indexOf(","))+"\"" ;
 						 		if(str.substring(0,str.indexOf(","))==optionValue) {
 						 			content=content+" selected" ;
 						 		}
 						 		content=content +">"+str.substring(str.indexOf(",")+1,str.length)+"</option>" ;
 						 	} 
 						 	content=content+"</select></td></tr>" ;
 						 	content=content+"<tr height=\"23px\"><td align=\"center\" class=\"t_border_r\" colspan=\"2\"><input type=\"button\" value=\"<bean:message bundle="pageResources" key="page.common.submit"/>\" onclick=\"updateCodeValue('"+optionCode+"','"+optionName+"',document.getElementById('optionValue').value,document.getElementById('optionValue').options[document.getElementById('optionValue').selectedIndex].innerText);\"/>&nbsp;&nbsp;&nbsp;<input type=\"button\" value=\"<bean:message bundle="pageResources" key="page.common.back"/>\" onclick=\"TINY.box.hide();\"/>"
 						 	content=content+"</td></tr></table>" ;
 						 	TINY.box.show(content,0,0,0,1)	;
					}, 
					error:function (request,str,exp){
						TINY.box.show(str,0,0,0,0,2)	;
					}
				}); 
			}
			
			function updateCodeValue(optionCode,optionName,optionValue,optionText){
				$.ajax({
 					type: "POST",
 					url: "updateConfigOptionInfo.do",
 					data:   "option_code="+optionCode+"&option_value="+optionValue+"&option_name="+optionName,
 					dataType:   "xml", 
 					success: function(data){
 						//修改成功
 						if(data.getElementsByTagName("message")[0].firstChild.nodeValue == '1'){
							var tbody = document.getElementById("tablebody") ;
 							var datarows = tbody.rows ;
 							for(var idx = 0 ; idx< datarows.length ; idx++){
 								if(datarows[idx].cells[0].innerText==optionCode){
 									datarows[idx].cells[2].innerText = optionText ;
 									break ;
 								}
 							}
 							TINY.box.psh("<bean:message bundle="pageResources" key="page.configOption.showConfigOption.updateSucess"/>" ,0,0,1) ;
 							setTimeout(function(){TINY.box.hide()},1000) ;	
 						}else{
							TINY.box.psh("<bean:message bundle="pageResources" key="page.configOption.showConfigOption.updateFailer"/>" ,0,0,1) ;
							setTimeout("TINY.box.hide()",1000) ; 								
 						}
 					}, 
					error:function (request,str,exp){
						TINY.box.psh("<bean:message bundle="pageResources" key="page.configOption.showConfigOption.updateFailer"/>&nbsp;"+str ,0,0,1) ;
						setTimeout("TINY.box.hide()",1000) ;
					}
 				});
			}
		</script>
  </head>
  <body bgcolor="#ffffff">
   		<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
			<thead>
					<tr height="30px">
						<td colspan="4" align="center"></td>
					</tr>
					<tr>
						<td colspan="4" align="center" class="t_head">
							<bean:message bundle="pageResources" key="page.configOption.showConfigOption.title"/>
						</td>
					</tr>
					<tr height="23px" class="h_CDE4F6">
						<td align="center" class="t_border_l">
							<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionCode"/>
						</td>
						<td align="center" class="t_border_l">
							<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionName"/>
						</td>
						<td align="center" class="t_border_l">
							<bean:message bundle="pageResources" key="page.configOption.showConfigOption.optionValue"/>
						</td>
						
						<td align="center" class="t_border_r">
							<bean:message bundle="pageResources" key="page.common.operation"/>
						</td>
					</tr>
					</thead>
				<tbody id="tablebody">
				<c:if test="${not empty requestScope.configs }">
				<c:forEach items="${requestScope.configs}" var="configOption" varStatus="status">
					<tr height="23px">
						<td width="10%" align="center" class="t_border_l" <c:if test="${status.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>${configOption.optionCode }</td>
						<td align="center" class="t_border_l" <c:if test="${status.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
							${configOption.optionName }
						</td>
						<td align="center" class="t_border_l" <c:if test="${status.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
							${configOption.valueDescription }
						</td>
						<td align="center" class="t_border_r" <c:if test="${status.last }">style="border-bottom:#AEAEB0 1px solid;"</c:if>>
							<a href="javascript:showdiv('${configOption.optionName }','${configOption.optionCode }','${configOption.optionValue}');" ><bean:message bundle="pageResources" key="page.common.modify"/></a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				</tbody>
			<!-- 	<tr><td colspan="4" class="t_border_r" style="border-bottom:#AEAEB0 1px solid;">&nbsp;</td></tr> -->
		</table>
  </body>
</html>
