package org.apache.jsp.WEB_002dINF.jsp.roleCompensate;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class operAwardCompensate_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/roleCompensate/../inc/taglibs.jsp");
    _jspx_dependants.add("/WEB-INF/c.tld");
    _jspx_dependants.add("/WEB-INF/fmt.tld");
    _jspx_dependants.add("/WEB-INF/fn.tld");
    _jspx_dependants.add("/WEB-INF/gmweb.tld");
    _jspx_dependants.add("/WEB-INF/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/struts-bean.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_bean_message_key_bundle_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_if_test;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_fmt_formatDate_value_pattern_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_createCompenOperButton_passportName_operatorName_operType_methodType_compensateId_actionName_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_varStatus_var_items;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_approvalNum2Text_approvalNum_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_if_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_createCompenOperButton_passportName_operatorName_operType_methodType_compensateId_actionName_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_forEach_varStatus_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_approvalNum2Text_approvalNum_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
    _jspx_tagPool_c_if_test.release();
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.release();
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.release();
    _jspx_tagPool_gmweb_createCompenOperButton_passportName_operatorName_operType_methodType_compensateId_actionName_nobody.release();
    _jspx_tagPool_c_forEach_varStatus_var_items.release();
    _jspx_tagPool_gmweb_approvalNum2Text_approvalNum_nobody.release();
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
      out.write("\t<title>无标题文档</title>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td colspan=\"8\" align=\"center\" ></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td colspan=\"8\" align=\"center\" class=\"t_head\">");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t");
      if (_jspx_meth_c_if_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t</table>\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t");
      if (_jspx_meth_gmweb_createCompenOperButton_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t\t<td colspan=\"8\" align=\"center\" ></td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr>\r\n");
      out.write("\t\t\t\t\t<td colspan=\"12\" align=\"center\" class=\"t_head\">");
      if (_jspx_meth_bean_message_10(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t<tr height=\"23px\" class=\"h_CDE4F6\">\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
      if (_jspx_meth_bean_message_11(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
      if (_jspx_meth_bean_message_12(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
      if (_jspx_meth_bean_message_13(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
      if (_jspx_meth_bean_message_14(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
      if (_jspx_meth_bean_message_15(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
      if (_jspx_meth_bean_message_16(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t</tr>\r\n");
      out.write("\t\t\t\t");
      if (_jspx_meth_c_if_1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t\t  \t<td colspan=\"12\" align=\"center\" class=\"border_top\">&nbsp;&nbsp;&nbsp;\r\n");
      out.write("\t\t\t\t\t\t</td>\r\n");
      out.write("\t\t\t\t\t</tr>\r\n");
      out.write("\t\t\t</table>\r\n");
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.roleCompensate.operAwardCompensate.title1");
    int _jspx_eval_bean_message_0 = _jspx_th_bean_message_0.doStartTag();
    if (_jspx_th_bean_message_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_0);
    return false;
  }

  private boolean _jspx_meth_c_if_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_0 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_0.setPageContext(_jspx_page_context);
    _jspx_th_c_if_0.setParent(null);
    _jspx_th_c_if_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.awardCompensate }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_0 = _jspx_th_c_if_0.doStartTag();
    if (_jspx_eval_c_if_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_1(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.gatewayId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_2(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.activityId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_3(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.passportNames }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_4(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.items }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_5(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        if (_jspx_meth_fmt_formatDate_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_6(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        if (_jspx_meth_fmt_formatDate_1(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_7(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.reason }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_8(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.operatorName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\" width=\"30%\">");
        if (_jspx_meth_bean_message_9(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">\r\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_gmweb_approvalResult2Text_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"10px\">\r\n");
        out.write("\t\t\t  \t<td colspan=\"8\" align=\"center\" class=\"border_top\">&nbsp;&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t");
        int evalDoAfterBody = _jspx_th_c_if_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_1 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_1.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_1.setBundle("pageResources");
    _jspx_th_bean_message_1.setKey("page.roleCompensate.operAwardCompensate.gatewayId");
    int _jspx_eval_bean_message_1 = _jspx_th_bean_message_1.doStartTag();
    if (_jspx_th_bean_message_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_1);
    return false;
  }

  private boolean _jspx_meth_bean_message_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_2 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_2.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_2.setBundle("pageResources");
    _jspx_th_bean_message_2.setKey("page.roleCompensate.createAwardCompensate.activityId");
    int _jspx_eval_bean_message_2 = _jspx_th_bean_message_2.doStartTag();
    if (_jspx_th_bean_message_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_2);
    return false;
  }

  private boolean _jspx_meth_bean_message_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_3 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_3.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_3.setBundle("pageResources");
    _jspx_th_bean_message_3.setKey("page.roleCompensate.operAwardCompensate.passportNames");
    int _jspx_eval_bean_message_3 = _jspx_th_bean_message_3.doStartTag();
    if (_jspx_th_bean_message_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_3);
    return false;
  }

  private boolean _jspx_meth_bean_message_4(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_4 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_4.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_4.setBundle("pageResources");
    _jspx_th_bean_message_4.setKey("page.roleCompensate.operAwardCompensate.items");
    int _jspx_eval_bean_message_4 = _jspx_th_bean_message_4.doStartTag();
    if (_jspx_th_bean_message_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_4);
    return false;
  }

  private boolean _jspx_meth_bean_message_5(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_5 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_5.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_5.setBundle("pageResources");
    _jspx_th_bean_message_5.setKey("page.roleCompensate.operAwardCompensate.beginTime");
    int _jspx_eval_bean_message_5 = _jspx_th_bean_message_5.doStartTag();
    if (_jspx_th_bean_message_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_5);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_fmt_formatDate_0.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ requestScope.awardCompensate.beginTime}", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_0.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_0 = _jspx_th_fmt_formatDate_0.doStartTag();
    if (_jspx_th_fmt_formatDate_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_6(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_6 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_6.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_6.setBundle("pageResources");
    _jspx_th_bean_message_6.setKey("page.roleCompensate.operAwardCompensate.endTime");
    int _jspx_eval_bean_message_6 = _jspx_th_bean_message_6.doStartTag();
    if (_jspx_th_bean_message_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_6);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_1 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_1.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_fmt_formatDate_1.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ requestScope.awardCompensate.endTime}", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_1.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_1 = _jspx_th_fmt_formatDate_1.doStartTag();
    if (_jspx_th_fmt_formatDate_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_1);
    return false;
  }

  private boolean _jspx_meth_bean_message_7(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_7 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_7.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_7.setBundle("pageResources");
    _jspx_th_bean_message_7.setKey("page.roleCompensate.operAwardCompensate.reason");
    int _jspx_eval_bean_message_7 = _jspx_th_bean_message_7.doStartTag();
    if (_jspx_th_bean_message_7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_7);
    return false;
  }

  private boolean _jspx_meth_bean_message_8(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_8 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_8.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_8.setBundle("pageResources");
    _jspx_th_bean_message_8.setKey("page.roleCompensate.operAwardCompensate.operatorName");
    int _jspx_eval_bean_message_8 = _jspx_th_bean_message_8.doStartTag();
    if (_jspx_th_bean_message_8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_8);
    return false;
  }

  private boolean _jspx_meth_bean_message_9(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_9 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_9.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_9.setBundle("pageResources");
    _jspx_th_bean_message_9.setKey("page.roleCompensate.operAwardCompensate.approvalResult");
    int _jspx_eval_bean_message_9 = _jspx_th_bean_message_9.doStartTag();
    if (_jspx_th_bean_message_9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_9);
    return false;
  }

  private boolean _jspx_meth_gmweb_approvalResult2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:approvalResult2Text
    com.linekong.gmweb2.tld.ApprovalResult2TextTag _jspx_th_gmweb_approvalResult2Text_0 = (com.linekong.gmweb2.tld.ApprovalResult2TextTag) _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.get(com.linekong.gmweb2.tld.ApprovalResult2TextTag.class);
    _jspx_th_gmweb_approvalResult2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_approvalResult2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_gmweb_approvalResult2Text_0.setApprovalResult(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.approvalResult}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_approvalResult2Text_0 = _jspx_th_gmweb_approvalResult2Text_0.doStartTag();
    if (_jspx_th_gmweb_approvalResult2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.reuse(_jspx_th_gmweb_approvalResult2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_createCompenOperButton_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:createCompenOperButton
    com.linekong.gmweb2.tld.CreateCompenOperButtonTag _jspx_th_gmweb_createCompenOperButton_0 = (com.linekong.gmweb2.tld.CreateCompenOperButtonTag) _jspx_tagPool_gmweb_createCompenOperButton_passportName_operatorName_operType_methodType_compensateId_actionName_nobody.get(com.linekong.gmweb2.tld.CreateCompenOperButtonTag.class);
    _jspx_th_gmweb_createCompenOperButton_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_createCompenOperButton_0.setParent(null);
    _jspx_th_gmweb_createCompenOperButton_0.setOperType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.oper}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createCompenOperButton_0.setActionName("roleCompensate");
    _jspx_th_gmweb_createCompenOperButton_0.setOperatorName((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensate.operatorName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createCompenOperButton_0.setPassportName((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${sessionScope.userInfo.passportName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createCompenOperButton_0.setCompensateId(((java.lang.Long) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.compensateId}", java.lang.Long.class, (PageContext)_jspx_page_context, null, false)).longValue());
    _jspx_th_gmweb_createCompenOperButton_0.setMethodType("AwardCompensate");
    int _jspx_eval_gmweb_createCompenOperButton_0 = _jspx_th_gmweb_createCompenOperButton_0.doStartTag();
    if (_jspx_th_gmweb_createCompenOperButton_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_createCompenOperButton_passportName_operatorName_operType_methodType_compensateId_actionName_nobody.reuse(_jspx_th_gmweb_createCompenOperButton_0);
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
    _jspx_th_bean_message_10.setKey("page.roleCompensate.operAwardCompensate.title2");
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
    _jspx_th_bean_message_11.setKey("page.roleCompensate.common.index");
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
    _jspx_th_bean_message_12.setKey("page.roleCompensate.operAwardCompensate.approvalNum");
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
    _jspx_th_bean_message_13.setKey("page.roleCompensate.operAwardCompensate.operatorName2");
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
    _jspx_th_bean_message_14.setKey("page.roleCompensate.operAwardCompensate.approvalTime");
    int _jspx_eval_bean_message_14 = _jspx_th_bean_message_14.doStartTag();
    if (_jspx_th_bean_message_14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_14);
    return false;
  }

  private boolean _jspx_meth_bean_message_15(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_15 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_15.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_15.setParent(null);
    _jspx_th_bean_message_15.setBundle("pageResources");
    _jspx_th_bean_message_15.setKey("page.roleCompensate.operAwardCompensate.approvalComment");
    int _jspx_eval_bean_message_15 = _jspx_th_bean_message_15.doStartTag();
    if (_jspx_th_bean_message_15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_15);
    return false;
  }

  private boolean _jspx_meth_bean_message_16(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_16 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_16.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_16.setParent(null);
    _jspx_th_bean_message_16.setBundle("pageResources");
    _jspx_th_bean_message_16.setKey("page.roleCompensate.operAwardCompensate.approvalResult2");
    int _jspx_eval_bean_message_16 = _jspx_th_bean_message_16.doStartTag();
    if (_jspx_th_bean_message_16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_16);
    return false;
  }

  private boolean _jspx_meth_c_if_1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_1.setPageContext(_jspx_page_context);
    _jspx_th_c_if_1.setParent(null);
    _jspx_th_c_if_1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.awardCompensateLogList }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_1 = _jspx_th_c_if_1.doStartTag();
    if (_jspx_eval_c_if_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_forEach_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t");
        int evalDoAfterBody = _jspx_th_c_if_1.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_1);
    return false;
  }

  private boolean _jspx_meth_c_forEach_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_varStatus_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_0.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_c_forEach_0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.awardCompensateLogList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_0.setVar("awardCompensateLog");
    _jspx_th_c_forEach_0.setVarStatus("state");
    int[] _jspx_push_body_count_c_forEach_0 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_0 = _jspx_th_c_forEach_0.doStartTag();
      if (_jspx_eval_c_forEach_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t<tr height=\"23px\">\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${state.index + 1 }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_approvalNum2Text_0(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensateLog.operatorName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_2(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensateLog.approvalComment }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_approvalResult2Text_1(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_forEach_0.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_forEach_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
        return true;
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_forEach_0[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_forEach_0.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_forEach_0.doFinally();
      _jspx_tagPool_c_forEach_varStatus_var_items.reuse(_jspx_th_c_forEach_0);
    }
    return false;
  }

  private boolean _jspx_meth_gmweb_approvalNum2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:approvalNum2Text
    com.linekong.gmweb2.tld.ApprovalNum2TextTag _jspx_th_gmweb_approvalNum2Text_0 = (com.linekong.gmweb2.tld.ApprovalNum2TextTag) _jspx_tagPool_gmweb_approvalNum2Text_approvalNum_nobody.get(com.linekong.gmweb2.tld.ApprovalNum2TextTag.class);
    _jspx_th_gmweb_approvalNum2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_approvalNum2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_gmweb_approvalNum2Text_0.setApprovalNum(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensateLog.approvalNum}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_approvalNum2Text_0 = _jspx_th_gmweb_approvalNum2Text_0.doStartTag();
    if (_jspx_th_gmweb_approvalNum2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_approvalNum2Text_approvalNum_nobody.reuse(_jspx_th_gmweb_approvalNum2Text_0);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_2 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_2.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_fmt_formatDate_2.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ awardCompensateLog.approvalTime}", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_2.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_2 = _jspx_th_fmt_formatDate_2.doStartTag();
    if (_jspx_th_fmt_formatDate_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_2);
    return false;
  }

  private boolean _jspx_meth_gmweb_approvalResult2Text_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:approvalResult2Text
    com.linekong.gmweb2.tld.ApprovalResult2TextTag _jspx_th_gmweb_approvalResult2Text_1 = (com.linekong.gmweb2.tld.ApprovalResult2TextTag) _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.get(com.linekong.gmweb2.tld.ApprovalResult2TextTag.class);
    _jspx_th_gmweb_approvalResult2Text_1.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_approvalResult2Text_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_gmweb_approvalResult2Text_1.setApprovalResult(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensateLog.approvalResult}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_approvalResult2Text_1 = _jspx_th_gmweb_approvalResult2Text_1.doStartTag();
    if (_jspx_th_gmweb_approvalResult2Text_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.reuse(_jspx_th_gmweb_approvalResult2Text_1);
    return false;
  }
}
