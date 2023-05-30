<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

	<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<title></title>
		<script type="text/javaScript">
				
			function gotoPage(obj){
				obj.submit();
			}
			
			function checkAll(frm) 
			{ 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.selectAll"/>") 
					{ 
						e.checked = true; 
					} 
					else if (e.type == 'checkbox' && frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.cancel"/>"){
						e.checked = false; 
					} 
				} 
			
				if (frm.selectAll.value == "<bean:message bundle="pageResources" key="page.common.selectAll"/>"){
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.cancel"/>";
					frm.deleteButton.disabled = false;
				}else{
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.selectAll"/>";
					frm.deleteButton.disabled = true;
				}
			}
			
			function uncheckAll(frm) 
			{ 
				var TB=TO=0; 
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox') 
					{ 
						TB++; 
						if (e.checked){
							TO++;
						} 
					} 
				}
				
				if (TB == TO){
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.cancel"/>";
				}else{
					frm.selectAll.value = "<bean:message bundle="pageResources" key="page.common.selectAll"/>";
				}
				
				if (0==TO)//全部未选中和选中一些时对删除按钮的disabled属性的影响 
				{ 
					frm.deleteButton.disabled = true; 
				} 
				else 
				{ 
					frm.deleteButton.disabled = false; 
				} 
				
			} 
			
			function selectThis(frm,selectValue){
				for (var i=0;i<frm.elements.length;i++) 
				{ 
					var e=frm.elements[i]; 
					if (e.type == 'checkbox' && e.value == selectValue) 
					{ 
						e.checked = true; 
						frm.deleteButton.disabled = false; 
						break;
					} 
				} 
				
			}
		</script>
	</head>

	<body bgcolor="#ffffff">
		<form action="delGateway.do" method="post">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
				<tr height="30px">
					<td colspan="9" align="center"></td>
				</tr>
				<tr>
					<td colspan="9" align="center" class="t_head">
						<bean:message bundle="pageResources" key="page.dictionaryConfig.gatewayConfig.title"/>
					</td>
				</tr>
				<tr height="23px" class="h_CDE4F6">
					<td width="10%" align="center" class="t_border_l"><bean:message bundle="pageResources" key="page.common.choice"/></td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gameId"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayId2"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayType"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayProvider"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayName"/>
					</td>
					<td align="center" class="t_border_l">
						<bean:message bundle="pageResources" key="page.common.gatewayUrl"/>
					</td>
					<td align="center" class="t_border_r">
						<bean:message bundle="pageResources" key="page.common.operation"/>
					</td>
				</tr>
				<c:if test="${not empty requestScope.gatewayList }">
				<c:forEach items="${requestScope.gatewayList}" var="gateway" varStatus="status">
					<tr height="23px">
						<td width="10%" align="center" class="t_border_l">
							<input name="countId" type="checkbox" value="${status.index + 1 }" onclick="uncheckAll(document.forms[0]);" />
						</td>
						<td align="center" class="t_border_l">
							${gateway.gameId }
							<input name="gameId${status.index + 1 }" type="hidden" value="${gateway.gameId }"  />
						</td>
						<td align="center" class="t_border_l">
							${gateway.gatewayId }
							<input name="gatewayId${status.index + 1 }" type="hidden" value="${gateway.gatewayId }" />
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${gateway.gatewayType == 1 }">
								<bean:message bundle="pageResources" key="page.common.officialRegion"/>
							</c:if>
							<c:if test="${gateway.gatewayType == 0 }">
								<bean:message bundle="pageResources" key="page.common.expRegion"/>
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							<c:if test="${gateway.gatewayProvider == 1 }">
								<bean:message bundle="pageResources" key="page.common.dianxin"/>
							</c:if>
							<c:if test="${gateway.gatewayProvider == 2 }">
								<bean:message bundle="pageResources" key="page.common.wangtong"/>
							</c:if>
							<c:if test="${gateway.gatewayProvider == 3 }">
								<bean:message bundle="pageResources" key="page.common.shuangxian"/>
							</c:if>
						</td>
						<td align="center" class="t_border_l">
							${gateway.gatewayName }
						</td>
						<td align="center" class="t_border_l">
							${gateway.gatewayUrl }
						</td>
						<td align="center" class="t_border_r">
							<a href="showModifyGateway.do?gameId=${gateway.gameId }&gatewayId=${gateway.gatewayId }"><bean:message bundle="pageResources" key="page.common.modify"/></a>
							<a href="delGateway.do?gameId=${gateway.gameId }&gatewayId=${gateway.gatewayId }"><bean:message bundle="pageResources" key="page.common.del"/></a>
						</td>
					</tr>
				</c:forEach>
				</c:if>
				<tr height="30px">
				<td colspan="9" align="center" class="t_border">
				<input type="button" value="<bean:message bundle="pageResources" key="page.common.syn"/>" onclick="window.location.href='showSynGateway.do'"/>
					<input name="gameId2Show" type="hidden" value="${requestScope.gameId }"  />
					<input id="selectAll" name="selectAll" type="button" value="<bean:message bundle="pageResources" key="page.common.selectAll"/>" onClick="checkAll(document.forms[0]);" />&nbsp;&nbsp;
					<input name="deleteButton" type="submit" value="<bean:message bundle="pageResources" key="page.common.delChecked"/>" disabled/>&nbsp;&nbsp;
					<input type="button" value="<bean:message bundle="pageResources" key="page.common.add"/>" onclick="window.location.href='showAddGateway.do?gameId=${requestScope.gameId}'" />&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		</form>
		<table border="0" cellpadding="0" cellspacing="0" width="90%" align="center">
			<tr><td align="left">
			<B><bean:message bundle="pageResources" key="page.dictionary.gatewayConfig.tip"/></B>
			</td></tr>
		</table>
			<br />
		<div align="center">
				<font color="red" size="3px">${msg }</font>
			</div>

	</body>
</html>
