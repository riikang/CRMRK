<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>table</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link rel="stylesheet" href="<%=path%>/css/bootstrap.css" />
	<link rel="stylesheet" href="<%=path%>/css/bootstrap-table.css" />
	<link rel="stylesheet" href="<%=path%>/css/horizontalNav.css" />
	<link rel="stylesheet" href="<%=path%>/css/addProductMain.css" />
	<link rel="stylesheet" href="<%=path%>/css/tabsDemo.css" />
	<link rel="stylesheet" href="<%=path%>/css/tabsComponent.css" />
	
	<script src="<%=path%>/js/jquery-3.0.0.min.js"></script>
	<script src="<%=path%>/js/bootstrap.min.js"></script>	
	<script src="<%=path%>/js/bootstrap-table.js"></script>
	<script src="<%=path%>/js/bootstrap-table-export.js"></script>
	<script src="<%=path%>/js/jquery.base64.js"></script>
	<script src="<%=path%>/js/tableExport.js"></script>
	<script src="<%=path%>/js/jquery.horizontalNav.js"></script>
	<script src="<%=path%>/js/cbpFWTabs.js"></script>
	<script src="<%=path%>/js/TableValidate.js"></script>
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		$(document).ready(function() {
    		$('.full-width').horizontalNav({});//表格自适应
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="chanceAction_deleteSomechance" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="javascript:void(0)">新销售机会</a></li>
           		  <li><a href="<%=path %>/crm/chanceAction_findAllchance.action">所有销售机会</a></li>
        		</ul>
    		</div>
		</div>
		<!-- 数据表格  -->
			<div id="reportTableDiv" class="span10">
				<table id="reportTable">
				</table>
				<input type="hidden" id="h1" value="1"/>
			</div>
		</s:form>
		</div>
	</div>
	
	<!-- 列表初始化  start-->
	<script type="text/javascript">
		var init = {
			'dates' : []
		};
		var ii = 0;
		$(function () {
			$('#reportTable').bootstrapTable({
				method: 'get',
				cache: false,
				height: 700,
				striped: true,
				pagination: true,
				pageSize: 20,
				pageNumber:1,
				pageList: [10, 20, 50, 100, 200, 500],
				search: true,
				showColumns: true,
				showRefresh: true,
				showExport: true,
				exportTypes: ['csv','txt','xml'],
				search: true,
				clickToSelect: true,
				columns: [{field:"name",title:"机会名称",align:"center",valign:"middle",sortable:"true"},
				          {field:"customer",title:"客户名称",align:"center",valign:"middle",sortable:"true"},
				          {field:"product",title:"意向产品",align:"center",valign:"middle",sortable:"true"},
				          {field:"channel",title:"负责渠道",align:"center",valign:"middle",sortable:"true"},
				          {field:"salesman",title:"负责销售员",align:"center",valign:"middle",sortable:"true"},
				          {field:"total",title:"预计成交总额",align:"center",valign:"middle",sortable:"true"},
				          {field:"stage",title:"机会阶段",align:"center",valign:"middle",sortable:"true"},
				          {field:"getdate",title:"录入时间",align:"center",valign:"middle",sortable:"true"}
				          ],
				data : init.dates,
				onPageChange: function (size, number) {
                },
                formatNoMatches: function(){
                	return '无符合条件的记录';
                }
			});
			$(window).resize(function () {
				$('#reportTable').bootstrapTable('resetView');
			});
		});
	</script>
	<!-- 列表初始化  end-->
	
	<!-- 迭代读出数据  start-->
	<s:iterator value="chances" id="c1">
		<script>
		init.dates[ii] = {
				'name' : '<input type="checkbox" onchange="confirm_checked(this)" id="cid" name="cid" value="<s:property value="#c1.id"/>"/>&nbsp;'+
							'<a href="<%=path %>/crm/chanceAction_findTheChance.action?chance.id=<s:property value='#c1.id'/>"><s:property value="#c1.name"/></a>',
				'customer' : '<s:property value="#c1.customerP.cname"/>',
				'product':'<s:property value="#c1.product.pname"/>',
				'channel' : '<s:property value="#c1.channel.cname"/>',
				'salesman':'<s:property value="#c1.salesman.sname"/>',
				'total':'<s:property value="#c1.total"/>',
				'stage':'<s:property value="#c1.stage"/>',
				'getdate':'<s:property value="#c1.getDate"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出数据  end-->
  </body>
</html>
