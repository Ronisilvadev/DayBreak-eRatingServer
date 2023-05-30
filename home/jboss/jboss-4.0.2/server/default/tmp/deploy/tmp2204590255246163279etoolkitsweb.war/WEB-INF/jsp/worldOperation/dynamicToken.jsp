<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>
<html>
<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" type="text/css" href="css/calendar-blue.css" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	<script type="text/javascript">				
		//验证查询条件
		function validateQueryCondition() {
			var condition = document.getElementById("condition").value;
			if (condition == "") {
				alert("请输入查询条件!");
				return false;
			}
			return true;
		}
		//验证passportName和令牌序列号
		function validateInput() {
			var passportName = document.getElementById("passportName").value;
			var tokenSN = document.getElementById("tokenSN").value;
			if (passportName == "") {
				alert("请输入passport帐户名!");
				return false;
			}
			if (tokenSN == "") {
				alert("请输入令牌序列号!");
				return false;
			}
			return true;
		}
	</script>
	
</head>

<body bgcolor="#ffffff">
	<br/>
	<div align="center" style="font-size:14px;">
		 <a href="showDynamicToken.do?operateType=0">令牌绑定信息查询</a>&nbsp;&nbsp;&nbsp;&nbsp;
	     <a href="showDynamicToken.do?operateType=1">令牌挂失</a>&nbsp;&nbsp;&nbsp;&nbsp;
		 <a href="showDynamicToken.do?operateType=4">令牌解除挂失</a>&nbsp;&nbsp;&nbsp;&nbsp; 
		 <a href="showDynamicToken.do?operateType=2">令牌停用</a>&nbsp;&nbsp;&nbsp;&nbsp;
		 <a href="showDynamicToken.do?operateType=3">令牌解锁</a>
	</div>
	<c:if test="${requestScope.operateType == 0}">	
	<form action="queryDynamicToken.do" method="post" onsubmit="return validateQueryCondition();">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">令牌绑定信息查询</td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">查询条件：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="condition" name="condition">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">查询方式：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="type">
				 	<option value="1">通行证帐号</option>
				 	<option value="2">身份证号</option>
				 	<option value="3">令牌序列号</option>
				 	</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	<br/>
	<c:if test="${not empty requestScope.tokenList }">
	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
		<tr>
			<td colspan="20" align="center" class="t_head"></td>
		</tr>
		<tr height="23px" class="h_CDE4F6">
			<td align="center" class="t_border_r">帐号名</td>
			<td align="center" class="t_border_r">令牌序列号</td>
			<td align="center" class="t_border_r">绑定时间</td>
			<td align="center" class="t_border_r">状态</td>
			<td align="center" class="t_border_r">挂失有效时间</td>
			<td align="center" class="t_border_r">手机号码</td>
			<td align="center" class="t_border_r">身份证号</td>
			<td align="center" class="t_border_r">真实姓名</td>
		</tr>
		<c:forEach items="${requestScope.tokenList}" var="tokenInfo">
			<tr height="23px">			
			<td align="center" class="t_border_r">${tokenInfo.passportName}&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.bindSN }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.bindTime }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.state }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.lostEffectTime }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.mobile }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.idCode }&nbsp;</td>
			<td align="center" class="t_border_r">${tokenInfo.idRealName }&nbsp;</td>
			</tr>
		</c:forEach>
		<tr height="0px">
			<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="20">
				&nbsp;				
			</td>
		</tr>
	</table>
	</c:if>
	</form>	
	</c:if>
	
	<c:if test="${requestScope.operateType == 1}">	
	<form action="operateDynamicToken.do" method="post" onsubmit="return validateInput();">
		<input type="hidden" name="operateType" value="${requestScope.operateType}"/>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">令牌挂失</td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">Passport帐号名：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="passportName" name="passportName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">令牌序列号：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="tokenSN" name="tokenSN">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">挂失方式：
				 </td>
				 <td class="t_border_r" align="left">
				 	<select name="lostType">
				 	<option value="1">冻结帐号方式</option>
				 	<option value="2">静态密码方式</option>
				 	</select>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${requestScope.operateType == 4}">	
	<form action="operateDynamicToken.do" method="post" onsubmit="return validateInput();">
		<input type="hidden" name="operateType" value="4"/>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">令牌解除挂失</td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">Passport帐号名：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="passportName" name="passportName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">令牌序列号：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="tokenSN" name="tokenSN">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${requestScope.operateType == 2}">
	<form action="operateDynamicToken.do" method="post" onsubmit="return validateInput();">
		<input type="hidden" name="operateType" value="2"/>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">令牌停用</td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">Passport帐号名：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="passportName" name="passportName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">令牌序列号：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="tokenSN" name="tokenSN">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	
	<c:if test="${requestScope.operateType == 3}">
	<form action="operateDynamicToken.do" method="post" onsubmit="return validateInput();">
		<input type="hidden" name="operateType" value="3"/>
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2">令牌解锁</td>
			</tr>	
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">Passport帐号名：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="passportName" name="passportName">
				 </td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right">令牌序列号：
				 </td>
				 <td class="t_border_r" align="left">
				 	<input type="text" id="tokenSN" name="tokenSN">
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
	</form>
	</c:if>
	<div align="center">
			<font color="red" size="3px"><html:errors/></font>
			<font color="red" size="3px">${msg }</font>
	</div>
	
	</body>
</html>