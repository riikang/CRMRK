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
		$(document).ready(function(){
			//表格自适应
    		$('.full-width').horizontalNav({});
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!--导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">消费记录</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 数据表格  -->
			<div id="reportTableDiv" class="span10">
				<table id="reportTable">
				</table>
				<input type="hidden" id="h1" value="1"/>
			</div>
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
				pageSize: 14,
				pageNumber:1,
				pageList: [10, 20, 50, 100, 200, 500],
				search: true,
				showColumns: true,
				showRefresh: true,
				showExport: true,
				exportTypes: ['excel'],
				search: true,
				clickToSelect: true,
				columns: [{field:"id",title:"订单标题",align:"center",valign:"middle",sortable:"true"},
				          {field:"time",title:"下单时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"product",title:"成交商品",align:"center",valign:"middle",sortable:"true"},
				          {field:"hb",title:"货币单位",align:"center",valign:"middle",sortable:"true"},
				          {field:"totalprice",title:"总价",align:"center",valign:"middle",sortable:"true"},
				          {field:"wfk",title:"未付款",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出任务数据  start-->
	<s:iterator value="orderss" id="od1">
		<script>
		init.dates[ii] = {
				'id' : '<s:property value="#od1.title"/>',
				'time' : '<s:property value="#od1.dealdate"/>',
				'product':'<s:property value="#od1.product.pname"/>',
				'hb' : '<s:property value="#od1.currency"/>',
				'totalprice':'<s:property value="#od1.dealpriceT"/>',
				'wfk' : '<s:property value="#od1.remainingPay"/>'
				};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出任务数据  end-->
  </body>
</html>
