package org.apache.jsp.WEB_002dINF.jsp.roleOperation;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;

public final class operOfflineRole_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static java.util.Vector _jspx_dependants;

  static {
    _jspx_dependants = new java.util.Vector(8);
    _jspx_dependants.add("/WEB-INF/jsp/roleOperation/../inc/taglibs.jsp");
    _jspx_dependants.add("/WEB-INF/c.tld");
    _jspx_dependants.add("/WEB-INF/fmt.tld");
    _jspx_dependants.add("/WEB-INF/fn.tld");
    _jspx_dependants.add("/WEB-INF/gmweb.tld");
    _jspx_dependants.add("/WEB-INF/struts-html.tld");
    _jspx_dependants.add("/WEB-INF/struts-logic.tld");
    _jspx_dependants.add("/WEB-INF/struts-bean.tld");
  }

  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_bean_message_key_bundle_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_gmweb_createGatewayOption_name_gatewayList_checkedValue_nobody;
  private org.apache.jasper.runtime.TagHandlerPool _jspx_tagPool_c_forEach_var_items;

  public java.util.List getDependants() {
    return _jspx_dependants;
  }

  public void _jspInit() {
    _jspx_tagPool_bean_message_key_bundle_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_gmweb_createGatewayOption_name_gatewayList_checkedValue_nobody = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
    _jspx_tagPool_c_forEach_var_items = org.apache.jasper.runtime.TagHandlerPool.getTagHandlerPool(getServletConfig());
  }

  public void _jspDestroy() {
    _jspx_tagPool_bean_message_key_bundle_nobody.release();
    _jspx_tagPool_gmweb_createGatewayOption_name_gatewayList_checkedValue_nobody.release();
    _jspx_tagPool_c_forEach_var_items.release();
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
      out.write("\t<script type=\"text/javascript\" src=\"js/func.js\"></script>\r\n");
      out.write("</head>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<body bgcolor=\"#ffffff\">\r\n");
      out.write("\t<form action=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.oper }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write(".do\" method=\"post\">\r\n");
      out.write("\t\t<table width=\"90%\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\">\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" height=\"30PX\"></td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr>\r\n");
      out.write("\t\t\t\t<td align=\"center\" class=\"t_head\" colspan=\"2\">");
      if (_jspx_meth_bean_message_0(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_1(_jspx_page_context))
        return;
      out.write("</td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.roleInfo.roleName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_2(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t");
      if (_jspx_meth_gmweb_createGatewayOption_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td width=\"35%\" class=\"t_border_l\" align=\"right\">");
      if (_jspx_meth_bean_message_3(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t\t <td class=\"t_border_r\" align=\"left\">\r\n");
      out.write("\t\t\t\t \t<select name=\"serverId\" style=\"width:150px\">\r\n");
      out.write("\t\t\t\t\t</select>\r\n");
      out.write("\t\t\t\t\t<script language=\"JavaScript\">\r\n");
      out.write("\t\t\t\t\t\tsel = new ESelect();\r\n");
      out.write("\t\t\t\t\t\tsel.setElement(document.all.serverId);\r\n");
      out.write("\t\t\t\t\t\t");
      if (_jspx_meth_c_forEach_0(_jspx_page_context))
        return;
      out.write("\r\n");
      out.write("\t\t\t\t\t\tdocument.all.gatewayId.onchange = function()\r\n");
      out.write("\t\t\t\t\t\t{\r\n");
      out.write("\t\t\t\t\t\t\tsel.set(this.value);\r\n");
      out.write("\t\t\t\t\t\t}\r\n");
      out.write("\t\t\t\t\t\tsel.set(document.all.gatewayId.value);\r\n");
      out.write("\t\t\t\t\t\tvar s = document.forms[0].serverId;\r\n");
      out.write("\t\t\t\t\t\tfor   (i=0; i < s.length;i++)   \r\n");
      out.write("\t\t\t\t\t\t\t{   \r\n");
      out.write("\t\t\t\t\t\t\t  \tif   (s[i].value == '");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.serverId}", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("')   \r\n");
      out.write("\t\t\t\t\t\t\t  {   \r\n");
      out.write("\t\t\t\t\t\t\t\t s[i].selected = true;\r\n");
      out.write("\t\t\t\t\t\t\t  }   \r\n");
      out.write("\t\t\t\t\t\t \t} \r\n");
      out.write("\t\t\t\t\t</script>\r\n");
      out.write("\t\t\t\t </td>\r\n");
      out.write("\t\t\t</tr>\r\n");
      out.write("\t\t\t<tr height=\"30px\">\r\n");
      out.write("\t\t\t\t<td class=\"t_border_r\" style=\"border-bottom:#AEAEB0 1px solid;\" align=\"center\" colspan=\"2\">\r\n");
      out.write("\t\t\t\t\t<input name=\"roleName\" type=\"hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.roleInfo.roleName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />\r\n");
      out.write("\t\t\t\t\t<input name=\"roleId\" type=\"hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.roleInfo.roleId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />  \r\n");
      out.write("\t\t\t\t\t<input name=\"playerName\" type=\"hidden\" value=\"");
      out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.roleInfo.playerName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
      out.write("\" />  \r\n");
      out.write("\t\t\t\t\t<input name=\"submit\" type=\"submit\" value=\" ");
      if (_jspx_meth_bean_message_4(_jspx_page_context))
        return;
      out.write(" \" />\r\n");
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
    _jspx_th_bean_message_0.setKey("page.roleOperation.operOfflineRole.title");
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
    _jspx_th_bean_message_1.setKey("page.roleOperation.common.roleName");
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
    _jspx_th_bean_message_2.setKey("page.roleOperation.common.gatewayID");
    int _jspx_eval_bean_message_2 = _jspx_th_bean_message_2.doStartTag();
    if (_jspx_th_bean_message_2.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_2);
    return false;
  }

  private boolean _jspx_meth_gmweb_createGatewayOption_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  gmweb:createGatewayOption
    com.linekong.gmweb2.tld.CreateGatewayOptionTag _jspx_th_gmweb_createGatewayOption_0 = (com.linekong.gmweb2.tld.CreateGatewayOptionTag) _jspx_tagPool_gmweb_createGatewayOption_name_gatewayList_checkedValue_nobody.get(com.linekong.gmweb2.tld.CreateGatewayOptionTag.class);
    _jspx_th_gmweb_createGatewayOption_0.setPageContext(_jspx_page_context);
    _jspx_th_gmweb_createGatewayOption_0.setParent(null);
    _jspx_th_gmweb_createGatewayOption_0.setName("gatewayId");
    _jspx_th_gmweb_createGatewayOption_0.setCheckedValue(((java.lang.Integer) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${ requestScope.gatewayId}", java.lang.Integer.class, (PageContext)_jspx_page_context, null, false)).intValue());
    _jspx_th_gmweb_createGatewayOption_0.setGatewayList((java.util.ArrayList) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.gatewayList}", java.util.ArrayList.class, (PageContext)_jspx_page_context, null, false));
    int _jspx_eval_gmweb_createGatewayOption_0 = _jspx_th_gmweb_createGatewayOption_0.doStartTag();
    if (_jspx_th_gmweb_createGatewayOption_0.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_gmweb_createGatewayOption_name_gatewayList_checkedValue_nobody.reuse(_jspx_th_gmweb_createGatewayOption_0);
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
    _jspx_th_bean_message_3.setKey("page.roleOperation.common.serverID");
    int _jspx_eval_bean_message_3 = _jspx_th_bean_message_3.doStartTag();
    if (_jspx_th_bean_message_3.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_3);
    return false;
  }

  private boolean _jspx_meth_c_forEach_0(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  c:forEach
    org.apache.taglibs.standard.tag.rt.core.ForEachTag _jspx_th_c_forEach_0 = (org.apache.taglibs.standard.tag.rt.core.ForEachTag) _jspx_tagPool_c_forEach_var_items.get(org.apache.taglibs.standard.tag.rt.core.ForEachTag.class);
    _jspx_th_c_forEach_0.setPageContext(_jspx_page_context);
    _jspx_th_c_forEach_0.setParent(null);
    _jspx_th_c_forEach_0.setItems((java.lang.Object) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${requestScope.serverList}", java.lang.Object.class, (PageContext)_jspx_page_context, null, false));
    _jspx_th_c_forEach_0.setVar("server");
    int[] _jspx_push_body_count_c_forEach_0 = new int[] { 0 };
    try {
      int _jspx_eval_c_forEach_0 = _jspx_th_c_forEach_0.doStartTag();
      if (_jspx_eval_c_forEach_0 != javax.servlet.jsp.tagext.Tag.SKIP_BODY) {
        do {
          out.write("\r\n");
          out.write("\t\t\t\t\t\t\tsel.add('");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${server.gatewayId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("', '");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${server.serverId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("', '");
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${server.serverId }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write('-');
          out.write((java.lang.String) org.apache.jasper.runtime.PageContextImpl.proprietaryEvaluate("${server.serverName }", java.lang.String.class, (PageContext)_jspx_page_context, null, false));
          out.write("');\t\r\n");
          out.write("\t\t\t\t\t\t");
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

  private boolean _jspx_meth_bean_message_4(PageContext _jspx_page_context)
          throws Throwable {
    PageContext pageContext = _jspx_page_context;
    JspWriter out = _jspx_page_context.getOut();
    //  bean:message
    org.apache.struts.taglib.bean.MessageTag _jspx_th_bean_message_4 = (org.apache.struts.taglib.bean.MessageTag) _jspx_tagPool_bean_message_key_bundle_nobody.get(org.apache.struts.taglib.bean.MessageTag.class);
    _jspx_th_bean_message_4.setPageContext(_jspx_page_context);
    _jspx_th_bean_message_4.setParent(null);
    _jspx_th_bean_message_4.setBundle("pageResources");
    _jspx_th_bean_message_4.setKey("page.roleOperation.common.oper");
    int _jspx_eval_bean_message_4 = _jspx_th_bean_message_4.doStartTag();
    if (_jspx_th_bean_message_4.doEndTag() == javax.servlet.jsp.tagext.Tag.SKIP_PAGE)
      return true;
    _jspx_tagPool_bean_message_key_bundle_nobody.reuse(_jspx_th_bean_message_4);
    return false;
  }
}
