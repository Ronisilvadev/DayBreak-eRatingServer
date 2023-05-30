<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>发布紧急公告</title>
	<script type="text/javascript">
		
		function check(){
			
				if ( document.forms[0].title.value == "" || document.forms[0].title.value  == null){
					  alert("请确认您已输入标题");
					  document.forms[0].title.focus();
					  return false;
				}
				if ( document.forms[0].title.value.length > 256){
					  alert("标题长度不能超过256个字符");
					  document.forms[0].title.focus();
					  return false;
				}
				if ( document.forms[0].totalTimes.value == "" || document.forms[0].totalTimes.value  == null){
					  alert("请确认您已输入次数");
					   document.forms[0].totalTimes.focus();
					  return false;
				}
				if ( document.forms[0].intervals.value == "" || document.forms[0].intervals.value  == null){
					  alert("请确认您已输入间隔");
					   document.forms[0].intervals.focus();
					  return false;
				}
				if ( document.forms[0].content.value == "" || document.forms[0].content.value  == null){
					  alert("请确认您已输入内容");
					   document.forms[0].content.focus();
					  return false;
				}
				if ( document.forms[0].content.value.length > 1024){
					  alert("内容长度不能超过1024个字符");
					   document.forms[0].content.focus();
					  return false;
				}
				else {
					  return true;
				}
			}
	</script>
</head>


<body bgcolor="#ffffff">
	<form action="instancyBulletin.do?method=addBulletin" method="post" onsubmit="return check();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="3">发 布 紧 急 公 告</td>
			</tr>
			<tr>
			<td width="25%" class="t_border_l" align="right" >标题： 
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="title" type="text" value="${requestScope.title}" style="width:230px"/>
				 	（不能超过256个字符） 
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">请指定游戏：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<select name="gameId">
						<option value="1" >倚天剑与屠龙刀</option>
						<option value="2" selected >问鼎</option>
								
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">发布次数：
				 </td>
				 <td class="t_border_r" align="left" colspan="2">
				 	<input name="totalTimes" type="text" value="${requestScope.totalTimes }" />
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">请选择间隔：
				 </td>
				 <td class="t_border_l" align="left" colspan="2">
				 	<select name="intervals">
						<option value="30">30秒（慎用！）</option>
						<option value="60">1分钟</option>
						<option value="120">2分钟</option>
						<option value="300" selected>5分钟</option>
						<option value="600">10分钟</option>
						<option value="1200">20分钟</option>
						<option value="1800">30分钟</option>
						<option value="3600">1小时</option>
					</select>
				 </td>
			</tr>
			<tr height="30px">
				<td width="25%" class="t_border_l" align="right">公告内容：
				 </td>
				 <td class="t_border_l" align="left">
				 	<textarea name="content" rows=8 cols=35 size="10240" >${requestScope.content }</textarea>
				 </td>
				 <td class="t_border_r" align="center">
				 	（不能超过1024个字符） 
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="3">
					<input type="submit" value=" 提 交 " />
				</td>
			</tr>
		</table>
		</form>
		<div align="center">
			<font color="red" size="3px">${msg }</font>
		</div>
		
	</body>
</html>