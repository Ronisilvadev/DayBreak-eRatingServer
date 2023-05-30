<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">
	  function createObj(id,name)
	       {
	            var obj =  new Object();
	            obj.id = id;
	            obj.name=name;
	            return obj;
	      }
	      
	  function sortNumber(a,b)
		{
			return a.id - b.id;
		}
		
		 function moveUp(obj)
		{
			var selected = obj.resource.selectedIndex;
			if (selected > 0){
					var temp = arr[selected];
					arr[selected] = arr[selected - 1];
					arr[selected -1] = temp;
					sortResource();
					obj.resource.options[selected - 1].selected = true;
			}
		}
		
		 function moveDown(obj)
		{
			var selected = obj.resource.selectedIndex;
			if (selected < obj.resource.options.length - 1){
					var temp = arr[selected];
					arr[selected] = arr[selected + 1];
					arr[selected + 1] = temp;
					sortResource();
					obj.resource.options[selected + 1].selected = true;
			}
		}
		
		function sortResource(){
			var obj = document.getElementById("resource");
			obj.options.length = 0;
			for (var i = 0; i < arr.length; i++){
				var varItem = new Option(arr[i].name,arr[i].id);
		 		obj.options.add(varItem);
		 	}
		 	if (obj.options.length == 0){
		 		document.getElementById("upButton").disabled = true;
				document.getElementById("downButton").disabled = true;
				document.getElementById("submitButton").disabled = true;
		 	}else{
		 		document.getElementById("upButton").disabled = false;
				document.getElementById("downButton").disabled = false;
				document.getElementById("submitButton").disabled = false;
		 	}
		}
		
		function submitForm(obj){
			obj.resource.multiple = true;
			var length = obj.resource.options.length;
			if (length == 0){
				return false;
			}
			for (var i = 0; i < length; i++){
				obj.resource.options[i].selected = true;
		 	}
		 	obj.submit();
		}
	</script>
	</head>

	<body bgcolor="#ffffff">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		  <tr height="30px">
				<td colspan="3" align="center" ></td>
			</tr>
		  <tr>
			<td colspan="3" align="center" class="t_head"><bean:message bundle="pageResources" key="page.purview.resourceSort.title"/></td>
		  </tr>
		  <tr>
		  	<td width="3%" class="border_bottom border_left border_top"><br /></td>
			<td valign="top" class="border_bottom border_top ">
				<p style="padding-top:15px;padding-bottom:5px;">
				<bean:message bundle="pageResources" key="page.purview.resourceSort.desc"/>：
				</p>
				<c:if test="${not empty requestScope.resourceList }">
				<div onClick="document.location.href='showResourceSort.do?resId=0';" style="padding-left:10px;padding-bottom:5px;cursor:pointer">
						<img src="images/menu2.jpg"/>
						<bean:message bundle="pageResources" key="page.purview.resourceTree.rootResource"/>
				</div>
				<c:forEach items="${requestScope.resourceList}" var="resourceInfo">
				<c:if test="${resourceInfo.resPid == 0 }">
					<div onclick="document.location.href='showResourceSort.do?resId=${resourceInfo.resId }';" style="padding-left:10px;padding-bottom:5px;cursor:pointer">
						<img src="images/menu2.jpg"/>
						<bean:message bundle="menuResources" key="${resourceInfo.resName}"/>（<bean:message bundle="menuResources" key="${resourceInfo.resDesc }"/>）
					</div>
					<c:forEach items="${requestScope.resourceList}" var="resourceInfo2">
						<c:if test="${resourceInfo.resId == resourceInfo2.resPid }">
							<div onClick="document.location.href='showResourceSort.do?resId=${resourceInfo2.resId }';" style="padding-left:30px;padding-bottom:5px;cursor:pointer">
								<img src="images/ecard_r9_c7.jpg"/>
								<bean:message bundle="menuResources" key="${resourceInfo.resName}"/>（<bean:message bundle="menuResources" key="${resourceInfo.resDesc }"/>）
							</div>
						</c:if>
					</c:forEach>
				</c:if>
				</c:forEach>
				</c:if>
			</td>
			<td align="left" valign="top" class="t_border_r border_bottom">
			<br />
				<bean:message bundle="pageResources" key="page.purview.resourceSort.desc2"/>：
				<form action="sortResource.do" method="post">
					<select size="15" id="resource" name="resource" multiple="true" style="width:200px"></select>
					<input type="button" id="upButton" onclick="moveUp(document.forms[0])" value="<bean:message bundle="pageResources" key="page.purview.resourceSort.up" />" disabled />
					<input type="button" id="downButton" onclick="moveDown(document.forms[0])" value="<bean:message bundle="pageResources" key="page.purview.resourceSort.down" />" disabled />
					<input type="button" id="submitButton" onclick="submitForm(document.forms[0])" value="<bean:message bundle="pageResources" key="page.common.submit"/>" disabled />
					<font color="red">${requestScope.msg}</font>
				</form>
			</td>
		  </tr>
		</table>
	<script type="text/javascript">
		<c:if test="${not empty requestScope.childResourceList }">
			var arr = new Array();
			var i = 0;
			<c:forEach items="${requestScope.childResourceList}" var="childResourceInfo">
				arr[i] = createObj("${childResourceInfo.resId}","<bean:message bundle="menuResources" key="${childResourceInfo.resName}"/>");
				i++;
			</c:forEach>
			sortResource();
		</c:if>
	</script>
	</body>
</html>
