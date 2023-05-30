<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
		<link href="css/main.css" rel="stylesheet" type="text/css" />
		<link href="css/weebox.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		
	<title>无标题文档</title>
	</head>
  <body bgcolor="#ffffff">
  	<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  		<tr>
  			<td colspan="2" align="center" >
						
			</td>
  		</tr>
  		<tr>
  			<td colspan="2" align="center" class="t_head">
			  <bean:message bundle="pageResources" key="page.addRelationGame.title"/>
			</td>
  		</tr>
  		<tr height="23px" class="h_CDE4F6">
  			<td align="center" class="t_border_l">
				<bean:message bundle="pageResources" key="page.addRelationGame.currentGameId"/>
			</td>
			<td align="center" class="t_border_r">
				<bean:message bundle="pageResources" key="page.addRelationGame.currentGameName"/>
			</td>
  		</tr>
  		<tr height="23px">
  			<td align="center" class="t_border">
				${currentGame.gameId }
			</td>
			<td align="center" class="t_border">
				${currentGame.gameName }
			</td>
		</tr>
  	</table>
  	<br/>
  		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	  		<tr>
	  			<td colspan="3" align="center" >
							
				</td>
	  		</tr>
	  		<tr>
	  			<td colspan="3" align="center" class="t_head">
				  <bean:message bundle="pageResources" key="page.addGameRelation.relationedGames"/>
				</td>
	  		</tr>
	  		<tr height="23px" class="h_CDE4F6">
	  			<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.addRelationGame.gameId"/>
				</td>
				<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.addRelationGame.gameName"/>
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.common.operation"/>
				</td>
	  		</tr>
			<c:forEach var="game" items="${requestScope.relationedGames}" varStatus="status">
	  		<tr>
	  			<td align="center" <c:if test="${status.last }">class="t_border"</c:if><c:if test="${not status.last }">class="t_border_l"</c:if>>
					${game.gameId }
				</td>
				<td align="center" <c:if test="${status.last }">class="t_border"</c:if><c:if test="${not status.last }">class="t_border_l"</c:if>>
					${game.gameName }
				</td>
				<td align="center" <c:if test="${status.last }">class="t_border"</c:if><c:if test="${not status.last }">class="t_border_r"</c:if>>
					<a href="#" onclick="window.location.href='delRelationGame.do?tgameId=${game.gameId }'"><bean:message bundle="pageResources" key="page.common.del" /></a>
				</td>
			</tr>
	  		</c:forEach>
	  		</table>
  	
  	<div align="center">
  	<font color="red" size="3">${msg }
  	</font></div>
  	<c:if test="${empty msg}">
  		<br/>
  	</c:if>
  	
  	
<form action="addRelationGame.do" method="post" id="selectGames">
	  		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
	  		<tr>
	  			<td colspan="3" align="center" >
							
				</td>
	  		</tr>
	  		<tr>
	  			<td colspan="3" align="center" class="t_head">
				  <bean:message bundle="pageResources" key="page.addGameRelation.selectGame"/>
				</td>
	  		</tr>
	  		<tr height="23px" class="h_CDE4F6">
	  			<td align="center" class="t_border_l">
	  				<bean:message bundle="pageResources" key="page.common.choice"/>
	  			</td>
	  			<td align="center" class="t_border_l">
					<bean:message bundle="pageResources" key="page.addRelationGame.gameId"/>
				</td>
				<td align="center" class="t_border_r">
					<bean:message bundle="pageResources" key="page.addRelationGame.gameName"/>
				</td>
	  		</tr>
			<c:forEach var="game" items="${requestScope.otherGames}">
	  		<tr>
	  			<td align="center" class="t_border_l">
	  				<input name="gameids" type="checkbox" value="${game.gameId }"/>
	  			</td>	
	  			<td align="center" class="t_border_l">
					${game.gameId }
				</td>
				<td align="center" class="t_border_r">
					${game.gameName }
				</td>
			</tr>
	  		</c:forEach>
	  		<tr>
	  		<td colspan="3" align="center" class="t_border"><input type="submit" value='<bean:message bundle="pageResources" key="page.common.submit"/>'/></td></tr>
	  		</table>
	  		</form>
  	
  </body>
</html>
