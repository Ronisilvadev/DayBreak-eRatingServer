package org.apache.jsp.WEB_002dINF.jsp.worldOperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class addActivityModel_jsp extends org.apache.jasper.runtime.HttpJspBase
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

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_html_javascript_formName_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_if_test;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_bean_message_key_bundle_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_html_errors_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_html_form_onsubmit_method_action;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_createGatewayCheckboxActivityTag_showAllGateway_name_gatewayList_checkedValue_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_fmt_formatDate_value_pattern_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_html_javascript_formName_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_if_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_html_errors_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_html_form_onsubmit_method_action = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_createGatewayCheckboxActivityTag_showAllGateway_name_gatewayList_checkedValue_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_html_javascript_formName_nobody.release();
    _jspx_tagPool_c_if_test.release();
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
    _jspx_tagPool_html_errors_nobody.release();
    _jspx_tagPool_html_form_onsubmit_method_action.release();
    _jspx_tagPool_gmweb_createGatewayCheckboxActivityTag_showAllGateway_name_gatewayList_checkedValue_nobody.release();
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.release();
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
      out.write("\t<title></title>\r\n");
      out.write("\t<script type=\"text/javascript\" src=\"js/calendar/WdatePicker.js\"></script>\r\n");
      out.write("\t");
      if (_jspx_meth_html_javascript_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t<script type=\"text/javascript\">\r\n");
      out.write("\t\tfunction displayRoleTime(){\r\n");
      out.write("\t\t\tvar actType = document.getElementById('activityType').value; \r\n");
      out.write("\t\t\tif(actType == 3){\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = \"\";\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t}else if(actType == 1){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 8){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 9){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 10){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 11){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 12){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 14){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 15){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 16){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 5){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 6){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else if(actType == 7){\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = \"\";\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t}else{\r\n");
      out.write("\t\t\t\troleBeginTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\troleEndTimeTr.style.display = 'none';\r\n");
      out.write("\t\t\t\tgatewayIdTr.style.display = 'none';\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tif(actType!=1){\r\n");
      out.write("\t\t\t\tisMutexTr.style.display = 'none';\r\n");
      out.write("\t\t\t\tdocument.getElementById('isMutex').value = 0;\r\n");
      out.write("\t\t\t}else{\r\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_c_if_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t\t");
      if (_jspx_meth_c_if_1(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\tdocument.getElementById('isMutex').value = 1;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tif (actType != 3) {\r\n");
      out.write("\t\t\t\tdocument.getElementsByName('gatewayId').value = 0;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\tvar tipControl = document.getElementById(\"tiptext\") ;\r\n");
      out.write("\t\t\tif(actType == 5){\r\n");
      out.write("\t\t\t\ttipControl.innerText = '");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("' ;\r\n");
      out.write("\t\t\t}else if(actType == 6){\r\n");
      out.write("\t\t\t\ttipControl.innerText = '");
      if (_jspx_meth_bean_message_1(_jspx_page_context))
        return;
      out.write("' ;\r\n");
      out.write("\t\t\t}else if(actType == 7){\r\n");
      out.write("\t\t\t\ttipControl.innerText = '");
      if (_jspx_meth_bean_message_2(_jspx_page_context))
        return;
      out.write("' ;\r\n");
      out.write("\t\t\t}else{\r\n");
      out.write("\t\t\t\ttipControl.innerText = '';\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t}\r\n");
      out.write("\t\t\t\t\r\n");
      out.write("\t\tfunction check(pram){\r\n");
      out.write("\t\t\t//begin\t验证活动名称长度\r\n");
      out.write("\t\t\tvar activityName=document.getElementById('activityName');\r\n");
      out.write("\t\t\tif(activityName.value.length>32){\r\n");
      out.write("\t\t\t\talert('");
      if (_jspx_meth_bean_message_3(_jspx_page_context))
        return;
      if (_jspx_meth_bean_message_4(_jspx_page_context))
        return;
      out.write("');\r\n");
      out.write("\t\t\t\treturn false;\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t//end\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\tvar activityType=document.getElementById('activityType');\r\n");
      out.write("\t\t\tif(activityType.value==3){\r\n");
      out.write("\t\t\t\tvar roleBeginTime=document.getElementById('roleBeginTime');\r\n");
      out.write("\t\t\t\tvar roleEndTime=document.getElementById('roleEndTime');\r\n");
      out.write("\t\t\t\tif(roleBeginTime.value==\"\"||roleEndTime.value==\"\"){\r\n");
      out.write("\t\t\t\t\talert(\"");
      if (_jspx_meth_bean_message_5(_jspx_page_context))
        return;
      out.write("\");\r\n");
      out.write("\t\t\t\t\treturn false;\r\n");
      out.write("\t\t\t\t}\r\n");
      out.write("\t\t\t}\r\n");
      out.write("\t\t\t\r\n");
      out.write("\t\t\r\n");
      out.write("\t\t\treturn validateAddActivityModelForm(pram);\t\t\t\r\n");
      out.write("\t\t}\t\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t<div align=\"center\">\r\n");
      out.write("\t\t<font color=\"red\" size=\"3px\">");
      if (_jspx_meth_html_errors_0(_jspx_page_context))
        return;
      out.write("</font>\r\n");
      out.write("\t\t<font color=\"red\" size=\"3px\">");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("</font>\r\n");
      out.write("\t</div>\r\n");
      out.write("\r\n");
      out.write("\t");
      if (_jspx_meth_html_form_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\r\n");
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

  private boolean _jspx_meth_html_javascript_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:javascript
    org.apache.struts.taglib.html.JavascriptValidatorTag _jspx_th_html_javascript_0 = (org.apache.struts.taglib.html.JavascriptValidatorTag) _jspx_tagPool_html_javascript_formName_nobody.get(org.apache.struts.taglib.html.JavascriptValidatorTag.class);
    _jspx_th_html_javascript_0.setPageContext(_jspx_page_context);
    _jspx_th_html_javascript_0.setParent(null);
    _jspx_th_html_javascript_0.setFormName("/addActivityModel");
    int _jspx_eval_html_javascript_0 = _jspx_th_html_javascript_0.doStartTag();
    if (_jspx_th_html_javascript_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_html_javascript_formName_nobody.reuse(_jspx_th_html_javascript_0);
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
    _jspx_th_c_if_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.version=='old' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_0 = _jspx_th_c_if_0.doStartTag();
    if (_jspx_eval_c_if_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\tisMutexTr.style.display = '';\r\n");
        out.write("\t\t\t\t\t");
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

  private boolean _jspx_meth_c_if_1(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_1 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_1.setPageContext(_jspx_page_context);
    _jspx_th_c_if_1.setParent(null);
    _jspx_th_c_if_1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.version=='new' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_1 = _jspx_th_c_if_1.doStartTag();
    if (_jspx_eval_c_if_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\tisMutexTr.style.display = 'none';\r\n");
        out.write("\t\t\t\t\t");
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.worldOperation.addActivityModel.type5.tip");
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
    _jspx_th_bean_message_1.setKey("page.worldOperation.addActivityModel.type6.tip");
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
    _jspx_th_bean_message_2.setKey("page.worldOperation.addActivityModel.type7.tip");
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
    _jspx_th_bean_message_3.setKey("page.worldOperation.addSerialActivity.activityName");
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
    _jspx_th_bean_message_4.setKey("page.worldOperation.activityModelConfig.activityNameTip");
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
    _jspx_th_bean_message_5.setKey("page.worldOperation.addActivityModel.roleTimeMustbeNotnull");
    int _jspx_eval_bean_message_5 = _jspx_th_bean_message_5.doStartTag();
    if (_jspx_th_bean_message_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_5);
    return false;
  }

  private boolean _jspx_meth_html_errors_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:errors
    org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_errors_0 = (org.apache.struts.taglib.html.ErrorsTag) _jspx_tagPool_html_errors_nobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
    _jspx_th_html_errors_0.setPageContext(_jspx_page_context);
    _jspx_th_html_errors_0.setParent(null);
    int _jspx_eval_html_errors_0 = _jspx_th_html_errors_0.doStartTag();
    if (_jspx_th_html_errors_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_html_errors_nobody.reuse(_jspx_th_html_errors_0);
    return false;
  }

  private boolean _jspx_meth_html_form_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:form
    org.apache.struts.taglib.html.FormTag _jspx_th_html_form_0 = (org.apache.struts.taglib.html.FormTag) _jspx_tagPool_html_form_onsubmit_method_action.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_form_0.setPageContext(_jspx_page_context);
    _jspx_th_html_form_0.setParent(null);
    _jspx_th_html_form_0.setAction("addActivityModel.do");
    _jspx_th_html_form_0.setMethod("post");
    _jspx_th_html_form_0.setOnsubmit("return check(this);");
    int _jspx_eval_html_form_0 = _jspx_th_html_form_0.doStartTag();
    if (_jspx_eval_html_form_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
        out.write("\t\t\t<tr>\r\n");
        out.write("\t\t\t\t<td align=\"center\" height=\"30PX\" colspan=\"2\"></td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_head\" colspan=\"2\">");
        if (_jspx_meth_bean_message_6(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\t\t\t\t\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_7(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"activityId\" type=\"text\"/>\r\n");
        out.write("\t\t\t\t \t<span class=\"tip\">");
        if (_jspx_meth_bean_message_8(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</span>\r\n");
        out.write("\t\t\t\t </td>\t\t\t\t \r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_9(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"activityName\" id=\"activityName\" type=\"text\" />\r\n");
        out.write("\t\t\t\t \t<span class=\"tip\">");
        if (_jspx_meth_bean_message_10(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</span>\r\n");
        out.write("\t\t\t\t </td>\t\t\t\t \r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_11(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<select id=\"activityType\" name=\"activityType\" onchange=\"displayRoleTime()\" style=\"width: 132px\">\r\n");
        out.write("\t\t\t\t \t\t<option value=\"1\">");
        if (_jspx_meth_bean_message_12(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"3\">");
        if (_jspx_meth_bean_message_13(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"5\">");
        if (_jspx_meth_bean_message_14(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"6\">");
        if (_jspx_meth_bean_message_15(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"7\">");
        if (_jspx_meth_bean_message_16(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\t\t\t\t\t\t\r\n");
        out.write("\t\t\t\t\t \t<option value=\"9\">");
        if (_jspx_meth_bean_message_17(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"10\">");
        if (_jspx_meth_bean_message_18(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"11\">");
        if (_jspx_meth_bean_message_19(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"12\">");
        if (_jspx_meth_bean_message_20(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"14\">");
        if (_jspx_meth_bean_message_21(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"15\">");
        if (_jspx_meth_bean_message_22(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"16\">");
        if (_jspx_meth_bean_message_23(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\t\r\n");
        out.write("\t\t\t\t \t</select>&nbsp;&nbsp;<div style=\"display: inline;\"><b><font id=\"tiptext\" color=\"red\"></font></b></div>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr id=\"gatewayIdTr\" height=\"30px\" >\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_24(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：</td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t");
        if (_jspx_meth_gmweb_createGatewayCheckboxActivityTag_0(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("<br/>\r\n");
        out.write("\t\t\t\t\t<span class=\"tip\">");
        if (_jspx_meth_bean_message_25(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</span>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\t\t\t\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_26(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"beginTime\" type=\"text\" readonly onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\" value=\"");
        if (_jspx_meth_fmt_formatDate_0(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\"/>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_27(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"endTime\" type=\"text\" readonly onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\" value=\"");
        if (_jspx_meth_fmt_formatDate_1(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\"/>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_28(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"giftBeginTime\" type=\"text\" readonly onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\" value=\"");
        if (_jspx_meth_fmt_formatDate_2(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\"/>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_29(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"giftEndTime\" type=\"text\" readonly onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\" value=\"");
        if (_jspx_meth_fmt_formatDate_3(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\"/>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr id=\"roleBeginTimeTr\" height=\"30px\" style=\"display:none\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_30(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"roleBeginTime\" id=\"roleBeginTime\" readonly type=\"text\" onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\"/>\r\n");
        out.write("\t\t\t\t \t<span class=\"tip\">");
        if (_jspx_meth_bean_message_31(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</span>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr id=\"roleEndTimeTr\" height=\"30px\" style=\"display:none\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_32(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<input name=\"roleEndTime\" id=\"roleEndTime\" type=\"text\" readonly onfocus=\"WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})\"/>\r\n");
        out.write("\t\t\t\t \t<span class=\"tip\">");
        if (_jspx_meth_bean_message_33(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</span>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t\r\n");
        out.write("\t\t\t<tr id=\"isMutexTr\" height=\"30px\" style=\"");
        if (_jspx_meth_c_if_2(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_34(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("：\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t \t<select id=\"isMutex\" name=\"isMutex\">\r\n");
        out.write("\t\t\t\t \t\t<option value=\"1\">");
        if (_jspx_meth_bean_message_35(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t\t<option value=\"0\">");
        if (_jspx_meth_bean_message_36(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t \t</select>\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;\" colspan=\"2\">\r\n");
        out.write("\t\t\t\t\t<input name=\"version\" type=\"hidden\" value=\"");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.version}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("\" />&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t\t<input type=\"submit\" value=\" ");
        if (_jspx_meth_bean_message_37(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write(" \" style=\"margin-left: 34%\"/>&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t\t<input type=\"button\" value=\" ");
        if (_jspx_meth_bean_message_38(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write(" \" onclick=\"window.location.href='showActivityModel.do?version=");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.version}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("'\"/>\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t</table>\r\n");
        out.write("\t\t");
        int evalDoAfterBody = _jspx_th_html_form_0.doAfterBody();
        if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
          break;
      } while (true);
    }
    if (_jspx_th_html_form_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_html_form_onsubmit_method_action.reuse(_jspx_th_html_form_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_6(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_6 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_6.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_6.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_6.setBundle("pageResources");
    _jspx_th_bean_message_6.setKey("page.worldOperation.addSerialActivity.title");
    int _jspx_eval_bean_message_6 = _jspx_th_bean_message_6.doStartTag();
    if (_jspx_th_bean_message_6.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_6);
    return false;
  }

  private boolean _jspx_meth_bean_message_7(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_7 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_7.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_7.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_7.setBundle("pageResources");
    _jspx_th_bean_message_7.setKey("page.worldOperation.addSerialActivity.activityId");
    int _jspx_eval_bean_message_7 = _jspx_th_bean_message_7.doStartTag();
    if (_jspx_th_bean_message_7.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_7);
    return false;
  }

  private boolean _jspx_meth_bean_message_8(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_8 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_8.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_8.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_8.setBundle("pageResources");
    _jspx_th_bean_message_8.setKey("page.worldOperation.activityModelConfig.activityIdTip");
    int _jspx_eval_bean_message_8 = _jspx_th_bean_message_8.doStartTag();
    if (_jspx_th_bean_message_8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_8);
    return false;
  }

  private boolean _jspx_meth_bean_message_9(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_9 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_9.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_9.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_9.setBundle("pageResources");
    _jspx_th_bean_message_9.setKey("page.worldOperation.addSerialActivity.activityName");
    int _jspx_eval_bean_message_9 = _jspx_th_bean_message_9.doStartTag();
    if (_jspx_th_bean_message_9.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_9);
    return false;
  }

  private boolean _jspx_meth_bean_message_10(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_10 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_10.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_10.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_10.setBundle("pageResources");
    _jspx_th_bean_message_10.setKey("page.worldOperation.activityModelConfig.activityNameTip");
    int _jspx_eval_bean_message_10 = _jspx_th_bean_message_10.doStartTag();
    if (_jspx_th_bean_message_10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_10);
    return false;
  }

  private boolean _jspx_meth_bean_message_11(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_11 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_11.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_11.setBundle("pageResources");
    _jspx_th_bean_message_11.setKey("page.worldOperation.addSerialActivity.activityType");
    int _jspx_eval_bean_message_11 = _jspx_th_bean_message_11.doStartTag();
    if (_jspx_th_bean_message_11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_11);
    return false;
  }

  private boolean _jspx_meth_bean_message_12(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_12 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_12.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_12.setBundle("pageResources");
    _jspx_th_bean_message_12.setKey("page.worldOperation.addSerialActivity.activityType1");
    int _jspx_eval_bean_message_12 = _jspx_th_bean_message_12.doStartTag();
    if (_jspx_th_bean_message_12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_12);
    return false;
  }

  private boolean _jspx_meth_bean_message_13(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_13 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_13.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_13.setBundle("pageResources");
    _jspx_th_bean_message_13.setKey("page.worldOperation.addSerialActivity.activityType3");
    int _jspx_eval_bean_message_13 = _jspx_th_bean_message_13.doStartTag();
    if (_jspx_th_bean_message_13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_13);
    return false;
  }

  private boolean _jspx_meth_bean_message_14(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_14 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_14.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_14.setBundle("pageResources");
    _jspx_th_bean_message_14.setKey("page.worldOperation.addSerialActivity.activityType5");
    int _jspx_eval_bean_message_14 = _jspx_th_bean_message_14.doStartTag();
    if (_jspx_th_bean_message_14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_14);
    return false;
  }

  private boolean _jspx_meth_bean_message_15(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_15 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_15.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_15.setBundle("pageResources");
    _jspx_th_bean_message_15.setKey("page.worldOperation.addSerialActivity.activityType6");
    int _jspx_eval_bean_message_15 = _jspx_th_bean_message_15.doStartTag();
    if (_jspx_th_bean_message_15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_15);
    return false;
  }

  private boolean _jspx_meth_bean_message_16(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_16 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_16.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_16.setBundle("pageResources");
    _jspx_th_bean_message_16.setKey("page.worldOperation.addSerialActivity.activityType7");
    int _jspx_eval_bean_message_16 = _jspx_th_bean_message_16.doStartTag();
    if (_jspx_th_bean_message_16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_16);
    return false;
  }

  private boolean _jspx_meth_bean_message_17(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_17 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_17.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_17.setBundle("pageResources");
    _jspx_th_bean_message_17.setKey("page.worldOperation.addSerialActivity.activityType9");
    int _jspx_eval_bean_message_17 = _jspx_th_bean_message_17.doStartTag();
    if (_jspx_th_bean_message_17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_17);
    return false;
  }

  private boolean _jspx_meth_bean_message_18(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_18 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_18.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_18.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_18.setBundle("pageResources");
    _jspx_th_bean_message_18.setKey("page.worldOperation.addSerialActivity.activityType10");
    int _jspx_eval_bean_message_18 = _jspx_th_bean_message_18.doStartTag();
    if (_jspx_th_bean_message_18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_18);
    return false;
  }

  private boolean _jspx_meth_bean_message_19(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_19 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_19.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_19.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_19.setBundle("pageResources");
    _jspx_th_bean_message_19.setKey("page.worldOperation.addSerialActivity.activityType11");
    int _jspx_eval_bean_message_19 = _jspx_th_bean_message_19.doStartTag();
    if (_jspx_th_bean_message_19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_19);
    return false;
  }

  private boolean _jspx_meth_bean_message_20(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_20 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_20.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_20.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_20.setBundle("pageResources");
    _jspx_th_bean_message_20.setKey("page.worldOperation.addSerialActivity.activityType12");
    int _jspx_eval_bean_message_20 = _jspx_th_bean_message_20.doStartTag();
    if (_jspx_th_bean_message_20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_20);
    return false;
  }

  private boolean _jspx_meth_bean_message_21(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_21 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_21.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_21.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_21.setBundle("pageResources");
    _jspx_th_bean_message_21.setKey("page.worldOperation.addSerialActivity.activityType14");
    int _jspx_eval_bean_message_21 = _jspx_th_bean_message_21.doStartTag();
    if (_jspx_th_bean_message_21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_21);
    return false;
  }

  private boolean _jspx_meth_bean_message_22(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_22 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_22.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_22.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_22.setBundle("pageResources");
    _jspx_th_bean_message_22.setKey("page.worldOperation.addSerialActivity.activityType15");
    int _jspx_eval_bean_message_22 = _jspx_th_bean_message_22.doStartTag();
    if (_jspx_th_bean_message_22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_22);
    return false;
  }

  private boolean _jspx_meth_bean_message_23(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_23 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_23.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_23.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_23.setBundle("pageResources");
    _jspx_th_bean_message_23.setKey("page.worldOperation.addSerialActivity.activityType16");
    int _jspx_eval_bean_message_23 = _jspx_th_bean_message_23.doStartTag();
    if (_jspx_th_bean_message_23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_23);
    return false;
  }

  private boolean _jspx_meth_bean_message_24(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_24 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_24.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_24.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_24.setBundle("pageResources");
    _jspx_th_bean_message_24.setKey("page.common.gatewayId");
    int _jspx_eval_bean_message_24 = _jspx_th_bean_message_24.doStartTag();
    if (_jspx_th_bean_message_24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_24);
    return false;
  }

  private boolean _jspx_meth_gmweb_createGatewayCheckboxActivityTag_0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:createGatewayCheckboxActivityTag
    com.linekong.gmweb2.tld.CreateGatewayCheckboxActivityTag _jspx_th_gmweb_createGatewayCheckboxActivityTag_0 = (com.linekong.gmweb2.tld.CreateGatewayCheckboxActivityTag) _jspx_tagPool_gmweb_createGatewayCheckboxActivityTag_showAllGateway_name_gatewayList_checkedValue_nobody.get(com.linekong.gmweb2.tld.CreateGatewayCheckboxActivityTag.class);
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setName("gatewayId");
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setCheckedValue(0);
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setGatewayList((java.util.ArrayList) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.gatewayList}", java.util.ArrayList.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.setShowAllGateway(1);
    int _jspx_eval_gmweb_createGatewayCheckboxActivityTag_0 = _jspx_th_gmweb_createGatewayCheckboxActivityTag_0.doStartTag();
    if (_jspx_th_gmweb_createGatewayCheckboxActivityTag_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_createGatewayCheckboxActivityTag_showAllGateway_name_gatewayList_checkedValue_nobody.reuse(_jspx_th_gmweb_createGatewayCheckboxActivityTag_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_25(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_25 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_25.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_25.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_25.setBundle("pageResources");
    _jspx_th_bean_message_25.setKey("page.worldOperation.activityModelConfig.gatewayIdTip");
    int _jspx_eval_bean_message_25 = _jspx_th_bean_message_25.doStartTag();
    if (_jspx_th_bean_message_25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_25);
    return false;
  }

  private boolean _jspx_meth_bean_message_26(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_26 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_26.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_26.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_26.setBundle("pageResources");
    _jspx_th_bean_message_26.setKey("page.worldOperation.addSerialActivity.beginTime");
    int _jspx_eval_bean_message_26 = _jspx_th_bean_message_26.doStartTag();
    if (_jspx_th_bean_message_26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_26);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_fmt_formatDate_0.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.beginTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_0.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_0 = _jspx_th_fmt_formatDate_0.doStartTag();
    if (_jspx_th_fmt_formatDate_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_27(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_27 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_27.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_27.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_27.setBundle("pageResources");
    _jspx_th_bean_message_27.setKey("page.worldOperation.addSerialActivity.endTime");
    int _jspx_eval_bean_message_27 = _jspx_th_bean_message_27.doStartTag();
    if (_jspx_th_bean_message_27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_27);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_1 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_1.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_fmt_formatDate_1.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.endTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_1.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_1 = _jspx_th_fmt_formatDate_1.doStartTag();
    if (_jspx_th_fmt_formatDate_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_1);
    return false;
  }

  private boolean _jspx_meth_bean_message_28(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_28 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_28.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_28.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_28.setBundle("pageResources");
    _jspx_th_bean_message_28.setKey("page.worldOperation.addSerialActivity.giftBeginTime");
    int _jspx_eval_bean_message_28 = _jspx_th_bean_message_28.doStartTag();
    if (_jspx_th_bean_message_28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_28);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_2 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_2.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_fmt_formatDate_2.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.giftBeginTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_2.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_2 = _jspx_th_fmt_formatDate_2.doStartTag();
    if (_jspx_th_fmt_formatDate_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_2);
    return false;
  }

  private boolean _jspx_meth_bean_message_29(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_29 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_29.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_29.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_29.setBundle("pageResources");
    _jspx_th_bean_message_29.setKey("page.worldOperation.addSerialActivity.giftEndTime");
    int _jspx_eval_bean_message_29 = _jspx_th_bean_message_29.doStartTag();
    if (_jspx_th_bean_message_29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_29);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_3 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_3.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_fmt_formatDate_3.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.endTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_3.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_3 = _jspx_th_fmt_formatDate_3.doStartTag();
    if (_jspx_th_fmt_formatDate_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_3);
    return false;
  }

  private boolean _jspx_meth_bean_message_30(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_30 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_30.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_30.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_30.setBundle("pageResources");
    _jspx_th_bean_message_30.setKey("page.worldOperation.addSerialActivity.roleBeginTime");
    int _jspx_eval_bean_message_30 = _jspx_th_bean_message_30.doStartTag();
    if (_jspx_th_bean_message_30.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_30);
    return false;
  }

  private boolean _jspx_meth_bean_message_31(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_31 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_31.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_31.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_31.setBundle("pageResources");
    _jspx_th_bean_message_31.setKey("page.worldOperation.addActivityModel.roleTimeMustbeNotnull");
    int _jspx_eval_bean_message_31 = _jspx_th_bean_message_31.doStartTag();
    if (_jspx_th_bean_message_31.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_31);
    return false;
  }

  private boolean _jspx_meth_bean_message_32(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_32 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_32.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_32.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_32.setBundle("pageResources");
    _jspx_th_bean_message_32.setKey("page.worldOperation.addSerialActivity.roleEndTime");
    int _jspx_eval_bean_message_32 = _jspx_th_bean_message_32.doStartTag();
    if (_jspx_th_bean_message_32.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_32);
    return false;
  }

  private boolean _jspx_meth_bean_message_33(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_33 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_33.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_33.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_33.setBundle("pageResources");
    _jspx_th_bean_message_33.setKey("page.worldOperation.addActivityModel.roleTimeMustbeNotnull");
    int _jspx_eval_bean_message_33 = _jspx_th_bean_message_33.doStartTag();
    if (_jspx_th_bean_message_33.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_33);
    return false;
  }

  private boolean _jspx_meth_c_if_2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_2.setPageContext(_jspx_page_context);
    _jspx_th_c_if_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_c_if_2.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.version=='new' }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_2 = _jspx_th_c_if_2.doStartTag();
    if (_jspx_eval_c_if_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("display:none");
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

  private boolean _jspx_meth_bean_message_34(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_34 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_34.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_34.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_34.setBundle("pageResources");
    _jspx_th_bean_message_34.setKey("page.worldOperation.addSerialActivity.isMutex");
    int _jspx_eval_bean_message_34 = _jspx_th_bean_message_34.doStartTag();
    if (_jspx_th_bean_message_34.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_34);
    return false;
  }

  private boolean _jspx_meth_bean_message_35(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_35 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_35.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_35.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_35.setBundle("pageResources");
    _jspx_th_bean_message_35.setKey("page.worldOperation.addSerialActivity.isMutexType1");
    int _jspx_eval_bean_message_35 = _jspx_th_bean_message_35.doStartTag();
    if (_jspx_th_bean_message_35.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_35);
    return false;
  }

  private boolean _jspx_meth_bean_message_36(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_36 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_36.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_36.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_36.setBundle("pageResources");
    _jspx_th_bean_message_36.setKey("page.worldOperation.addSerialActivity.isMutexType0");
    int _jspx_eval_bean_message_36 = _jspx_th_bean_message_36.doStartTag();
    if (_jspx_th_bean_message_36.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_36);
    return false;
  }

  private boolean _jspx_meth_bean_message_37(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_37 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_37.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_37.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_37.setBundle("pageResources");
    _jspx_th_bean_message_37.setKey("page.worldOperation.common.submit2");
    int _jspx_eval_bean_message_37 = _jspx_th_bean_message_37.doStartTag();
    if (_jspx_th_bean_message_37.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_37);
    return false;
  }

  private boolean _jspx_meth_bean_message_38(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_38 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_38.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_38.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_38.setBundle("pageResources");
    _jspx_th_bean_message_38.setKey("page.worldOperation.common.back2");
    int _jspx_eval_bean_message_38 = _jspx_th_bean_message_38.doStartTag();
    if (_jspx_th_bean_message_38.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_38);
    return false;
  }
}
