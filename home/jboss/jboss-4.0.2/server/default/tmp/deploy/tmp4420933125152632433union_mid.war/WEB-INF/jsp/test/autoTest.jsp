<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
  <head>
    <title>接口测试类</title>
   <base href="<%=basePath%>">
   <script type="text/javascript" src="<%= basePath %>/js/jquery.js"></script>
  </head>
  <s></s>
  <body>
  <form  action="test/doAutoTest.do" method="post">
  
  充值测试url: <textarea rows="4" cols="100" name="url" nowarp = "true"></textarea>
   </br>
    <input type="submit" value="测试"> 
  </form>
  </body>
</html>
