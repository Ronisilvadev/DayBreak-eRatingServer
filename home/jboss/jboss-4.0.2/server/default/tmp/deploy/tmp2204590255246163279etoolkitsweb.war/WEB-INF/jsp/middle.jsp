<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<STYLE>.navPoint {
	FONT-SIZE: 7pt; 
	CURSOR: pointer; 
	FONT-FAMILY: Webdings;
}
P {
	FONT-SIZE: 7pt;
}
</STYLE>
		<title>linekong</title>
	</head>
<SCRIPT>
function switchBar(){
	if (document.getElementById("switchPoint").innerText==7){
		document.getElementById("switchPoint").innerText=8
		document.getElementById("leftTd").style.display="none"
	}
	else{
		document.getElementById("switchPoint").innerText=7
		document.getElementById("leftTd").style.display=""
	}
}

 function switchTopBar(){
    var topWindow = parent.frames["topFrame"];
	if (document.getElementById("switchTopPoint").innerText==5){
		topWindow.document.getElementById("topTbl").style.display="none"
		topWindow.document.getElementById("topTd").style.display="none";
		topWindow.document.getElementById("welcome").style.display="";
		window.top.document.getElementById("fsMain").rows = "25,*";
		document.getElementById("switchTopPoint").innerText=6;
	}
	else{
		window.top.document.getElementById("fsMain").rows = "100,*,30";
		topWindow.document.getElementById("topTbl").style.display=""
		topWindow.document.getElementById("topTd").style.display="";
		topWindow.document.getElementById("welcome").style.display="none";
		document.getElementById("switchTopPoint").innerText=5;
	}
}

  function resizeMenuFrame() {
    if (event.clientX > 100 && event.clientX < 300) {
      leftTd.width = event.clientX;
    }
  }
</SCRIPT>

	<BODY leftmargin="0" topmargin="0" style="MARGIN: 0px" scroll=no>
		<TABLE cellSpacing=0 cellPadding=0 width="1024px" height="100%" border=0 align="center">
			<tr><!-- left_menu -->
				 <td id="leftTd" name="leftTd" align="center" vAlign=top noWrap width=211 rowspan="2">
					<IFRAME id="frmLeft" name="frmLeft" 
						style="Z-INDEX: 2; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%"
                   		 src="showFrame.do?method=showLeft" frameBorder=0
                    	 scrolling="auto" resizeable="yes" noWrap marginwidth="0" marginheight="0">
		   			</IFRAME>
				</td>
				<!-- middle_switch_bar -->

				<td bgColor="#E3EDF6" width="3" style="WIDTH: 1pt;cursor:e-resize" ondrag="resizeMenuFrame();" valign=top rowspan="2">
        			<font font-size:7pt>
          				<SPAN class=navPoint id=switchTopPoint onclick="switchTopBar();">5
          				</SPAN>
          			</FONT><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
          			<font font-size:7pt>
          				<SPAN class=navPoint id=switchPoint onclick="switchBar();">7
          				</SPAN>
          			</FONT>
          		</td>
				
				<td height="30">
					<iframe style="Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" src="showFrame.do?method=showTab" frameBorder=0 resizeable="yes" scrolling="auto"></iframe>
				</td>
				
			</tr>
			<tr>
				<!-- right_content -->
				
				<td vAlign=top width="100%" height="400">
					<iframe id=frmRight style="Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%" name=frmRight src="showFrame.do?method=showWelcome" frameBorder=0 resizeable="yes" scrolling="auto"></iframe>
				</td>
			</tr>
				
		</TABLE>
	</body>
</html>
