<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page language="java" import="com.linekong.unionmid.web.test.UnionHistoryPOJO"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>    
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>    
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>  

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
   
    
    <title>My JSP 'testHistory.jsp' starting page</title>
    
  </head>
  
  <body>

 <form action="test/testHistory.do" method="post">
 
<table class="style1" width="100%" cellpadding="0" cellspacing="0"
				align="center" border="1">
				<tr class="tr1">
					<td align="center" width="10%">
						gameId
					</td>
					<td align="center" width="10%">
						unionCode
					</td>
					<td align="center" width="50%">
						访问url
					</td>
					<td align="center" width="20%">
						访问时间
					</td>
						<td align="center" width="10%">
						返回调用结果
					</td>
				</tr>
<logic:iterate id="unionHistoryPOJO" name="unionHistoryPOJO" scope="request"> 
  <tr>
  <td align="center"><bean:write name="unionHistoryPOJO" property="gameId"/></td>
  <td align="center"><bean:write name="unionHistoryPOJO" property="unionCode"/></td>
  <td align="center"><TEXTAREA rows="4" cols="100"><bean:write name="unionHistoryPOJO" property="url"/></TEXTAREA></td>
  <td align="center"><bean:write name="unionHistoryPOJO" property="date"/></td>
  <td align="center"><bean:write name="unionHistoryPOJO" property="response"/></td>
  </tr>
  </logic:iterate>
  
</table>
 
 </form>
  </body>
</html>
