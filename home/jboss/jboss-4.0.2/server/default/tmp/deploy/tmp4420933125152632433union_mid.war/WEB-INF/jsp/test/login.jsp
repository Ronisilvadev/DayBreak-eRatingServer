<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>欢迎使用联运自动测试系统，请登陆</title>
   <base href="<%=basePath%>">
<script type="text/javascript" src="<%= basePath %>/js/jquery.js"></script>
  </head>
  <s></s>
  <body>
  <form  action="test/doLogin.do" method="post">
  
  <table align="center" border="1" width="" height="">
     <tr>
        <td align="right">用户名</td>
        <td align="left"><input type="text" name="username"></td>
     </tr>
     <tr>
        <td align="right">密码:</td>
        <td align="left"><input type="password" name="password"></td>
     </tr>
     <tr>
        <td colspan="2" align="center"><input type="submit" value="登录"></td>
     </tr> 
  </table>
  </form>
  </body>
</html>
