package org.apache.jsp.WEB_002dINF.jsp.roleCompensate;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class awardCompensate_jsp extends org.apache.jasper.runtime.HttpJspBase
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
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_createCompenTitleButton_operType_methodType_actionName_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_varStatus_var_items;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_fmt_formatDate_value_pattern_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_createCompenOperLink_operType_methodType_compensateId_actionName_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_paginationInfo_recordCount_pageSize_pageNum_pageCount_currentPage_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_if_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_createCompenTitleButton_operType_methodType_actionName_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_forEach_varStatus_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_createCompenOperLink_operType_methodType_compensateId_actionName_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_paginationInfo_recordCount_pageSize_pageNum_pageCount_currentPage_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
    _jspx_tagPool_c_if_test.release();
    _jspx_tagPool_gmweb_createCompenTitleButton_operType_methodType_actionName_nobody.release();
    _jspx_tagPool_c_forEach_varStatus_var_items.release();
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.release();
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.release();
    _jspx_tagPool_gmweb_createCompenOperLink_operType_methodType_compensateId_actionName_nobody.release();
    _jspx_tagPool_gmweb_paginationInfo_recordCount_pageSize_pageNum_pageCount_currentPage_nobody.release();
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
      out.write("\t<head>\r\n");
      out.write("\t\t<link href=\"css/main.css\" rel=\"stylesheet\" type=\"text/css\" />\r\n");
      out.write("\t\t<meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\" />\r\n");
      out.write("\t\t<title>无标题文档</title>\r\n");
      out.write("\t\t<script type=\"text/javaScript\">\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\tfunction gotoPage(obj){\r\n");
      out.write("\t\t\t\tobj.submit();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tfunction apprSubmit(frm) \r\n");
      out.write("\t\t\t{ \r\n");
      out.write("\t\t\t\tfrm.action = \"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.apprType}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(".do\";\r\n");
      out.write("\t\t\t\tfrm.method = \"post\";\r\n");
      out.write("\t\t\t\tfrm.submit();\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tfunction checkAll(frm) \r\n");
      out.write("\t\t\t{ \r\n");
      out.write("\t\t\t\tfor (var i=0;i<frm.elements.length;i++) \r\n");
      out.write("\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\tvar e=frm.elements[i]; \r\n");
      out.write("\t\t\t\t\tif (e.type == 'checkbox' && frm.selectAll.value == '");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("') \r\n");
      out.write("\t\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\t\te.checked = true; \r\n");
      out.write("\t\t\t\t\t} \r\n");
      out.write("\t\t\t\t\telse if (e.type == 'checkbox' && frm.selectAll.value == '");
      if (_jspx_meth_bean_message_1(_jspx_page_context))
        return;
      out.write("'){\r\n");
      out.write("\t\t\t\t\t\te.checked = false; \r\n");
      out.write("\t\t\t\t\t} \r\n");
      out.write("\t\t\t\t} \r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\t\tif (frm.selectAll.value == '");
      if (_jspx_meth_bean_message_2(_jspx_page_context))
        return;
      out.write("'){\r\n");
      out.write("\t\t\t\t\tfrm.selectAll.value = '");
      if (_jspx_meth_bean_message_3(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("\t\t\t\t\tfrm.apprButton.disabled = false;\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\tfrm.selectAll.value = '");
      if (_jspx_meth_bean_message_4(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("\t\t\t\t\tfrm.apprButton.disabled = true;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tfunction uncheckAll(frm) \r\n");
      out.write("\t\t\t{ \r\n");
      out.write("\t\t\t\tvar TB=TO=0; \r\n");
      out.write("\t\t\t\tfor (var i=0;i<frm.elements.length;i++) \r\n");
      out.write("\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\tvar e=frm.elements[i]; \r\n");
      out.write("\t\t\t\t\tif (e.type == 'checkbox') \r\n");
      out.write("\t\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\t\tTB++; \r\n");
      out.write("\t\t\t\t\t\tif (e.checked){\r\n");
      out.write("\t\t\t\t\t\t\tTO++;\r\n");
      out.write("\t\t\t\t\t\t} \r\n");
      out.write("\t\t\t\t\t} \r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif (TB == TO){\r\n");
      out.write("\t\t\t\t\tfrm.selectAll.value = '");
      if (_jspx_meth_bean_message_5(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t\tfrm.selectAll.value = '");
      if (_jspx_meth_bean_message_6(_jspx_page_context))
        return;
      out.write("';\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t\tif (0==TO)//全部未选中和选中一些时对删除按钮的disabled属性的影响 \r\n");
      out.write("\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\tfrm.apprButton.disabled = true; \r\n");
      out.write("\t\t\t\t} \r\n");
      out.write("\t\t\t\telse \r\n");
      out.write("\t\t\t\t{ \r\n");
      out.write("\t\t\t\t\tfrm.apprButton.disabled = false; \r\n");
      out.write("\t\t\t\t} \r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\t\t} \r\n");
      out.write("\t\t\tfunction ok (obj){\r\n");
      out.write("\t\t\t\tif(confirm(\"确定删除\")){\r\n");
      out.write("\t\t\t\t\twindow.location.href='deleteActivityAwardComp.do?compensateId='+obj+'';\r\n");
      out.write("\t\t\t\t}else{\r\n");
      out.write("\t\t\t\t    return false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t</script>\r\n");
      out.write("\t</head>\r\n");
      out.write("\r\n");
      out.write("\t<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t\t");
      if (_jspx_meth_c_if_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t<div align=\"center\">\r\n");
      out.write("\t\t\t\t<font color=\"red\" size=\"3px\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</font>\r\n");
      out.write("\t\t\t</div>\r\n");
      out.write("\r\n");
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.roleCompensate.common.allSelect");
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
    _jspx_th_bean_message_1.setKey("page.roleCompensate.common.cancel");
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
    _jspx_th_bean_message_2.setKey("page.roleCompensate.common.allSelect");
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
    _jspx_th_bean_message_3.setKey("page.roleCompensate.common.cancel");
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
    _jspx_th_bean_message_4.setKey("page.roleCompensate.common.allSelect");
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
    _jspx_th_bean_message_5.setKey("page.roleCompensate.common.cancel");
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
    _jspx_th_bean_message_6.setKey("page.roleCompensate.common.allSelect");
    int _jspx_eval_bean_message_6 = _jspx_th_bean_message_6.doStartTag();
    if (_jspx_th_bean_message_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_6);
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
    _jspx_th_c_if_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.pageInfo }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_0 = _jspx_th_c_if_0.doStartTag();
    if (_jspx_eval_c_if_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t<form name=\"pageForm\" action=\"");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.operType }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write(".do\" method=\"post\">\r\n");
        out.write("\t\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\"\r\n");
        out.write("\t\t\t\talign=\"center\">\r\n");
        out.write("\t\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t\t<td colspan=\"7\" align=\"center\"></td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t\t<td colspan=\"7\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_createCompenTitleButton_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t<tr>\r\n");
        out.write("\t\t\t\t\t<td colspan=\"7\" align=\"center\" class=\"t_head\">\r\n");
        out.write("\t\t\t\t\t\t");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${title }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t<tr height=\"23px\" class=\"h_CDE4F6\">\r\n");
        out.write("\t\t\t\t\t<td width=\"10%\" align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_7(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_8(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_9(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_10(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_11(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_12(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_bean_message_13(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_forEach_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td colspan=\"7\" align=\"center\" class=\"t_border\">\r\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_gmweb_paginationInfo_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t");
        if (_jspx_meth_c_if_3(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t");
        if (_jspx_meth_c_if_4(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t</table>\r\n");
        out.write("\t\t</form>\r\n");
        out.write("\t\t\t<br />\r\n");
        out.write("\t\t");
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

  private boolean _jspx_meth_gmweb_createCompenTitleButton_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:createCompenTitleButton
    com.linekong.gmweb2.tld.CreateCompenTitleButtonTag _jspx_th_gmweb_createCompenTitleButton_0 = (com.linekong.gmweb2.tld.CreateCompenTitleButtonTag) _jspx_tagPool_gmweb_createCompenTitleButton_operType_methodType_actionName_nobody.get(com.linekong.gmweb2.tld.CreateCompenTitleButtonTag.class);
    _jspx_th_gmweb_createCompenTitleButton_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_createCompenTitleButton_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_gmweb_createCompenTitleButton_0.setOperType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.operType}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createCompenTitleButton_0.setActionName("roleCompensate");
    _jspx_th_gmweb_createCompenTitleButton_0.setMethodType("AwardCompensate");
    int _jspx_eval_gmweb_createCompenTitleButton_0 = _jspx_th_gmweb_createCompenTitleButton_0.doStartTag();
    if (_jspx_th_gmweb_createCompenTitleButton_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_createCompenTitleButton_operType_methodType_actionName_nobody.reuse(_jspx_th_gmweb_createCompenTitleButton_0);
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
    _jspx_th_bean_message_7.setKey("page.roleCompensate.common.select");
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
    _jspx_th_bean_message_8.setKey("page.roleCompensate.common.index");
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
    _jspx_th_bean_message_9.setKey("page.roleCompensate.awardCompensate.operatorName");
    int _jspx_eval_bean_message_9 = _jspx_th_bean_message_9.doStartTag();
    if (_jspx_th_bean_message_9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_9);
    return false;
  }

  private boolean _jspx_meth_bean_message_10(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_10 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_10.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_10.setBundle("pageResources");
    _jspx_th_bean_message_10.setKey("page.roleCompensate.awardCompensate.insertTime");
    int _jspx_eval_bean_message_10 = _jspx_th_bean_message_10.doStartTag();
    if (_jspx_th_bean_message_10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_10);
    return false;
  }

  private boolean _jspx_meth_bean_message_11(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_11 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_11.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_11.setBundle("pageResources");
    _jspx_th_bean_message_11.setKey("page.roleCompensate.awardCompensate.reason");
    int _jspx_eval_bean_message_11 = _jspx_th_bean_message_11.doStartTag();
    if (_jspx_th_bean_message_11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_11);
    return false;
  }

  private boolean _jspx_meth_bean_message_12(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_12 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_12.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_12.setBundle("pageResources");
    _jspx_th_bean_message_12.setKey("page.roleCompensate.awardCompensate.approvalResult");
    int _jspx_eval_bean_message_12 = _jspx_th_bean_message_12.doStartTag();
    if (_jspx_th_bean_message_12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_12);
    return false;
  }

  private boolean _jspx_meth_bean_message_13(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_13 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_13.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_bean_message_13.setBundle("pageResources");
    _jspx_th_bean_message_13.setKey("page.roleCompensate.common.oper");
    int _jspx_eval_bean_message_13 = _jspx_th_bean_message_13.doStartTag();
    if (_jspx_th_bean_message_13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_13);
    return false;
  }

  private boolean _jspx_meth_c_forEach_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_varStatus_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_0.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_c_forEach_0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageInfo.infoList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_0.setVar("awardCompensate");
    _jspx_th_c_forEach_0.setVarStatus("status");
    int[] _jspx_push_body_count_c_forEach_0 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_0 = _jspx_th_c_forEach_0.doStartTag();
      if (_jspx_eval_c_forEach_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\t<tr height=\"23px\">\r\n");
          out.write("\t\t\t\t\t\t<td width=\"10%\" align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t<input name=\"compensateId\" type=\"checkbox\" value=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.compensateId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("\" onclick=\"uncheckAll(document.forms[0]);\" ");
          if (_jspx_meth_c_if_1(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write(" />\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${status.index + 1 }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.operatorName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_fmt_formatDate_0(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.reason }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_approvalResult2Text_0(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_createCompenOperLink_0(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t      ");
          if (_jspx_meth_c_if_2(_jspx_th_c_forEach_0, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
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

  private boolean _jspx_meth_c_if_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_1.setPageContext(_jspx_page_context);
    _jspx_th_c_if_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_c_if_1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.apprType != 'batchFirstApprAwardCompensate' and requestScope.apprType != 'batchSecondApprAwardCompensate' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_1 = _jspx_th_c_if_1.doStartTag();
    if (_jspx_eval_c_if_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("disabled");
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

  private boolean _jspx_meth_fmt_formatDate_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_fmt_formatDate_0.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.insertTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_0.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_0 = _jspx_th_fmt_formatDate_0.doStartTag();
    if (_jspx_th_fmt_formatDate_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_approvalResult2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:approvalResult2Text
    com.linekong.gmweb2.tld.ApprovalResult2TextTag _jspx_th_gmweb_approvalResult2Text_0 = (com.linekong.gmweb2.tld.ApprovalResult2TextTag) _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.get(com.linekong.gmweb2.tld.ApprovalResult2TextTag.class);
    _jspx_th_gmweb_approvalResult2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_approvalResult2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_gmweb_approvalResult2Text_0.setApprovalResult(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.approvalResult}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_approvalResult2Text_0 = _jspx_th_gmweb_approvalResult2Text_0.doStartTag();
    if (_jspx_th_gmweb_approvalResult2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_approvalResult2Text_approvalResult_nobody.reuse(_jspx_th_gmweb_approvalResult2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_createCompenOperLink_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:createCompenOperLink
    com.linekong.gmweb2.tld.CreateCompenOperLinkTag _jspx_th_gmweb_createCompenOperLink_0 = (com.linekong.gmweb2.tld.CreateCompenOperLinkTag) _jspx_tagPool_gmweb_createCompenOperLink_operType_methodType_compensateId_actionName_nobody.get(com.linekong.gmweb2.tld.CreateCompenOperLinkTag.class);
    _jspx_th_gmweb_createCompenOperLink_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_createCompenOperLink_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_gmweb_createCompenOperLink_0.setOperType((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.operType}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createCompenOperLink_0.setActionName("roleCompensate");
    _jspx_th_gmweb_createCompenOperLink_0.setMethodType("AwardCompensate");
    _jspx_th_gmweb_createCompenOperLink_0.setCompensateId(((java.lang.Long) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.compensateId}", java.lang.Long.class, (PageContext)_jspx_page_context, null, false)).longValue());
    int _jspx_eval_gmweb_createCompenOperLink_0 = _jspx_th_gmweb_createCompenOperLink_0.doStartTag();
    if (_jspx_th_gmweb_createCompenOperLink_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_createCompenOperLink_operType_methodType_compensateId_actionName_nobody.reuse(_jspx_th_gmweb_createCompenOperLink_0);
    return false;
  }

  private boolean _jspx_meth_c_if_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_0, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_2.setPageContext(_jspx_page_context);
    _jspx_th_c_if_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_0);
    _jspx_th_c_if_2.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.state==0 or awardCompensate.state==1 or awardCompensate.state==2 or awardCompensate.state==100 }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_2 = _jspx_th_c_if_2.doStartTag();
    if (_jspx_eval_c_if_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t<a href =\"#\" onclick=\"ok(");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${awardCompensate.compensateId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write(");\">");
        if (_jspx_meth_bean_message_14(_jspx_th_c_if_2, _jspx_page_context, _jspx_push_body_count_c_forEach_0))
          return true;
        out.write("</a>\r\n");
        out.write("                          ");
        int evalDoAfterBody = _jspx_th_c_if_2.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_2);
    return false;
  }

  private boolean _jspx_meth_bean_message_14(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_2, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_0)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_14 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_14.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_2);
    _jspx_th_bean_message_14.setBundle("pageResources");
    _jspx_th_bean_message_14.setKey("page.common.del");
    int _jspx_eval_bean_message_14 = _jspx_th_bean_message_14.doStartTag();
    if (_jspx_th_bean_message_14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_14);
    return false;
  }

  private boolean _jspx_meth_gmweb_paginationInfo_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:paginationInfo
    com.linekong.gmweb2.tld.PaginationInfoTag _jspx_th_gmweb_paginationInfo_0 = (com.linekong.gmweb2.tld.PaginationInfoTag) _jspx_tagPool_gmweb_paginationInfo_recordCount_pageSize_pageNum_pageCount_currentPage_nobody.get(com.linekong.gmweb2.tld.PaginationInfoTag.class);
    _jspx_th_gmweb_paginationInfo_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_paginationInfo_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_gmweb_paginationInfo_0.setPageNum((int[]) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageNum }", int[].class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_paginationInfo_0.setCurrentPage(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageInfo.currentPage }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_paginationInfo_0.setPageSize(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageInfo.pageSize }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_paginationInfo_0.setRecordCount(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageInfo.recordCount }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_paginationInfo_0.setPageCount(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.pageInfo.pageCount }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_paginationInfo_0 = _jspx_th_gmweb_paginationInfo_0.doStartTag();
    if (_jspx_th_gmweb_paginationInfo_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_paginationInfo_recordCount_pageSize_pageNum_pageCount_currentPage_nobody.reuse(_jspx_th_gmweb_paginationInfo_0);
    return false;
  }

  private boolean _jspx_meth_c_if_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_3 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_3.setPageContext(_jspx_page_context);
    _jspx_th_c_if_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_c_if_3.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.operType == 'showAwardCompensate' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_3 = _jspx_th_c_if_3.doStartTag();
    if (_jspx_eval_c_if_3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td colspan=\"7\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input type=\"button\" value=\"");
        if (_jspx_meth_bean_message_15(_jspx_th_c_if_3, _jspx_page_context))
          return true;
        out.write("\" onclick=\"window.location.href='showCreateAwardCompensate.do'\" />\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t");
        int evalDoAfterBody = _jspx_th_c_if_3.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_3);
    return false;
  }

  private boolean _jspx_meth_bean_message_15(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_3, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_15 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_15.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_3);
    _jspx_th_bean_message_15.setBundle("pageResources");
    _jspx_th_bean_message_15.setKey("page.roleCompensate.awardCompensate.createAwardCompensate");
    int _jspx_eval_bean_message_15 = _jspx_th_bean_message_15.doStartTag();
    if (_jspx_th_bean_message_15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_15);
    return false;
  }

  private boolean _jspx_meth_c_if_4(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_4 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_4.setPageContext(_jspx_page_context);
    _jspx_th_c_if_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_c_if_4.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.apprType == 'batchFirstApprAwardCompensate' or requestScope.apprType == 'batchSecondApprAwardCompensate' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_4 = _jspx_th_c_if_4.doStartTag();
    if (_jspx_eval_c_if_4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td colspan=\"7\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input id=\"selectAll\" name=\"selectAll\" type=\"button\" value=\"");
        if (_jspx_meth_bean_message_16(_jspx_th_c_if_4, _jspx_page_context))
          return true;
        out.write("\" onclick=\"checkAll(document.forms[0]);\" />&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t\t<input name=\"apprButton\" type=\"button\" value=\"");
        if (_jspx_meth_bean_message_17(_jspx_th_c_if_4, _jspx_page_context))
          return true;
        out.write("\" onclick=\"apprSubmit(document.forms[0]);\" disabled/>\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t");
        int evalDoAfterBody = _jspx_th_c_if_4.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_c_if_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_if_test.reuse(_jspx_th_c_if_4);
    return false;
  }

  private boolean _jspx_meth_bean_message_16(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_16 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_16.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_4);
    _jspx_th_bean_message_16.setBundle("pageResources");
    _jspx_th_bean_message_16.setKey("page.roleCompensate.common.allSelect");
    int _jspx_eval_bean_message_16 = _jspx_th_bean_message_16.doStartTag();
    if (_jspx_th_bean_message_16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_16);
    return false;
  }

  private boolean _jspx_meth_bean_message_17(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_17 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_17.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_4);
    _jspx_th_bean_message_17.setBundle("pageResources");
    _jspx_th_bean_message_17.setKey("page.roleCompensate.common.batchApprAward");
    int _jspx_eval_bean_message_17 = _jspx_th_bean_message_17.doStartTag();
    if (_jspx_th_bean_message_17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_17);
    return false;
  }
}
