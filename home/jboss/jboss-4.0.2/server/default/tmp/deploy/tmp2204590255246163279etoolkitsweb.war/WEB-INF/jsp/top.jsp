<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<STYLE>
.navPoint {
	FONT-SIZE: 13pt; 
	CURSOR: pointer; 
	FONT-FAMILY: Webdings;
	padding-left:0px;
}

.navPoint2 {
	FONT-SIZE: 15pt; 
	CURSOR: pointer; 
	FONT-FAMILY: Webdings;
	padding-left:0px;
	padding-right:0px;
	padding-bottom:0px;
	margin:0px;
	
}
.cursorHand {
 cursor:pointer;
 }
</STYLE>
<link href="css/main.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>top</title>
<script language="JavaScript1.2">
   
   function switchBar(){
	if (document.getElementById("switchPoint").innerText==5){
		document.getElementById("topTbl").style.display="none"
		document.getElementById("topTd").style.display="none";
		document.getElementById("welcome").style.display="";
		window.top.document.getElementById("fsMain").rows = "25,*";
		document.getElementById("switchPoint").innerText=6;
	}
	else{
		window.top.document.getElementById("fsMain").rows = "100,*,30";
		document.getElementById("topTbl").style.display=""
		document.getElementById("topTd").style.display="";
		document.getElementById("welcome").style.display="";
		document.getElementById("switchPoint").innerText=5;
	}
}
</script>
</head>

<body>
<center>
<img style="display:none" src="images/login/${bannerName }" onerror="javascript:document.getElementById('topTbl').background='images/login/banner.jpg';" />
<table id="topTbl" width="1024px" border="0" cellspacing="0" cellpadding="0"  background="images/login/${bannerName }">
	<tr>
	    <td width="1100px" id="topTd" valign="bottom"  height="105">
		</td>
	</tr>
</table>
<div id="welcome" style="background:url(images/login/head.jpg) repeat-x; padding-left:30px;padding-top:2px;padding-bottom:2px" align="left" >
		<bean:message bundle="pageResources" key="page.tpo.welcome"/> <b>${sessionScope.userInfo.passportName}</b> <bean:message bundle="pageResources" key="page.tpo.useSystem"/>	
</div> 
</center>
</body>
</html>
