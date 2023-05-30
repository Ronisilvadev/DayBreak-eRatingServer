package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class middle_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

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
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("\t<head>\r\n");
      out.write("\t\t<link href=\"css/main.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("\t\t<STYLE>.navPoint {\r\n");
      out.write("\tFONT-SIZE: 7pt; \r\n");
      out.write("\tCURSOR: pointer; \r\n");
      out.write("\tFONT-FAMILY: Webdings;\r\n");
      out.write("}\r\n");
      out.write("P {\r\n");
      out.write("\tFONT-SIZE: 7pt;\r\n");
      out.write("}\r\n");
      out.write("</STYLE>\r\n");
      out.write("\t\t<title>linekong</title>\r\n");
      out.write("\t</head>\r\n");
      out.write("<SCRIPT>\r\n");
      out.write("function switchBar(){\r\n");
      out.write("\tif (document.getElementById(\"switchPoint\").innerText==7){\r\n");
      out.write("\t\tdocument.getElementById(\"switchPoint\").innerText=8\r\n");
      out.write("\t\tdocument.getElementById(\"leftTd\").style.display=\"none\"\r\n");
      out.write("\t}\r\n");
      out.write("\telse{\r\n");
      out.write("\t\tdocument.getElementById(\"switchPoint\").innerText=7\r\n");
      out.write("\t\tdocument.getElementById(\"leftTd\").style.display=\"\"\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(" function switchTopBar(){\r\n");
      out.write("    var topWindow = parent.frames[\"topFrame\"];\r\n");
      out.write("\tif (document.getElementById(\"switchTopPoint\").innerText==5){\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"topTbl\").style.display=\"none\"\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"topTd\").style.display=\"none\";\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"welcome\").style.display=\"\";\r\n");
      out.write("\t\twindow.top.document.getElementById(\"fsMain\").rows = \"25,*\";\r\n");
      out.write("\t\tdocument.getElementById(\"switchTopPoint\").innerText=6;\r\n");
      out.write("\t}\r\n");
      out.write("\telse{\r\n");
      out.write("\t\twindow.top.document.getElementById(\"fsMain\").rows = \"100,*,30\";\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"topTbl\").style.display=\"\"\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"topTd\").style.display=\"\";\r\n");
      out.write("\t\ttopWindow.document.getElementById(\"welcome\").style.display=\"none\";\r\n");
      out.write("\t\tdocument.getElementById(\"switchTopPoint\").innerText=5;\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write("  function resizeMenuFrame() {\r\n");
      out.write("    if (event.clientX > 100 && event.clientX < 300) {\r\n");
      out.write("      leftTd.width = event.clientX;\r\n");
      out.write("    }\r\n");
      out.write("  }\r\n");
      out.write("</SCRIPT>\r\n");
      out.write("\r\n");
      out.write("\t<BODY leftmargin=\"0\" topmargin=\"0\" style=\"MARGIN: 0px\" scroll=no>\r\n");
      out.write("\t\t<TABLE cellSpacing=0 cellPadding=0 width=\"1024px\" height=\"100%\" border=0 align=\"center\">\r\n");
      out.write("\t\t\t<tr><!-- left_menu -->\r\n");
      out.write("\t\t\t\t <td id=\"leftTd\" name=\"leftTd\" align=\"center\" vAlign=top noWrap width=211 rowspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<IFRAME id=\"frmLeft\" name=\"frmLeft\" \r\n");
      out.write("\t\t\t\t\t\tstyle=\"Z-INDEX: 2; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%\"\r\n");
      out.write("                   \t\t src=\"showFrame.do?method=showLeft\" frameBorder=0\r\n");
      out.write("                    \t scrolling=\"auto\" resizeable=\"yes\" noWrap marginwidth=\"0\" marginheight=\"0\">\r\n");
      out.write("\t\t   \t\t\t</IFRAME>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t<!-- middle_switch_bar -->\r\n");
      out.write("\r\n");
      out.write("\t\t\t\t<td bgColor=\"#E3EDF6\" width=\"3\" style=\"WIDTH: 1pt;cursor:e-resize\" ondrag=\"resizeMenuFrame();\" valign=top rowspan=\"2\">\r\n");
      out.write("        \t\t\t<font font-size:7pt>\r\n");
      out.write("          \t\t\t\t<SPAN class=navPoint id=switchTopPoint onclick=\"switchTopBar();\">5\r\n");
      out.write("          \t\t\t\t</SPAN>\r\n");
      out.write("          \t\t\t</FONT><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />\r\n");
      out.write("          \t\t\t<font font-size:7pt>\r\n");
      out.write("          \t\t\t\t<SPAN class=navPoint id=switchPoint onclick=\"switchBar();\">7\r\n");
      out.write("          \t\t\t\t</SPAN>\r\n");
      out.write("          \t\t\t</FONT>\r\n");
      out.write("          \t\t</td>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<td height=\"30\">\r\n");
      out.write("\t\t\t\t\t<iframe style=\"Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%\" src=\"showFrame.do?method=showTab\" frameBorder=0 resizeable=\"yes\" scrolling=\"auto\"></iframe>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<!-- right_content -->\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\t<td vAlign=top width=\"100%\" height=\"400\">\r\n");
      out.write("\t\t\t\t\t<iframe id=frmRight style=\"Z-INDEX: 1; VISIBILITY: inherit; WIDTH: 100%; HEIGHT: 100%\" name=frmRight src=\"showFrame.do?method=showWelcome\" frameBorder=0 resizeable=\"yes\" scrolling=\"auto\"></iframe>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t</TABLE>\r\n");
      out.write("\t</body>\r\n");
      out.write("</html>\r\n");
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
