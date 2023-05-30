<%@ page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="../inc/taglibs.jsp"%>

<html>

<head>
	<link href="css/main.css" rel="stylesheet" type="text/css" />
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title></title>
	 
	
	<html:javascript formName="/activationLog"/>
	<c:if test="${not empty requestScope.activationLogMap}">
	 <link rel="stylesheet" type="text/css" href="css/ext-all.css"/>

    <!-- GC -->
    <!-- LIBS -->
    <script type="text/javascript" src="js/ext-base.js"></script>
    <!-- ENDLIBS -->

    <script type="text/javascript" src="js/ext-all.js"></script>
	<script type="text/javascript">

Ext.onReady(function(){

    Ext.QuickTips.init();

    


    // shared reader
    var reader = new Ext.data.ArrayReader({}, [
       {name: 'serial_no'},
       {name: 'passport'},
       {name: 'use_time', type: 'date',dateFormat:'Y-m-d h:i:s'},
       {name: 'activityId'},
       {name: 'activityName'}
      
       ]);

    var store = new Ext.data.GroupingStore({
            reader: reader,
            data: Ext.grid.dummyData,
            sortInfo:{field: 'use_time', direction: "DESC"},
            groupField:'passport'
        });

    var grid = new Ext.grid.GridPanel({
        store: store,
        columns: [
            {id:'serial_no',header: "<bean:message bundle="pageResources" key="page.playerQuery.vipCardInfo.CardNum"/>", width: 30, sortable: true, dataIndex: 'serial_no'},
            {header: "<bean:message bundle="pageResources" key="page.common.passport"/>", width: 20, sortable: true,  dataIndex: 'passport'},
            {header: "<bean:message bundle="pageResources" key="page.playerQuery.activationLog.useTime"/>", width:30, sortable: true,renderer: Ext.util.Format.dateRenderer('Y-m-d h:i:s'), dataIndex: 'use_time' },
            {header: "<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityId"/>", width: 20, sortable: true, dataIndex: 'activityId'},
            {header: "<bean:message bundle="pageResources" key="page.worldOperation.addSerialActivity.activityName"/>", width: 20, sortable: true,dataIndex: 'activityName'}
        ],

        view: new Ext.grid.GroupingView({
            forceFit:true,
            groupTextTpl: '{text} ({[values.rs.length]} {[values.rs.length > 1 ? "Items" : "Item"]})'
        }),
		
		frame:false,
        width: 680,
        height:store.data.length > 11? 480: (store.data.length+1)*40+30,
        collapsible: false,
        animCollapse: false,
        title: '<bean:message bundle="pageResources" key="page.playerQuery.activationLog.title"/> "${playerName }" <bean:message bundle="pageResources" key="page.roleOperation.common.playerInfo4"/>',
        iconCls: 'icon-grid'/*,
        fbar  : ['->', {
            text:'Clear Grouping',
            iconCls: 'icon-clear-group',
            handler : function(){
                store.clearGrouping();
            }
        }]*/,
        renderTo: document.getElementById("display")
    });
});



// Array data for the grids
Ext.grid.dummyData = [
	<c:forEach items="${requestScope.activationLogMap}" var="entryVar" varStatus="logStatus">
		<c:forEach items="${entryVar.value}" var="log" varStatus="tempStatus">
			['${log.serial_no }','${log.user_name }','<fmt:formatDate value="${log.use_time }" pattern="yyyy-MM-dd HH:mm:ss"/>','${log.activity_id }', '${log.activity_name }']
			<c:if test="${not logStatus.last or not tempStatus.last}">
			,
			</c:if>
		</c:forEach>
	</c:forEach>
];

// add in some dummy descriptions
/*for(var i = 0; i < Ext.grid.dummyData.length; i++){
    Ext.grid.dummyData[i].push('Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Sed metus nibh, sodales a, porta at, vulputate eget, dui. Pellentesque ut nisl. Maecenas tortor turpis, interdum non, sodales non, iaculis ac, lacus. Vestibulum auctor, tortor quis iaculis malesuada, libero lectus bibendum purus, sit amet tincidunt quam turpis vel lacus. In pellentesque nisl non sem. Suspendisse nunc sem, pretium eget, cursus a, fringilla vel, urna.<br/><br/>Aliquam commodo ullamcorper erat. Nullam vel justo in neque porttitor laoreet. Aenean lacus dui, consequat eu, adipiscing eget, nonummy non, nisi. Morbi nunc est, dignissim non, ornare sed, luctus eu, massa. Vivamus eget quam. Vivamus tincidunt diam nec urna. Curabitur velit.');
}*/
	</script>
	</c:if>
</head>


<body bgcolor="#ffffff">
	<c:if test="${empty requestScope.activationLogMap }">
		<html:form action="activationLog.do" method="post" onsubmit="return validateActivationLogForm(this);">
		<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
			<tr>
				<td align="center" height="30PX"></td>
			</tr>
			<tr>
				<td align="center" class="t_head" colspan="2"><bean:message bundle="pageResources" key="page.playerQuery.activationLog.title"/></td>
			</tr>
			<tr height="30px">
				<td width="35%" class="t_border_l" align="right"><bean:message bundle="pageResources" key="page.common.passport"/>：
				 </td>
				 <td class="t_border_r" align="left">
				 	<textarea rows="10" cols="30" name="passport"></textarea>
				 </td>
			</tr>
			<tr height="30px">
				<td class="t_border_r" style="border-bottom:#AEAEB0 1px solid;" align="center" colspan="2">
					<input name="search" type="submit" value="<bean:message bundle="pageResources" key="page.common.submit"/>" />
				</td>
			</tr>
		</table>
		</html:form>
		<div align="center">
			<font color="red" size="3px"><html:errors/> </font>
			<font color="red" size="3px">${msg }</font>
		</div>
	</c:if>
	
	<c:if test="${not empty requestScope.activationLogMap}">
		
		<div id="display" style="width:75%;left: 5%;position: absolute;" >
			
		</div>
		<div align="center">
			<input type="button" value=" <bean:message bundle="pageResources" key="page.common.back"/> " onclick="history.go(-1);"/>
		</div>
	</c:if>
</body>
</html>