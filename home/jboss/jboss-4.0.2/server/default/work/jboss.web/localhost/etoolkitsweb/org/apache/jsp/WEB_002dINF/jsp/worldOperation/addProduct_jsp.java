package org.apache.jsp.WEB_002dINF.jsp.worldOperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class addProduct_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/worldOperation/../inc/taglibs.jsp");
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
      out.write("\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n");
      out.write("\t<title></title>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"js/func.js\"></script>\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tfunction isInt(strInt) {\r\n");
      out.write("\t\t\tif (strInt == null) return false;\r\n");
      out.write("\t\t\tvar re=/^\\d{1,1}$/\r\n");
      out.write("\t\t\treturn re.test(strInt);\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\r\n");
      out.write("\t\tfunction check(){\r\n");
      out.write("\t\t\tif ( document.forms[0].productCode.value == \"\" || document.forms[0].productCode.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert('");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("');\r\n");
      out.write("\t\t\t\t\t  document.forms[0].productCode.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tif ( document.forms[0].productName.value == \"\" || document.forms[0].productName.value  == null){\r\n");
      out.write("\t\t\t\t\t  alert('");
      if (_jspx_meth_bean_message_1(_jspx_page_context))
        return;
      out.write("');\r\n");
      out.write("\t\t\t\t\t  document.forms[0].productName.focus();\r\n");
      out.write("\t\t\t\t\t  return false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tif ( document.forms[0].productDesc.value.length > 4000){\r\n");
      out.write("\t\t\t\t\t  \talert('");
      if (_jspx_meth_bean_message_2(_jspx_page_context))
        return;
      out.write("');\r\n");
      out.write("\t\t\t\t\t\tdocument.forms[0].productDesc.focus();\r\n");
      out.write("\t\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\telse {\r\n");
      out.write("\t\t\t\t\t  return true;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t<form action=\"addProduct.do\" method=\"post\" onsubmit=\"return check();\">\r\n");
      out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" height=\"30PX\" colspan=\"2\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" class=\"t_head\" colspan=\"2\">");
      if (_jspx_meth_bean_message_3(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_4(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t<input name=\"productCode\" type=\"text\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ requestScope.productCode}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_5(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t<input name=\"productName\" type=\"text\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ requestScope.productName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_6(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t<select name=\"useType\">\r\n");
      out.write("\t\t\t\t \t\t<option value='1'>");
      if (_jspx_meth_bean_message_7(_jspx_page_context))
        return;
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t<option value='2'>");
      if (_jspx_meth_bean_message_8(_jspx_page_context))
        return;
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t<option value='3' selected>");
      if (_jspx_meth_bean_message_9(_jspx_page_context))
        return;
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t\t<option value='4'>");
      if (_jspx_meth_bean_message_10(_jspx_page_context))
        return;
      out.write("</option>\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t <td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_11(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t  \t<textarea cols=\"20\" rows=\"5\" name=\"productDesc\" ></textarea>\r\n");
      out.write("\t\t\t\t  \t");
      if (_jspx_meth_bean_message_12(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;\" align=\"center\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<input type=\"submit\" value=\" ");
      if (_jspx_meth_bean_message_13(_jspx_page_context))
        return;
      out.write(" \" />&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t<input type=\"button\" value=\" ");
      if (_jspx_meth_bean_message_14(_jspx_page_context))
        return;
      out.write(" \" onclick=\"window.location.href='showProduct.do'\"/>\r\n");
      out.write("\t\t\t\t</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t</form>\r\n");
      out.write("\t\t<div align=\"center\">\r\n");
      out.write("\t\t\t<font color=\"red\" size=\"3px\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</font>\r\n");
      out.write("\t\t</div>\r\n");
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.worldOperation.errors.itemCode");
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
    _jspx_th_bean_message_1.setKey("page.worldOperation.errors.itemName");
    int _jspx_eval_bean_message_1 = _jspx_th_bean_message_1.doStartTag();
    if (_jspx_th_bean_message_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_1);
    return false;
  }

  private boolean _jspx_meth_bean_message_2(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_2 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_2.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_2.setParent(null);
    _jspx_th_bean_message_2.setBundle("pageResources");
    _jspx_th_bean_message_2.setKey("page.worldOperation.errors.descLength");
    int _jspx_eval_bean_message_2 = _jspx_th_bean_message_2.doStartTag();
    if (_jspx_th_bean_message_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_2);
    return false;
  }

  private boolean _jspx_meth_bean_message_3(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_3 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_3.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_3.setParent(null);
    _jspx_th_bean_message_3.setBundle("pageResources");
    _jspx_th_bean_message_3.setKey("page.worldOperation.addProduct.title");
    int _jspx_eval_bean_message_3 = _jspx_th_bean_message_3.doStartTag();
    if (_jspx_th_bean_message_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_3);
    return false;
  }

  private boolean _jspx_meth_bean_message_4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_4 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_4.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_4.setParent(null);
    _jspx_th_bean_message_4.setBundle("pageResources");
    _jspx_th_bean_message_4.setKey("page.worldOperation.operProduct.productCode");
    int _jspx_eval_bean_message_4 = _jspx_th_bean_message_4.doStartTag();
    if (_jspx_th_bean_message_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_4);
    return false;
  }

  private boolean _jspx_meth_bean_message_5(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_5 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_5.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_5.setParent(null);
    _jspx_th_bean_message_5.setBundle("pageResources");
    _jspx_th_bean_message_5.setKey("page.worldOperation.productInfo.item_name");
    int _jspx_eval_bean_message_5 = _jspx_th_bean_message_5.doStartTag();
    if (_jspx_th_bean_message_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_5);
    return false;
  }

  private boolean _jspx_meth_bean_message_6(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_6 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_6.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_6.setParent(null);
    _jspx_th_bean_message_6.setBundle("pageResources");
    _jspx_th_bean_message_6.setKey("page.worldOperation.productInfo.item_type");
    int _jspx_eval_bean_message_6 = _jspx_th_bean_message_6.doStartTag();
    if (_jspx_th_bean_message_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_6);
    return false;
  }

  private boolean _jspx_meth_bean_message_7(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_7 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_7.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_7.setParent(null);
    _jspx_th_bean_message_7.setBundle("pageResources");
    _jspx_th_bean_message_7.setKey("page.worldOperation.addProduct.itemTypeValue1");
    int _jspx_eval_bean_message_7 = _jspx_th_bean_message_7.doStartTag();
    if (_jspx_th_bean_message_7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_7);
    return false;
  }

  private boolean _jspx_meth_bean_message_8(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_8 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_8.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_8.setParent(null);
    _jspx_th_bean_message_8.setBundle("pageResources");
    _jspx_th_bean_message_8.setKey("page.worldOperation.addProduct.itemTypeValue2");
    int _jspx_eval_bean_message_8 = _jspx_th_bean_message_8.doStartTag();
    if (_jspx_th_bean_message_8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_8);
    return false;
  }

  private boolean _jspx_meth_bean_message_9(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_9 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_9.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_9.setParent(null);
    _jspx_th_bean_message_9.setBundle("pageResources");
    _jspx_th_bean_message_9.setKey("page.worldOperation.addProduct.itemTypeValue3");
    int _jspx_eval_bean_message_9 = _jspx_th_bean_message_9.doStartTag();
    if (_jspx_th_bean_message_9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_9);
    return false;
  }

  private boolean _jspx_meth_bean_message_10(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_10 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_10.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_10.setParent(null);
    _jspx_th_bean_message_10.setBundle("pageResources");
    _jspx_th_bean_message_10.setKey("page.worldOperation.addProduct.itemTypeValue4");
    int _jspx_eval_bean_message_10 = _jspx_th_bean_message_10.doStartTag();
    if (_jspx_th_bean_message_10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_10);
    return false;
  }

  private boolean _jspx_meth_bean_message_11(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_11 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_11.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_11.setParent(null);
    _jspx_th_bean_message_11.setBundle("pageResources");
    _jspx_th_bean_message_11.setKey("page.worldOperation.productInfo.description");
    int _jspx_eval_bean_message_11 = _jspx_th_bean_message_11.doStartTag();
    if (_jspx_th_bean_message_11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_11);
    return false;
  }

  private boolean _jspx_meth_bean_message_12(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_12 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_12.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_12.setParent(null);
    _jspx_th_bean_message_12.setBundle("pageResources");
    _jspx_th_bean_message_12.setKey("page.worldOperation.common.length4000");
    int _jspx_eval_bean_message_12 = _jspx_th_bean_message_12.doStartTag();
    if (_jspx_th_bean_message_12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_12);
    return false;
  }

  private boolean _jspx_meth_bean_message_13(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_13 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_13.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_13.setParent(null);
    _jspx_th_bean_message_13.setBundle("pageResources");
    _jspx_th_bean_message_13.setKey("page.worldOperation.common.submit2");
    int _jspx_eval_bean_message_13 = _jspx_th_bean_message_13.doStartTag();
    if (_jspx_th_bean_message_13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_13);
    return false;
  }

  private boolean _jspx_meth_bean_message_14(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_14 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_14.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_14.setParent(null);
    _jspx_th_bean_message_14.setBundle("pageResources");
    _jspx_th_bean_message_14.setKey("page.worldOperation.common.back2");
    int _jspx_eval_bean_message_14 = _jspx_th_bean_message_14.doStartTag();
    if (_jspx_th_bean_message_14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_14);
    return false;
  }
}
