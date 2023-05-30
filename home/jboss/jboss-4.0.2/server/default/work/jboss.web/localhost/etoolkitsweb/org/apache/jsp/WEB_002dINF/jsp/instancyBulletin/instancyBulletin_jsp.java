package org.apache.jsp.WEB_002dINF.jsp.instancyBulletin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class instancyBulletin_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/instancyBulletin/../inc/taglibs.jsp");
    _jspx_dependants.add("/WEB-INF/c.tld");
    _jspx_dependants.add("/WEB-INF/fmt.tld");
    _jspx_dependants.add("/WEB-INF/fn.tld");
    _jspx_dependants.add("/WEB-INF/gmweb.tld");
    _jspx_dependants.add("/WEB-INF/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/struts-bean.tld");
  }

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    JspFactory _jspxFactory = null;
    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;


    try {
      _jspxFactory = JspFactory.getDefaultFactory();
      response.setContentType("text/html; charset=utf-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("\r\n");
      out.write("<head>\r\n");
      out.write("\t<link href=\"css/main.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n");
      out.write("\t<title>发布紧急公告</title>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction check(){\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\tif ( document.forms[0].title.value == \"\" || document.forms[0].title.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert(\"请确认您已输入标题\");\r\n");
      out.write("\t\t\t\t\t  document.forms[0].title.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif ( document.forms[0].title.value.length > 256){\r\n");
      out.write("\t\t\t\t\t  alert(\"标题长度不能超过256个字符\");\r\n");
      out.write("\t\t\t\t\t  document.forms[0].title.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif ( document.forms[0].totalTimes.value == \"\" || document.forms[0].totalTimes.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert(\"请确认您已输入次数\");\r\n");
      out.write("\t\t\t\t\t   document.forms[0].totalTimes.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif ( document.forms[0].intervals.value == \"\" || document.forms[0].intervals.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert(\"请确认您已输入间隔\");\r\n");
      out.write("\t\t\t\t\t   document.forms[0].intervals.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif ( document.forms[0].content.value == \"\" || document.forms[0].content.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert(\"请确认您已输入内容\");\r\n");
      out.write("\t\t\t\t\t   document.forms[0].content.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\tif ( document.forms[0].content.value.length > 1024){\r\n");
      out.write("\t\t\t\t\t  alert(\"内容长度不能超过1024个字符\");\r\n");
      out.write("\t\t\t\t\t   document.forms[0].content.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\telse {\r\n");
      out.write("\t\t\t\t\t  return true;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t<form action=\"instancyBulletin.do?method=addBulletin\" method=\"post\" onsubmit=\"return check();\">\r\n");
      out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" height=\"30PX\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" class=\"t_head\" colspan=\"3\">发 布 紧 急 公 告</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t<td width=\"25%\" class=\"t_border_l\" align=\"right\" >标题： \r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t \t<input name=\"title\" type=\"text\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.title}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" style=\"width:230px\"/>\r\n");
      out.write("\t\t\t\t \t（不能超过256个字符） \r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"25%\" class=\"t_border_l\" align=\"right\">请指定游戏：\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t \t<select name=\"gameId\">\r\n");
      out.write("\t\t\t\t\t\t<option value=\"1\" >倚天剑与屠龙刀</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"2\" selected >问鼎</option>\r\n");
      out.write("\t\t\t\t\t\t\t\t\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"25%\" class=\"t_border_l\" align=\"right\">发布次数：\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t \t<input name=\"totalTimes\" type=\"text\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.totalTimes }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"25%\" class=\"t_border_l\" align=\"right\">请选择间隔：\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_l\" align=\"left\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t \t<select name=\"intervals\">\r\n");
      out.write("\t\t\t\t\t\t<option value=\"30\">30秒（慎用！）</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"60\">1分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"120\">2分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"300\" selected>5分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"600\">10分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"1200\">20分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"1800\">30分钟</option>\r\n");
      out.write("\t\t\t\t\t\t<option value=\"3600\">1小时</option>\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"25%\" class=\"t_border_l\" align=\"right\">公告内容：\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_l\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t<textarea name=\"content\" rows=8 cols=35 size=\"10240\" >");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.content }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</textarea>\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"center\">\r\n");
      out.write("\t\t\t\t \t（不能超过1024个字符） \r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;\" align=\"center\" colspan=\"3\">\r\n");
      out.write("\t\t\t\t\t<input type=\"submit\" value=\" 提 交 \" />\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\t\t<div align=\"center\">\r\n");
      out.write("\t\t\t<font color=\"red\" size=\"3px\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</font>\r\n");
      out.write("\t\t</div>\r\n");
      out.write("\t\t\r\n");
      out.write("\t</body>\r\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
      }
    } finally {
      if (_jspxFactory != null) _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
