package org.apache.jsp.WEB_002dINF.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class top_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/inc/taglibs.jsp");
    _jspx_dependants.add("/WEB-INF/c.tld");
    _jspx_dependants.add("/WEB-INF/fmt.tld");
    _jspx_dependants.add("/WEB-INF/fn.tld");
    _jspx_dependants.add("/WEB-INF/gmweb.tld");
    _jspx_dependants.add("/WEB-INF/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/struts-bean.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_bean_message_key_bundle_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
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

      out.write('\r');
      out.write('\n');
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n");
      out.write("<html xmlns=\"http://www.w3.org/1999/xhtml\">\r\n");
      out.write("<head>\r\n");
      out.write("<STYLE>\r\n");
      out.write(".navPoint {\r\n");
      out.write("\tFONT-SIZE: 13pt; \r\n");
      out.write("\tCURSOR: pointer; \r\n");
      out.write("\tFONT-FAMILY: Webdings;\r\n");
      out.write("\tpadding-left:0px;\r\n");
      out.write("}\r\n");
      out.write("\r\n");
      out.write(".navPoint2 {\r\n");
      out.write("\tFONT-SIZE: 15pt; \r\n");
      out.write("\tCURSOR: pointer; \r\n");
      out.write("\tFONT-FAMILY: Webdings;\r\n");
      out.write("\tpadding-left:0px;\r\n");
      out.write("\tpadding-right:0px;\r\n");
      out.write("\tpadding-bottom:0px;\r\n");
      out.write("\tmargin:0px;\r\n");
      out.write("\t\r\n");
      out.write("}\r\n");
      out.write(".cursorHand {\r\n");
      out.write(" cursor:pointer;\r\n");
      out.write(" }\r\n");
      out.write("</STYLE>\r\n");
      out.write("<link href=\"css/main.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />\r\n");
      out.write("<title>top</title>\r\n");
      out.write("<script language=\"JavaScript1.2\">\r\n");
      out.write("   \r\n");
      out.write("   function switchBar(){\r\n");
      out.write("\tif (document.getElementById(\"switchPoint\").innerText==5){\r\n");
      out.write("\t\tdocument.getElementById(\"topTbl\").style.display=\"none\"\r\n");
      out.write("\t\tdocument.getElementById(\"topTd\").style.display=\"none\";\r\n");
      out.write("\t\tdocument.getElementById(\"welcome\").style.display=\"\";\r\n");
      out.write("\t\twindow.top.document.getElementById(\"fsMain\").rows = \"25,*\";\r\n");
      out.write("\t\tdocument.getElementById(\"switchPoint\").innerText=6;\r\n");
      out.write("\t}\r\n");
      out.write("\telse{\r\n");
      out.write("\t\twindow.top.document.getElementById(\"fsMain\").rows = \"100,*,30\";\r\n");
      out.write("\t\tdocument.getElementById(\"topTbl\").style.display=\"\"\r\n");
      out.write("\t\tdocument.getElementById(\"topTd\").style.display=\"\";\r\n");
      out.write("\t\tdocument.getElementById(\"welcome\").style.display=\"\";\r\n");
      out.write("\t\tdocument.getElementById(\"switchPoint\").innerText=5;\r\n");
      out.write("\t}\r\n");
      out.write("}\r\n");
      out.write("</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body>\r\n");
      out.write("<center>\r\n");
      out.write("<img style=\"display:none\" src=\"images/login/");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${bannerName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" onerror=\"javascript:document.getElementById('topTbl').background='images/login/banner.jpg';\" />\r\n");
      out.write("<table id=\"topTbl\" width=\"1024px\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\"  background=\"images/login/");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${bannerName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\">\r\n");
      out.write("\t<tr>\r\n");
      out.write("\t    <td width=\"1100px\" id=\"topTd\" valign=\"bottom\"  height=\"105\">\r\n");
      out.write("\t\t</td>\r\n");
      out.write("\t</tr>\r\n");
      out.write("</table>\r\n");
      out.write("<div id=\"welcome\" style=\"background:url(images/login/head.jpg) repeat-x; padding-left:30px;padding-top:2px;padding-bottom:2px\" align=\"left\" >\r\n");
      out.write("\t\t");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write(" <b>");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.userInfo.passportName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</b> ");
      if (_jspx_meth_bean_message_1(_jspx_page_context))
        return;
      out.write("\t\r\n");
      out.write("</div> \r\n");
      out.write("</center>\r\n");
      out.write("</body>\r\n");
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.tpo.welcome");
    int _jspx_eval_bean_message_0 = _jspx_th_bean_message_0.doStartTag();
    if (_jspx_th_bean_message_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_1 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_1.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_1.setParent(null);
    _jspx_th_bean_message_1.setBundle("pageResources");
    _jspx_th_bean_message_1.setKey("page.tpo.useSystem");
    int _jspx_eval_bean_message_1 = _jspx_th_bean_message_1.doStartTag();
    if (_jspx_th_bean_message_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_1);
    return false;
  }
}
