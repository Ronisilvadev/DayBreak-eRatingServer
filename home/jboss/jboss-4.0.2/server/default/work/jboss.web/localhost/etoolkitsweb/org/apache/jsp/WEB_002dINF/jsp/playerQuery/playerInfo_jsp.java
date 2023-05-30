package org.apache.jsp.WEB_002dINF.jsp.playerQuery;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class playerInfo_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/playerQuery/../inc/taglibs.jsp");
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
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_html_form_onsubmit_method_action;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_var_items;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_html_errors_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_playerType2Text_playerType_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_idVerifyFlag2Text_idVerifyFlag_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_promoterId2Text_promoterId_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_playerFlag2Text_playerFlag_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_playerState2Text_state_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_varStatus_var_items;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_out_value_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_roleGender2Text_roleGender_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_roleState2Text_roleState_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_fmt_formatDate_value_pattern_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_second2Text_second_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_freezeState2Text_state_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_fmt_formatNumber_value_pattern_nobody;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_if_test = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_html_form_onsubmit_method_action = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_forEach_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_html_errors_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_playerType2Text_playerType_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_idVerifyFlag2Text_idVerifyFlag_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_promoterId2Text_promoterId_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_playerFlag2Text_playerFlag_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_playerState2Text_state_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_forEach_varStatus_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_out_value_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_roleGender2Text_roleGender_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_roleState2Text_roleState_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_second2Text_second_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_freezeState2Text_state_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_fmt_formatNumber_value_pattern_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
    _jspx_tagPool_c_if_test.release();
    _jspx_tagPool_html_form_onsubmit_method_action.release();
    _jspx_tagPool_c_forEach_var_items.release();
    _jspx_tagPool_html_errors_nobody.release();
    _jspx_tagPool_gmweb_playerType2Text_playerType_nobody.release();
    _jspx_tagPool_gmweb_idVerifyFlag2Text_idVerifyFlag_nobody.release();
    _jspx_tagPool_gmweb_promoterId2Text_promoterId_nobody.release();
    _jspx_tagPool_gmweb_playerFlag2Text_playerFlag_nobody.release();
    _jspx_tagPool_gmweb_playerState2Text_state_nobody.release();
    _jspx_tagPool_c_forEach_varStatus_var_items.release();
    _jspx_tagPool_c_out_value_nobody.release();
    _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody.release();
    _jspx_tagPool_gmweb_roleGender2Text_roleGender_nobody.release();
    _jspx_tagPool_gmweb_roleState2Text_roleState_nobody.release();
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.release();
    _jspx_tagPool_gmweb_second2Text_second_nobody.release();
    _jspx_tagPool_gmweb_freezeState2Text_state_nobody.release();
    _jspx_tagPool_fmt_formatNumber_value_pattern_nobody.release();
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
      out.write("\t\r\n");
      out.write("\t<script type=\"text/javaScript\">\r\n");
      out.write("\tString.prototype.trim=function(){ \r\n");
      out.write("\t\treturn this.replace(/(^\\s*)|(\\s*$)/g, \"\"); \r\n");
      out.write("\t} \r\n");
      out.write("\tfunction check(){\r\n");
      out.write("\t\tvar playerName = document.getElementById('playerName').value;\r\n");
      out.write("\t\tvar playerId = document.getElementById('playerId').value;\r\n");
      out.write("\t\tvar roleName = document.getElementById('roleName').value;\r\n");
      out.write("\t\tvar roleId = document.getElementById('roleId').value;\r\n");
      out.write("\t\tvar sum = playerName.trim() + playerId.trim() + roleName.trim() + roleId.trim();\r\n");
      out.write("\t\tif(sum.length>0){\r\n");
      out.write("\t\t\treturn true;\r\n");
      out.write("\t\t}else{\r\n");
      out.write("\t\t\talert('");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("');\r\n");
      out.write("\t\t\treturn false;\r\n");
      out.write("\t\t}\r\n");
      out.write("\t}\r\n");
      out.write("\t</script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t");
      if (_jspx_meth_c_if_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\r\n");
      out.write("\t");
      if (_jspx_meth_c_if_1(_jspx_page_context))
        return;
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

  private boolean _jspx_meth_bean_message_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_0 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_0.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_0.setParent(null);
    _jspx_th_bean_message_0.setBundle("pageResources");
    _jspx_th_bean_message_0.setKey("page.playerQuery.playerinfo.submit");
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
    _jspx_th_c_if_0.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${empty requestScope.playerInfo }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_0 = _jspx_th_c_if_0.doStartTag();
    if (_jspx_eval_c_if_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t");
        if (_jspx_meth_html_form_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t<div align=\"center\">\r\n");
        out.write("\t\t\t<font color=\"red\" size=\"3px\">");
        if (_jspx_meth_html_errors_0(_jspx_th_c_if_0, _jspx_page_context))
          return true;
        out.write(" </font>\r\n");
        out.write("\t\t\t<font color=\"red\" size=\"3px\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${msg }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</font>\r\n");
        out.write("\t\t</div>\r\n");
        out.write("\t");
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

  private boolean _jspx_meth_html_form_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:form
    org.apache.struts.taglib.html.FormTag _jspx_th_html_form_0 = (org.apache.struts.taglib.html.FormTag) _jspx_tagPool_html_form_onsubmit_method_action.get(org.apache.struts.taglib.html.FormTag.class);
    _jspx_th_html_form_0.setPageContext(_jspx_page_context);
    _jspx_th_html_form_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    _jspx_th_html_form_0.setAction("getPlayerInfo.do");
    _jspx_th_html_form_0.setMethod("post");
    _jspx_th_html_form_0.setOnsubmit("return check();");
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
        if (_jspx_meth_bean_message_1(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write(" </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;padding-left:50px\" align=\"center\" colspan=\"2\">\r\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_bean_message_2(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t </td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_3(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input name=\"playerName\" type=\"text\" style=\"width:200px\" />\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_4(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input name=\"playerId\" type=\"text\" style=\"width:200px\" />\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_5(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input name=\"roleName\" type=\"text\" style=\"width:200px\" />\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr><tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_6(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<input name=\"roleId\" type=\"text\" style=\"width:200px\" />\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
        if (_jspx_meth_bean_message_7(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" align=\"left\">\r\n");
        out.write("\t\t\t\t\t<select name=\"gatewayId\" style=\"width:200px\">\r\n");
        out.write("\t\t\t\t\t\t<option value=\"0\">0 - ");
        if (_jspx_meth_bean_message_8(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("</option>\r\n");
        out.write("\t\t\t\t  \t\t");
        if (_jspx_meth_c_forEach_0(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</select>\r\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_bean_message_9(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;\" align=\"center\" colspan=\"2\">\r\n");
        out.write("\t\t\t\t\t<input name=\"search\" type=\"submit\" value=\"");
        if (_jspx_meth_bean_message_10(_jspx_th_html_form_0, _jspx_page_context))
          return true;
        out.write("\" />\r\n");
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

  private boolean _jspx_meth_bean_message_1(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_1 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_1.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_1.setBundle("pageResources");
    _jspx_th_bean_message_1.setKey("page.playerQuery.playerinfo.title");
    int _jspx_eval_bean_message_1 = _jspx_th_bean_message_1.doStartTag();
    if (_jspx_th_bean_message_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_1);
    return false;
  }

  private boolean _jspx_meth_bean_message_2(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_2 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_2.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_2.setBundle("pageResources");
    _jspx_th_bean_message_2.setKey("page.playerQuery.playerinfo.queryType");
    int _jspx_eval_bean_message_2 = _jspx_th_bean_message_2.doStartTag();
    if (_jspx_th_bean_message_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_2);
    return false;
  }

  private boolean _jspx_meth_bean_message_3(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_3 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_3.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_3.setBundle("pageResources");
    _jspx_th_bean_message_3.setKey("page.common.passport");
    int _jspx_eval_bean_message_3 = _jspx_th_bean_message_3.doStartTag();
    if (_jspx_th_bean_message_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_3);
    return false;
  }

  private boolean _jspx_meth_bean_message_4(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_4 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_4.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_4.setBundle("pageResources");
    _jspx_th_bean_message_4.setKey("page.common.passportID");
    int _jspx_eval_bean_message_4 = _jspx_th_bean_message_4.doStartTag();
    if (_jspx_th_bean_message_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_4);
    return false;
  }

  private boolean _jspx_meth_bean_message_5(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_5 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_5.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_5.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_bean_message_5.setBundle("pageResources");
    _jspx_th_bean_message_5.setKey("page.common.roleName");
    int _jspx_eval_bean_message_5 = _jspx_th_bean_message_5.doStartTag();
    if (_jspx_th_bean_message_5.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_5);
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
    _jspx_th_bean_message_6.setKey("page.common.roleID");
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
    _jspx_th_bean_message_7.setKey("page.common.gatewayId");
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
    _jspx_th_bean_message_8.setKey("page.common.allServer");
    int _jspx_eval_bean_message_8 = _jspx_th_bean_message_8.doStartTag();
    if (_jspx_th_bean_message_8.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_8);
    return false;
  }

  private boolean _jspx_meth_c_forEach_0(javax.servlet.jsp.tagext.JspTag _jspx_th_html_form_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_0.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_html_form_0);
    _jspx_th_c_forEach_0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.gatewayList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_0.setVar("gateway");
    int[] _jspx_push_body_count_c_forEach_0 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_0 = _jspx_th_c_forEach_0.doStartTag();
      if (_jspx_eval_c_forEach_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t  \t\t\t<option value=\"");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${gateway.gatewayId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write('"');
          out.write('>');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${gateway.gatewayId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write(' ');
          out.write('-');
          out.write(' ');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${gateway.gatewayName}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</option>\r\n");
          out.write("\t\t\t\t  \t\t");
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
      _jspx_tagPool_c_forEach_var_items.reuse(_jspx_th_c_forEach_0);
    }
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
    _jspx_th_bean_message_9.setKey("page.playerQuery.playerinfo.queryInfo");
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
    _jspx_th_bean_message_10.setKey("page.common.submit");
    int _jspx_eval_bean_message_10 = _jspx_th_bean_message_10.doStartTag();
    if (_jspx_th_bean_message_10.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_10);
    return false;
  }

  private boolean _jspx_meth_html_errors_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_0, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  html:errors
    org.apache.struts.taglib.html.ErrorsTag _jspx_th_html_errors_0 = (org.apache.struts.taglib.html.ErrorsTag) _jspx_tagPool_html_errors_nobody.get(org.apache.struts.taglib.html.ErrorsTag.class);
    _jspx_th_html_errors_0.setPageContext(_jspx_page_context);
    _jspx_th_html_errors_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_0);
    int _jspx_eval_html_errors_0 = _jspx_th_html_errors_0.doStartTag();
    if (_jspx_th_html_errors_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_html_errors_nobody.reuse(_jspx_th_html_errors_0);
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
    _jspx_th_c_if_1.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.playerInfo }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_1 = _jspx_th_c_if_1.doStartTag();
    if (_jspx_eval_c_if_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
        out.write("\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t<td colspan=\"6\" align=\"center\" ></td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr>\r\n");
        out.write("\t\t\t\t<td colspan=\"6\" align=\"center\" class=\"t_head\">\r\n");
        out.write("\t\t\t\t\t");
        if (_jspx_meth_bean_message_11(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        if (_jspx_meth_bean_message_12(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\" class=\"h_CDE4F6\">\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_13(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_14(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_15(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_16(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_17(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        if (_jspx_meth_bean_message_18(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t\t<tr height=\"23px\">\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.playerId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_playerType2Text_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("&nbsp;\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_idVerifyFlag2Text_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_promoterId2Text_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_playerFlag2Text_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">\r\n");
        out.write("\t\t\t\t\t\t");
        if (_jspx_meth_gmweb_playerState2Text_0(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t  \t<td colspan=\"6\" align=\"center\" class=\"border_top\">&nbsp;&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t</td>\r\n");
        out.write("\t\t\t</tr>\r\n");
        out.write("\t\t</table>\r\n");
        out.write("\t\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
        out.write("\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t\t<td colspan=\"8\" align=\"center\" ></td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t<tr>\r\n");
        out.write("\t\t\t\t\t<td colspan=\"14\" align=\"center\" class=\"t_head\">");
        if (_jspx_meth_bean_message_19(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write(' ');
        out.write('"');
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write('"');
        out.write(' ');
        if (_jspx_meth_bean_message_20(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t\r\n");
        out.write("\t\t\t\t<tr height=\"23px\" class=\"h_CDE4F6\">\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_21(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_22(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_23(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_24(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_25(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_26(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_27(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_28(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_29(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_30(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_31(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_32(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_33(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        if (_jspx_meth_bean_message_34(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_if_2(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t\t  \t<td colspan=\"14\" align=\"center\" class=\"border_top\">&nbsp;&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t</table>\r\n");
        out.write("\t\r\n");
        out.write("\t\t\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
        out.write("\t\t\t\t<tr height=\"30px\">\r\n");
        out.write("\t\t\t\t\t<td colspan=\"9\" align=\"center\" ></td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t<tr>\r\n");
        out.write("\t\t\t\t\t<td colspan=\"9\" align=\"center\" class=\"t_head\">");
        if (_jspx_meth_bean_message_35(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write(' ');
        out.write('"');
        out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
        out.write('"');
        out.write(' ');
        if (_jspx_meth_bean_message_36(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t\r\n");
        out.write("\t\t\t\t<tr height=\"23px\" class=\"h_CDE4F6\">\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_37(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_38(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_39(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_40(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_41(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_42(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
        if (_jspx_meth_bean_message_43(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
        if (_jspx_meth_bean_message_44(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t\t\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_if_4(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t<tr height=\"5px\">\r\n");
        out.write("\t\t\t\t\t  \t<td colspan=\"9\" align=\"center\" class=\"border_top\">&nbsp;&nbsp;&nbsp;\r\n");
        out.write("\t\t\t\t\t\t</td>\r\n");
        out.write("\t\t\t\t</tr>\r\n");
        out.write("\t\t\t</table>\r\n");
        out.write("\r\n");
        out.write("\t\t\t\t<div align=\"center\">\r\n");
        out.write("\t\t\t\t\t<input type=\"button\" value=\"");
        if (_jspx_meth_bean_message_45(_jspx_th_c_if_1, _jspx_page_context))
          return true;
        out.write("\" onclick=\"window.location.href='showQueryPlayerInfo.do'\"/>\r\n");
        out.write("\t\t\t\t</div>\r\n");
        out.write("\t");
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

  private boolean _jspx_meth_bean_message_11(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_11 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_11.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_11.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_11.setBundle("pageResources");
    _jspx_th_bean_message_11.setKey("page.playerQuery.accountDetail.player");
    int _jspx_eval_bean_message_11 = _jspx_th_bean_message_11.doStartTag();
    if (_jspx_th_bean_message_11.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_11);
    return false;
  }

  private boolean _jspx_meth_bean_message_12(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_12 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_12.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_12.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_12.setBundle("pageResources");
    _jspx_th_bean_message_12.setKey("page.playerQuery.playerinfo.playerInfo");
    int _jspx_eval_bean_message_12 = _jspx_th_bean_message_12.doStartTag();
    if (_jspx_th_bean_message_12.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_12);
    return false;
  }

  private boolean _jspx_meth_bean_message_13(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_13 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_13.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_13.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_13.setBundle("pageResources");
    _jspx_th_bean_message_13.setKey("page.common.ID");
    int _jspx_eval_bean_message_13 = _jspx_th_bean_message_13.doStartTag();
    if (_jspx_th_bean_message_13.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_13);
    return false;
  }

  private boolean _jspx_meth_bean_message_14(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_14 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_14.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_14.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_14.setBundle("pageResources");
    _jspx_th_bean_message_14.setKey("page.playerQuery.chargeDetail.type");
    int _jspx_eval_bean_message_14 = _jspx_th_bean_message_14.doStartTag();
    if (_jspx_th_bean_message_14.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_14);
    return false;
  }

  private boolean _jspx_meth_bean_message_15(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_15 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_15.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_15.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_15.setBundle("pageResources");
    _jspx_th_bean_message_15.setKey("page.playerQuery.playerinfo.playerInfoValidate");
    int _jspx_eval_bean_message_15 = _jspx_th_bean_message_15.doStartTag();
    if (_jspx_th_bean_message_15.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_15);
    return false;
  }

  private boolean _jspx_meth_bean_message_16(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_16 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_16.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_16.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_16.setBundle("pageResources");
    _jspx_th_bean_message_16.setKey("page.playerQuery.playerinfo.tuiguangID");
    int _jspx_eval_bean_message_16 = _jspx_th_bean_message_16.doStartTag();
    if (_jspx_th_bean_message_16.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_16);
    return false;
  }

  private boolean _jspx_meth_bean_message_17(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_17 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_17.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_17.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_17.setBundle("pageResources");
    _jspx_th_bean_message_17.setKey("page.playerQuery.playerinfo.kuozhanFlag");
    int _jspx_eval_bean_message_17 = _jspx_th_bean_message_17.doStartTag();
    if (_jspx_th_bean_message_17.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_17);
    return false;
  }

  private boolean _jspx_meth_bean_message_18(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_18 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_18.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_18.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_18.setBundle("pageResources");
    _jspx_th_bean_message_18.setKey("page.playerQuery.orderStatus.orderState");
    int _jspx_eval_bean_message_18 = _jspx_th_bean_message_18.doStartTag();
    if (_jspx_th_bean_message_18.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_18);
    return false;
  }

  private boolean _jspx_meth_gmweb_playerType2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:playerType2Text
    com.linekong.gmweb2.tld.PlayerType2TextTag _jspx_th_gmweb_playerType2Text_0 = (com.linekong.gmweb2.tld.PlayerType2TextTag) _jspx_tagPool_gmweb_playerType2Text_playerType_nobody.get(com.linekong.gmweb2.tld.PlayerType2TextTag.class);
    _jspx_th_gmweb_playerType2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_playerType2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_gmweb_playerType2Text_0.setPlayerType(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.playerType}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_playerType2Text_0 = _jspx_th_gmweb_playerType2Text_0.doStartTag();
    if (_jspx_th_gmweb_playerType2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_playerType2Text_playerType_nobody.reuse(_jspx_th_gmweb_playerType2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_idVerifyFlag2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:idVerifyFlag2Text
    com.linekong.gmweb2.tld.IdVerifyFlag2TextTag _jspx_th_gmweb_idVerifyFlag2Text_0 = (com.linekong.gmweb2.tld.IdVerifyFlag2TextTag) _jspx_tagPool_gmweb_idVerifyFlag2Text_idVerifyFlag_nobody.get(com.linekong.gmweb2.tld.IdVerifyFlag2TextTag.class);
    _jspx_th_gmweb_idVerifyFlag2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_idVerifyFlag2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_gmweb_idVerifyFlag2Text_0.setIdVerifyFlag(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.idVerifyFlag}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_idVerifyFlag2Text_0 = _jspx_th_gmweb_idVerifyFlag2Text_0.doStartTag();
    if (_jspx_th_gmweb_idVerifyFlag2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_idVerifyFlag2Text_idVerifyFlag_nobody.reuse(_jspx_th_gmweb_idVerifyFlag2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_promoterId2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:promoterId2Text
    com.linekong.gmweb2.tld.PromoterId2TextTag _jspx_th_gmweb_promoterId2Text_0 = (com.linekong.gmweb2.tld.PromoterId2TextTag) _jspx_tagPool_gmweb_promoterId2Text_promoterId_nobody.get(com.linekong.gmweb2.tld.PromoterId2TextTag.class);
    _jspx_th_gmweb_promoterId2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_promoterId2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_gmweb_promoterId2Text_0.setPromoterId(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.promoterId}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_promoterId2Text_0 = _jspx_th_gmweb_promoterId2Text_0.doStartTag();
    if (_jspx_th_gmweb_promoterId2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_promoterId2Text_promoterId_nobody.reuse(_jspx_th_gmweb_promoterId2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_playerFlag2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:playerFlag2Text
    com.linekong.gmweb2.tld.PlayerFlag2TextTag _jspx_th_gmweb_playerFlag2Text_0 = (com.linekong.gmweb2.tld.PlayerFlag2TextTag) _jspx_tagPool_gmweb_playerFlag2Text_playerFlag_nobody.get(com.linekong.gmweb2.tld.PlayerFlag2TextTag.class);
    _jspx_th_gmweb_playerFlag2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_playerFlag2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_gmweb_playerFlag2Text_0.setPlayerFlag(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.playerFlag}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_playerFlag2Text_0 = _jspx_th_gmweb_playerFlag2Text_0.doStartTag();
    if (_jspx_th_gmweb_playerFlag2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_playerFlag2Text_playerFlag_nobody.reuse(_jspx_th_gmweb_playerFlag2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_playerState2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:playerState2Text
    com.linekong.gmweb2.tld.PlayerState2TextTag _jspx_th_gmweb_playerState2Text_0 = (com.linekong.gmweb2.tld.PlayerState2TextTag) _jspx_tagPool_gmweb_playerState2Text_state_nobody.get(com.linekong.gmweb2.tld.PlayerState2TextTag.class);
    _jspx_th_gmweb_playerState2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_playerState2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_gmweb_playerState2Text_0.setState((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${playerInfo.strPlayerState}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_gmweb_playerState2Text_0 = _jspx_th_gmweb_playerState2Text_0.doStartTag();
    if (_jspx_th_gmweb_playerState2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_playerState2Text_state_nobody.reuse(_jspx_th_gmweb_playerState2Text_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_19(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_19 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_19.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_19.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_19.setBundle("pageResources");
    _jspx_th_bean_message_19.setKey("page.playerQuery.accountDetail.player");
    int _jspx_eval_bean_message_19 = _jspx_th_bean_message_19.doStartTag();
    if (_jspx_th_bean_message_19.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_19);
    return false;
  }

  private boolean _jspx_meth_bean_message_20(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_20 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_20.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_20.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_20.setBundle("pageResources");
    _jspx_th_bean_message_20.setKey("page.playerQuery.playerinfo.roleInfo");
    int _jspx_eval_bean_message_20 = _jspx_th_bean_message_20.doStartTag();
    if (_jspx_th_bean_message_20.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_20);
    return false;
  }

  private boolean _jspx_meth_bean_message_21(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_21 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_21.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_21.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_21.setBundle("pageResources");
    _jspx_th_bean_message_21.setKey("page.common.gameId");
    int _jspx_eval_bean_message_21 = _jspx_th_bean_message_21.doStartTag();
    if (_jspx_th_bean_message_21.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_21);
    return false;
  }

  private boolean _jspx_meth_bean_message_22(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_22 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_22.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_22.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_22.setBundle("pageResources");
    _jspx_th_bean_message_22.setKey("page.common.ID");
    int _jspx_eval_bean_message_22 = _jspx_th_bean_message_22.doStartTag();
    if (_jspx_th_bean_message_22.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_22);
    return false;
  }

  private boolean _jspx_meth_bean_message_23(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_23 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_23.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_23.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_23.setBundle("pageResources");
    _jspx_th_bean_message_23.setKey("page.playerQuery.playerinfo.roleName");
    int _jspx_eval_bean_message_23 = _jspx_th_bean_message_23.doStartTag();
    if (_jspx_th_bean_message_23.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_23);
    return false;
  }

  private boolean _jspx_meth_bean_message_24(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_24 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_24.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_24.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_24.setBundle("pageResources");
    _jspx_th_bean_message_24.setKey("page.playerQuery.accountDetail.gateway");
    int _jspx_eval_bean_message_24 = _jspx_th_bean_message_24.doStartTag();
    if (_jspx_th_bean_message_24.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_24);
    return false;
  }

  private boolean _jspx_meth_bean_message_25(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_25 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_25.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_25.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_25.setBundle("pageResources");
    _jspx_th_bean_message_25.setKey("page.playerQuery.playerinfo.country");
    int _jspx_eval_bean_message_25 = _jspx_th_bean_message_25.doStartTag();
    if (_jspx_th_bean_message_25.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_25);
    return false;
  }

  private boolean _jspx_meth_bean_message_26(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_26 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_26.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_26.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_26.setBundle("pageResources");
    _jspx_th_bean_message_26.setKey("page.common.sex");
    int _jspx_eval_bean_message_26 = _jspx_th_bean_message_26.doStartTag();
    if (_jspx_th_bean_message_26.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_26);
    return false;
  }

  private boolean _jspx_meth_bean_message_27(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_27 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_27.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_27.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_27.setBundle("pageResources");
    _jspx_th_bean_message_27.setKey("page.playerQuery.occuptationTotal.job");
    int _jspx_eval_bean_message_27 = _jspx_th_bean_message_27.doStartTag();
    if (_jspx_th_bean_message_27.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_27);
    return false;
  }

  private boolean _jspx_meth_bean_message_28(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_28 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_28.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_28.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_28.setBundle("pageResources");
    _jspx_th_bean_message_28.setKey("page.common.lv");
    int _jspx_eval_bean_message_28 = _jspx_th_bean_message_28.doStartTag();
    if (_jspx_th_bean_message_28.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_28);
    return false;
  }

  private boolean _jspx_meth_bean_message_29(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_29 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_29.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_29.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_29.setBundle("pageResources");
    _jspx_th_bean_message_29.setKey("page.playerQuery.orderStatus.orderState");
    int _jspx_eval_bean_message_29 = _jspx_th_bean_message_29.doStartTag();
    if (_jspx_th_bean_message_29.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_29);
    return false;
  }

  private boolean _jspx_meth_bean_message_30(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_30 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_30.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_30.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_30.setBundle("pageResources");
    _jspx_th_bean_message_30.setKey("page.common.createTime");
    int _jspx_eval_bean_message_30 = _jspx_th_bean_message_30.doStartTag();
    if (_jspx_th_bean_message_30.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_30);
    return false;
  }

  private boolean _jspx_meth_bean_message_31(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_31 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_31.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_31.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_31.setBundle("pageResources");
    _jspx_th_bean_message_31.setKey("page.playerQuery.playerinfo.roleFirstLoginIP");
    int _jspx_eval_bean_message_31 = _jspx_th_bean_message_31.doStartTag();
    if (_jspx_th_bean_message_31.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_31);
    return false;
  }

  private boolean _jspx_meth_bean_message_32(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_32 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_32.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_32.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_32.setBundle("pageResources");
    _jspx_th_bean_message_32.setKey("page.common.delTime");
    int _jspx_eval_bean_message_32 = _jspx_th_bean_message_32.doStartTag();
    if (_jspx_th_bean_message_32.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_32);
    return false;
  }

  private boolean _jspx_meth_bean_message_33(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_33 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_33.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_33.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_33.setBundle("pageResources");
    _jspx_th_bean_message_33.setKey("page.playerQuery.accountDetail.logoutTime");
    int _jspx_eval_bean_message_33 = _jspx_th_bean_message_33.doStartTag();
    if (_jspx_th_bean_message_33.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_33);
    return false;
  }

  private boolean _jspx_meth_bean_message_34(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_34 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_34.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_34.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_34.setBundle("pageResources");
    _jspx_th_bean_message_34.setKey("page.playerQuery.accountDetail.onlineTime");
    int _jspx_eval_bean_message_34 = _jspx_th_bean_message_34.doStartTag();
    if (_jspx_th_bean_message_34.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_34);
    return false;
  }

  private boolean _jspx_meth_c_if_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_2 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_2.setPageContext(_jspx_page_context);
    _jspx_th_c_if_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_c_if_2.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.roleInfoList }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_2 = _jspx_th_c_if_2.doStartTag();
    if (_jspx_eval_c_if_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_forEach_1(_jspx_th_c_if_2, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t");
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

  private boolean _jspx_meth_c_forEach_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_2, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_1 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_1.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_2);
    _jspx_th_c_forEach_1.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.roleInfoList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_1.setVar("roleInfo");
    int[] _jspx_push_body_count_c_forEach_1 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_1 = _jspx_th_c_forEach_1.doStartTag();
      if (_jspx_eval_c_forEach_1 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t<tr height=\"23px\">\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.gameId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("-\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_c_forEach_2(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_c_out_1(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.gatewayId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_roleOccupationAndNation2Text_0(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_roleGender2Text_0(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_roleOccupationAndNation2Text_1(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleLevel }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">\r\n");
          out.write("\t\t\t\t\t\t\t");
          if (_jspx_meth_gmweb_roleState2Text_0(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_0(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">&nbsp;");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.firstLoginIp }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_1(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("&nbsp;</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_2(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("&nbsp;</td>\r\n");
          out.write("\t\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
          if (_jspx_meth_gmweb_second2Text_0(_jspx_th_c_forEach_1, _jspx_page_context, _jspx_push_body_count_c_forEach_1))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_forEach_1.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_forEach_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
        return true;
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_forEach_1[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_forEach_1.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_forEach_1.doFinally();
      _jspx_tagPool_c_forEach_var_items.reuse(_jspx_th_c_forEach_1);
    }
    return false;
  }

  private boolean _jspx_meth_c_forEach_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_2 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_varStatus_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_2.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_c_forEach_2.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.gameMap}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_2.setVar("gamePojo");
    _jspx_th_c_forEach_2.setVarStatus("gameStatus");
    int[] _jspx_push_body_count_c_forEach_2 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_2 = _jspx_th_c_forEach_2.doStartTag();
      if (_jspx_eval_c_forEach_2 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\t\t");
          if (_jspx_meth_c_if_3(_jspx_th_c_forEach_2, _jspx_page_context, _jspx_push_body_count_c_forEach_2))
            return true;
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_forEach_2.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_forEach_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
        return true;
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_forEach_2[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_forEach_2.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_forEach_2.doFinally();
      _jspx_tagPool_c_forEach_varStatus_var_items.reuse(_jspx_th_c_forEach_2);
    }
    return false;
  }

  private boolean _jspx_meth_c_if_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_2, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_2)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_3 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_3.setPageContext(_jspx_page_context);
    _jspx_th_c_if_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_2);
    _jspx_th_c_if_3.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.gameId==gamePojo.key}", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_3 = _jspx_th_c_if_3.doStartTag();
    if (_jspx_eval_c_if_3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t\t");
        if (_jspx_meth_c_out_0(_jspx_th_c_if_3, _jspx_page_context, _jspx_push_body_count_c_forEach_2))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t\t\t\t\t");
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

  private boolean _jspx_meth_c_out_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_3, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_2)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:out
    org.apache.taglibs.standard.tag.rt.core.OutTag _jspx_th_c_out_0 = (org.apache.taglibs.standard.tag.rt.core.OutTag) _jspx_tagPool_c_out_value_nobody.get(org.apache.taglibs.standard.tag.rt.core.OutTag.class);
    _jspx_th_c_out_0.setPageContext(_jspx_page_context);
    _jspx_th_c_out_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_3);
    _jspx_th_c_out_0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${gamePojo.value}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_c_out_0 = _jspx_th_c_out_0.doStartTag();
    if (_jspx_th_c_out_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_out_value_nobody.reuse(_jspx_th_c_out_0);
    return false;
  }

  private boolean _jspx_meth_c_out_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:out
    org.apache.taglibs.standard.tag.rt.core.OutTag _jspx_th_c_out_1 = (org.apache.taglibs.standard.tag.rt.core.OutTag) _jspx_tagPool_c_out_value_nobody.get(org.apache.taglibs.standard.tag.rt.core.OutTag.class);
    _jspx_th_c_out_1.setPageContext(_jspx_page_context);
    _jspx_th_c_out_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_c_out_1.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleName}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_c_out_1 = _jspx_th_c_out_1.doStartTag();
    if (_jspx_th_c_out_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_c_out_value_nobody.reuse(_jspx_th_c_out_1);
    return false;
  }

  private boolean _jspx_meth_gmweb_roleOccupationAndNation2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:roleOccupationAndNation2Text
    com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag _jspx_th_gmweb_roleOccupationAndNation2Text_0 = (com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag) _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody.get(com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag.class);
    _jspx_th_gmweb_roleOccupationAndNation2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_roleOccupationAndNation2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_gmweb_roleOccupationAndNation2Text_0.setKey(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.nationalityId }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_roleOccupationAndNation2Text_0.setValueMap((java.util.Map) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.leagueMap }", java.util.Map.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_gmweb_roleOccupationAndNation2Text_0 = _jspx_th_gmweb_roleOccupationAndNation2Text_0.doStartTag();
    if (_jspx_th_gmweb_roleOccupationAndNation2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody.reuse(_jspx_th_gmweb_roleOccupationAndNation2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_roleGender2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:roleGender2Text
    com.linekong.gmweb2.tld.RoleGender2TextTag _jspx_th_gmweb_roleGender2Text_0 = (com.linekong.gmweb2.tld.RoleGender2TextTag) _jspx_tagPool_gmweb_roleGender2Text_roleGender_nobody.get(com.linekong.gmweb2.tld.RoleGender2TextTag.class);
    _jspx_th_gmweb_roleGender2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_roleGender2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_gmweb_roleGender2Text_0.setRoleGender(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleGender }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_roleGender2Text_0 = _jspx_th_gmweb_roleGender2Text_0.doStartTag();
    if (_jspx_th_gmweb_roleGender2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_roleGender2Text_roleGender_nobody.reuse(_jspx_th_gmweb_roleGender2Text_0);
    return false;
  }

  private boolean _jspx_meth_gmweb_roleOccupationAndNation2Text_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:roleOccupationAndNation2Text
    com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag _jspx_th_gmweb_roleOccupationAndNation2Text_1 = (com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag) _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody.get(com.linekong.gmweb2.tld.RoleOccupationAndNation2TextTag.class);
    _jspx_th_gmweb_roleOccupationAndNation2Text_1.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_roleOccupationAndNation2Text_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_gmweb_roleOccupationAndNation2Text_1.setKey(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleOccupation }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_roleOccupationAndNation2Text_1.setValueMap((java.util.Map) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.occupationMap }", java.util.Map.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_gmweb_roleOccupationAndNation2Text_1 = _jspx_th_gmweb_roleOccupationAndNation2Text_1.doStartTag();
    if (_jspx_th_gmweb_roleOccupationAndNation2Text_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_roleOccupationAndNation2Text_valueMap_key_nobody.reuse(_jspx_th_gmweb_roleOccupationAndNation2Text_1);
    return false;
  }

  private boolean _jspx_meth_gmweb_roleState2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:roleState2Text
    com.linekong.gmweb2.tld.RoleState2TextTag _jspx_th_gmweb_roleState2Text_0 = (com.linekong.gmweb2.tld.RoleState2TextTag) _jspx_tagPool_gmweb_roleState2Text_roleState_nobody.get(com.linekong.gmweb2.tld.RoleState2TextTag.class);
    _jspx_th_gmweb_roleState2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_roleState2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_gmweb_roleState2Text_0.setRoleState(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.roleState }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_roleState2Text_0 = _jspx_th_gmweb_roleState2Text_0.doStartTag();
    if (_jspx_th_gmweb_roleState2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_roleState2Text_roleState_nobody.reuse(_jspx_th_gmweb_roleState2Text_0);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_fmt_formatDate_0.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ roleInfo.createTime}", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_0.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_0 = _jspx_th_fmt_formatDate_0.doStartTag();
    if (_jspx_th_fmt_formatDate_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_0);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_1(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_1 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_1.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_1.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_fmt_formatDate_1.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.deleteTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_1.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_1 = _jspx_th_fmt_formatDate_1.doStartTag();
    if (_jspx_th_fmt_formatDate_1.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_1);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_2(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_2 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_2.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_2.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_fmt_formatDate_2.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.lastLogoutTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_2.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_2 = _jspx_th_fmt_formatDate_2.doStartTag();
    if (_jspx_th_fmt_formatDate_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_2);
    return false;
  }

  private boolean _jspx_meth_gmweb_second2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_1, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_1)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:second2Text
    com.linekong.gmweb2.tld.Second2TextTag _jspx_th_gmweb_second2Text_0 = (com.linekong.gmweb2.tld.Second2TextTag) _jspx_tagPool_gmweb_second2Text_second_nobody.get(com.linekong.gmweb2.tld.Second2TextTag.class);
    _jspx_th_gmweb_second2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_second2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_1);
    _jspx_th_gmweb_second2Text_0.setSecond(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${roleInfo.totalOnlineSecond }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_second2Text_0 = _jspx_th_gmweb_second2Text_0.doStartTag();
    if (_jspx_th_gmweb_second2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_second2Text_second_nobody.reuse(_jspx_th_gmweb_second2Text_0);
    return false;
  }

  private boolean _jspx_meth_bean_message_35(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_35 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_35.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_35.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_35.setBundle("pageResources");
    _jspx_th_bean_message_35.setKey("page.roleOperation.common.playerInfo1");
    int _jspx_eval_bean_message_35 = _jspx_th_bean_message_35.doStartTag();
    if (_jspx_th_bean_message_35.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_35);
    return false;
  }

  private boolean _jspx_meth_bean_message_36(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_36 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_36.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_36.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_36.setBundle("pageResources");
    _jspx_th_bean_message_36.setKey("page.roleOperation.common.playerInfo4");
    int _jspx_eval_bean_message_36 = _jspx_th_bean_message_36.doStartTag();
    if (_jspx_th_bean_message_36.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_36);
    return false;
  }

  private boolean _jspx_meth_bean_message_37(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_37 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_37.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_37.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_37.setBundle("pageResources");
    _jspx_th_bean_message_37.setKey("page.roleOperation.common.logID");
    int _jspx_eval_bean_message_37 = _jspx_th_bean_message_37.doStartTag();
    if (_jspx_th_bean_message_37.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_37);
    return false;
  }

  private boolean _jspx_meth_bean_message_38(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_38 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_38.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_38.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_38.setBundle("pageResources");
    _jspx_th_bean_message_38.setKey("page.roleOperation.common.state");
    int _jspx_eval_bean_message_38 = _jspx_th_bean_message_38.doStartTag();
    if (_jspx_th_bean_message_38.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_38);
    return false;
  }

  private boolean _jspx_meth_bean_message_39(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_39 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_39.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_39.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_39.setBundle("pageResources");
    _jspx_th_bean_message_39.setKey("page.roleOperation.queryFreezePlayer.freezeTime");
    int _jspx_eval_bean_message_39 = _jspx_th_bean_message_39.doStartTag();
    if (_jspx_th_bean_message_39.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_39);
    return false;
  }

  private boolean _jspx_meth_bean_message_40(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_40 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_40.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_40.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_40.setBundle("pageResources");
    _jspx_th_bean_message_40.setKey("page.roleOperation.queryFreezePlayer.planFreezetime");
    int _jspx_eval_bean_message_40 = _jspx_th_bean_message_40.doStartTag();
    if (_jspx_th_bean_message_40.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_40);
    return false;
  }

  private boolean _jspx_meth_bean_message_41(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_41 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_41.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_41.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_41.setBundle("pageResources");
    _jspx_th_bean_message_41.setKey("page.roleOperation.queryFreezePlayer.resumeTime");
    int _jspx_eval_bean_message_41 = _jspx_th_bean_message_41.doStartTag();
    if (_jspx_th_bean_message_41.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_41);
    return false;
  }

  private boolean _jspx_meth_bean_message_42(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_42 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_42.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_42.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_42.setBundle("pageResources");
    _jspx_th_bean_message_42.setKey("page.roleOperation.common.reason");
    int _jspx_eval_bean_message_42 = _jspx_th_bean_message_42.doStartTag();
    if (_jspx_th_bean_message_42.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_42);
    return false;
  }

  private boolean _jspx_meth_bean_message_43(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_43 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_43.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_43.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_43.setBundle("pageResources");
    _jspx_th_bean_message_43.setKey("page.roleOperation.queryFreezePlayer.freezeOper");
    int _jspx_eval_bean_message_43 = _jspx_th_bean_message_43.doStartTag();
    if (_jspx_th_bean_message_43.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_43);
    return false;
  }

  private boolean _jspx_meth_bean_message_44(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_44 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_44.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_44.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_44.setBundle("pageResources");
    _jspx_th_bean_message_44.setKey("page.roleOperation.queryFreezePlayer.unFreezeOper");
    int _jspx_eval_bean_message_44 = _jspx_th_bean_message_44.doStartTag();
    if (_jspx_th_bean_message_44.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_44);
    return false;
  }

  private boolean _jspx_meth_c_if_4(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:if
    org.apache.taglibs.standard.tag.rt.core.IfTag _jspx_th_c_if_4 = (org.apache.taglibs.standard.tag.rt.core.IfTag) _jspx_tagPool_c_if_test.get(org.apache.taglibs.standard.tag.rt.core.IfTag.class);
    _jspx_th_c_if_4.setPageContext(_jspx_page_context);
    _jspx_th_c_if_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_c_if_4.setTest(((java.lang.Boolean) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${not empty requestScope.freezeLogList }", java.lang.Boolean.class, (PageContext)_jspx_page_context, null, false)).booleanValue());
    int _jspx_eval_c_if_4 = _jspx_th_c_if_4.doStartTag();
    if (_jspx_eval_c_if_4 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
      do {
        out.write("\r\n");
        out.write("\t\t\t\t");
        if (_jspx_meth_c_forEach_3(_jspx_th_c_if_4, _jspx_page_context))
          return true;
        out.write("\r\n");
        out.write("\t\t\t\t");
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

  private boolean _jspx_meth_c_forEach_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_4, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_3 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_3.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_4);
    _jspx_th_c_forEach_3.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.freezeLogList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_3.setVar("freezeLog");
    int[] _jspx_push_body_count_c_forEach_3 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_3 = _jspx_th_c_forEach_3.doStartTag();
      if (_jspx_eval_c_forEach_3 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t<tr height=\"23px\">\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.logId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_gmweb_freezeState2Text_0(_jspx_th_c_forEach_3, _jspx_page_context, _jspx_push_body_count_c_forEach_3))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_3(_jspx_th_c_forEach_3, _jspx_page_context, _jspx_push_body_count_c_forEach_3))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatNumber_0(_jspx_th_c_forEach_3, _jspx_page_context, _jspx_push_body_count_c_forEach_3))
            return true;
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          if (_jspx_meth_fmt_formatDate_4(_jspx_th_c_forEach_3, _jspx_page_context, _jspx_push_body_count_c_forEach_3))
            return true;
          out.write("&nbsp;</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.reason }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_l\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.operatorName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("</td>\r\n");
          out.write("\t\t\t\t\t<td align=\"center\" class=\"t_border_r\">");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.unFreezeOperName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("&nbsp;</td>\r\n");
          out.write("\t\t\t\t</tr>\r\n");
          out.write("\t\t\t\t");
          int evalDoAfterBody = _jspx_th_c_forEach_3.doAfterBody();
          if (evalDoAfterBody != javax.servlet.jsp.tagext.BodyTag.EVAL_BODY_AGAIN)
            break;
        } while (true);
      }
      if (_jspx_th_c_forEach_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
        return true;
    } catch (Throwable _jspx_exception) {
      while (_jspx_push_body_count_c_forEach_3[0]-- > 0)
        out = _jspx_page_context.popBody();
      _jspx_th_c_forEach_3.doCatch(_jspx_exception);
    } finally {
      _jspx_th_c_forEach_3.doFinally();
      _jspx_tagPool_c_forEach_var_items.reuse(_jspx_th_c_forEach_3);
    }
    return false;
  }

  private boolean _jspx_meth_gmweb_freezeState2Text_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_3, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_3)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:freezeState2Text
    com.linekong.gmweb2.tld.FreezeState2TextTag _jspx_th_gmweb_freezeState2Text_0 = (com.linekong.gmweb2.tld.FreezeState2TextTag) _jspx_tagPool_gmweb_freezeState2Text_state_nobody.get(com.linekong.gmweb2.tld.FreezeState2TextTag.class);
    _jspx_th_gmweb_freezeState2Text_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_freezeState2Text_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_3);
    _jspx_th_gmweb_freezeState2Text_0.setState(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.state }", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    int _jspx_eval_gmweb_freezeState2Text_0 = _jspx_th_gmweb_freezeState2Text_0.doStartTag();
    if (_jspx_th_gmweb_freezeState2Text_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_freezeState2Text_state_nobody.reuse(_jspx_th_gmweb_freezeState2Text_0);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_3(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_3, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_3)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_3 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_3.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_3.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_3);
    _jspx_th_fmt_formatDate_3.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ freezeLog.freezeTime}", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_3.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_3 = _jspx_th_fmt_formatDate_3.doStartTag();
    if (_jspx_th_fmt_formatDate_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_3);
    return false;
  }

  private boolean _jspx_meth_fmt_formatNumber_0(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_3, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_3)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatNumber
    org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag _jspx_th_fmt_formatNumber_0 = (org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag) _jspx_tagPool_fmt_formatNumber_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatNumberTag.class);
    _jspx_th_fmt_formatNumber_0.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatNumber_0.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_3);
    _jspx_th_fmt_formatNumber_0.setValue((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.lastSeconds / 60 }", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatNumber_0.setPattern("0");
    int _jspx_eval_fmt_formatNumber_0 = _jspx_th_fmt_formatNumber_0.doStartTag();
    if (_jspx_th_fmt_formatNumber_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatNumber_value_pattern_nobody.reuse(_jspx_th_fmt_formatNumber_0);
    return false;
  }

  private boolean _jspx_meth_fmt_formatDate_4(javax.servlet.jsp.tagext.JspTag _jspx_th_c_forEach_3, PageContext _jspx_page_context, int[] _jspx_push_body_count_c_forEach_3)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  fmt:formatDate
    org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag _jspx_th_fmt_formatDate_4 = (org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag) _jspx_tagPool_fmt_formatDate_value_pattern_nobody.get(org.apache.taglibs.standard.tag.rt.fmt.FormatDateTag.class);
    _jspx_th_fmt_formatDate_4.setPageContext(_jspx_page_context);
    _jspx_th_fmt_formatDate_4.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_forEach_3);
    _jspx_th_fmt_formatDate_4.setValue((java.util.Date) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${freezeLog.unFreezeTime }", java.util.Date.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_fmt_formatDate_4.setPattern("yyyy-MM-dd HH:mm:ss");
    int _jspx_eval_fmt_formatDate_4 = _jspx_th_fmt_formatDate_4.doStartTag();
    if (_jspx_th_fmt_formatDate_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_fmt_formatDate_value_pattern_nobody.reuse(_jspx_th_fmt_formatDate_4);
    return false;
  }

  private boolean _jspx_meth_bean_message_45(javax.servlet.jsp.tagext.JspTag _jspx_th_c_if_1, PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_45 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_45.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_45.setParent((javax.servlet.jsp.tagext.Tag) _jspx_th_c_if_1);
    _jspx_th_bean_message_45.setBundle("pageResources");
    _jspx_th_bean_message_45.setKey("page.common.back");
    int _jspx_eval_bean_message_45 = _jspx_th_bean_message_45.doStartTag();
    if (_jspx_th_bean_message_45.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_45);
    return false;
  }
}
