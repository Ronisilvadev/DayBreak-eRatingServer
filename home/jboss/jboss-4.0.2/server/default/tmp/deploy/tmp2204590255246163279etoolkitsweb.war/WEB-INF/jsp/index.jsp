<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ include file="inc/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title><bean:message bundle="pageResources" key="page.login.title"/></title>
		
	<script language="javascript">
	function maximizeWindow( ) {
		var offset = (navigator.userAgent.indexOf("Mac") != -1 ||
					   navigator.userAgent.indexOf("Gecko") != -1 ||
					   navigator.appName.indexOf("Netscape") != -1) ? 0 : 4;
		window.moveTo(-offset, -offset);
		window.resizeTo(screen.availWidth + (2 * offset),
					    screen.availHeight + (2 * offset));
	}
	//最大化当前窗口
	//maximizeWindow();
</script>
	</head>

	<frameset id="fsMain" name="fsMain" rows="100,*,30" framespacing="0" frameborder="no" border="0" scrolling="auto">
 	 	<frame src="showFrame.do?method=showTop" name="topFrame" scrolling="NO" noresize>
  		<frame src="showFrame.do?method=showMiddle" name="middleFrame" scrolling="auto" noresize>
  		<frame src="showFrame.do?method=showBottom" name="bottomFrame" scrolling="NO" noresize>
	</frameset>
	
<noframes>
<body>

</body>
</noframes>
</html>
