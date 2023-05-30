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
  登陆成功:</br>
  gameId: ${sessionScope.user.gameId}  </br>
  联运名称: ${sessionScope.user.serviceName}  </br>
  联运unionCode: ${sessionScope.user.unionCode}  </br>
  充值key: ${sessionScope.user.chargingKey}  </br>
  对账key: ${sessionScope.user.dateAccountKey}  </br>
<a href="test/autoTest.do"> 充值接口测试</a> </br>
</br>
<a href="test/testHistory.do"> 充值接口测试历史记录</a>
  
  
  </body>
</html>
