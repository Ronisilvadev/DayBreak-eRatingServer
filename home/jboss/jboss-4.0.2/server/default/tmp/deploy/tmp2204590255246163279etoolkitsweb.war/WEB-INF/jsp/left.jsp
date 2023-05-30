<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link href="css/main.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="css/jbar.css" type="text/css" />
		<script type="text/javascript" src="js/jquery-1.2.pack.js"></script>
		<script type="text/javascript" src="js/jbar.js"></script>
		<title></title>
	<script language="JavaScript1.2">
	<!--
	function logOut(){
	  if(confirm('<bean:message bundle="pageResources" key="page.left.logOutInfo"/>')){
		  window.top.location.href = "login.do?method=logout";
	  }else{
		  return false;
	  }
	}
	
	function disableRightMenu() {
  	self.event.returnValue=false;
	}
	//document.oncontextmenu=disableRightMenu;
	//-->
   </script>
	</head>

<body style="MARGIN: 0px;"> 
<div id="eM_menu" style="background:#CFEBFF;height:449px">
	<div class="menubar">
		<div class="title">
			<a href="showFrame.do?method=showWelcome" class="menuLink" target="frmRight">
				<b><bean:message bundle="pageResources" key="page.left.showWelcome"/></b>
			</a>
		</div>
					
		<div class="menu_bk">
			<div class="toolbar" style="background:url('images/menu_header.jpg') no-repeat;height:24px;font-size:13px;padding:15px 0px 0px 75px;">
				<a href="#" class="menu_expand"><bean:message bundle="pageResources" key="page.left.expand"/></a>　　
				<a href="#" class="menu_collapse"><bean:message bundle="pageResources" key="page.left.collapse"/></a>							
			</div>
			
			<c:if test="${not empty requestScope.roleResourceList }">
				<c:forEach items="${requestScope.roleResourceList}" var="resourceInfo">
					<c:if test="${resourceInfo.resPid == 0 }">
					<c:if test="${resourceInfo.resType == 0 }">
						<div class="menu_head open" id="menu1" align="center">
							<bean:message bundle="menuResources" key="${resourceInfo.resName }"/>
						</div>
						<ul id="menu1_content" class="menu_body show">
							<c:forEach items="${requestScope.roleResourceList}" var="resourceInfo2">
								<c:if test="${resourceInfo2.resPid == resourceInfo.resId }">
									<c:if test="${resourceInfo2.resType == 1 }">
										<li>
											<img src="images/ecard_r9_c7.jpg"/>&nbsp;
											<a href="${resourceInfo2.resUrl}" target="frmRight">
												<bean:message bundle="menuResources" key="${resourceInfo2.resName }"/>
											</a>
										</li>
									</c:if>
									<c:if test="${resourceInfo2.resType == 0 }">
										<div class="sub_head">
											<img src="images/ecard_r9_c7.jpg"/>&nbsp;
											<bean:message bundle="menuResources" key="${resourceInfo2.resName }"/>
										</div>
									
										<div class="sub_body">
										<ul>
										<c:forEach items="${requestScope.roleResourceList}" var="resourceInfo3">
											<c:if test="${resourceInfo3.resPid == resourceInfo2.resId }">
												<c:if test="${resourceInfo3.resType == 1 }">
													<li>
														<img src="images/menu3.jpg"/>&nbsp;
														<a href="${resourceInfo2.resUrl}" target="frmRight">
															<bean:message bundle="menuResources" key="${resourceInfo3.resName }"/>
														</a>
														</li>
												</c:if>
											</c:if>
										</c:forEach>
										</ul>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
					</c:if>
				</c:forEach>
			</c:if>
									
			<c:if test="${not empty requestScope.outerResourceList }">
				<c:forEach items="${requestScope.outerResourceList}" var="resourceInfo">
					<c:if test="${resourceInfo.resPid == 0 }">
					<c:if test="${resourceInfo.resType == 0 }">
						<div class="menu_head open" id="menu1" align="center">
							${resourceInfo.resName }
						</div>
						<ul id="menu1_content" class="menu_body show">
							<c:forEach items="${requestScope.outerResourceList}" var="resourceInfo2">
								<c:if test="${resourceInfo2.resPid == resourceInfo.resId }">
									<c:if test="${resourceInfo2.resType == 1 }">
										<li>
											<img src="images/ecard_r9_c7.jpg"/>&nbsp;
											<a href="redirect?resId=${resourceInfo2.resId}" target="frmRight">
												${resourceInfo2.resName }
											</a>
										</li>
									</c:if>
									<c:if test="${resourceInfo2.resType == 0 }">
										<div class="sub_head">
											<img src="images/ecard_r9_c7.jpg"/>&nbsp;
											${resourceInfo2.resName }
										</div>
									
										<div class="sub_body">
										<ul>
										<c:forEach items="${requestScope.outerResourceList}" var="resourceInfo3">
											<c:if test="${resourceInfo3.resPid == resourceInfo2.resId }">
												<c:if test="${resourceInfo3.resType == 1 }">
													<li>
														<img src="images/menu3.jpg"/>&nbsp;
														<a href="redirect?resId=${resourceInfo2.resId}" target="frmRight">
															${resourceInfo3.resName }
														</a>
														</li>
												</c:if>
											</c:if>
										</c:forEach>
										</ul>
										</div>
									</c:if>
								</c:if>
							</c:forEach>
						</ul>
					</c:if>
					</c:if>
				</c:forEach>
			</c:if>			
			
			<div class="exit">
				<a href="#" onclick="logOut()"><bean:message bundle="pageResources" key="page.left.logOut"/></a>
			</div>
		</div>
	</div>
</div>
</body>
</html>
