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
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		//判断所选行是否为空，以及确认是否删除 start
	    var flag=0;
		function confirm_delete(){
			if(flag>0){
				if (!confirm("确认删除？")) {
		           	 window.event.returnValue = false;
		       		 }
					else{
						var f1=document.getElementById("f1");
						f1.submit();
						alert("删除成功");
					}	
			}else{
				alert("未选中任何行");
			}				
		}
		function confirm_checked(obj){
			if(obj.checked==true){
				flag++;
			}else{
				flag--;
			}
		}
		//判断所选行是否为空，以及确认是否删除 end
		
		$(document).ready(function() {
    		$('.full-width').horizontalNav({});//表格自适应
		});
		
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="productReportAction_deleteSomeReport" namespace="/crm">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">商品销量统计</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">批量删除</a></li>
           		  <li><a id="export" href="javascript:void(0)">导出报表</a></li>
          		  <li><a id="createnew" href="javascript:void(0)">生成报表</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 列表数据div -->
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
				exportTypes: ['excel'],
				search: true,
				clickToSelect: true,
				columns: [{field:"id",title:"报表编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"time",title:"起始日期",align:"center",valign:"middle",sortable:"true"},
				          {field:"total",title:"月总销量",align:"center",valign:"middle",sortable:"true"},
				          {field:"money",title:"总金额",align:"center",valign:"middle",sortable:"true"},
				          {field:"moneyed",title:"已收货款",align:"center",valign:"middle",sortable:"true"},
				          {field:"moneying",title:"未收货款",align:"center",valign:"middle",sortable:"true"},
				          {field:"op",title:"明细",align:"center",valign:"middle",sortable:"true"}
				          ],
				data : init.dates,
				onPageChange: function (size, number) {},
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
	
	<!-- 迭代读出商品数据 start-->
	<s:iterator value="productReports" id="pr1">
		<script>
		init.dates[ii] = {
				'id' : '<input type="checkbox" onchange="confirm_checked(this)" id="prid" name="prid" value="<s:property value="#pr1.id"/>"/>&nbsp;<s:property value="#pr1.id"/>',
				'time' : '<s:property value="#pr1.starttime"/>&nbsp;至&nbsp;<s:property value="#pr1.endtime"/>',
				'total' : '<s:property value="#pr1.total"/>',
				'money' : '<s:property value="#pr1.money"/>',
				'moneyed' : '<s:property value="#pr1.moneyed"/>',
				'moneying' : '<s:property value="#pr1.moneying"/>',
				'op' : '<a href="<%=path %>/crm/productReportAction_findTheReportlog.action?productReport.id=<s:property value='#pr1.id'/>">明细</a>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出商品数据 end-->
	
	<!-- 生成报表界面 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" action="productReportAction_CreateProductReport" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>报表信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="50%" align="right">请选择需要生成报表的起止时间:</td>
						<td width="50%"></td>
						</tr>
						<tr>
						<td align="right"><input type="date" style="width:185px;height:30px;" name="productReport.starttime"/>--</td>
						<td>--<input type="date" style="width:185px;height:30px;" name="productReport.endtime"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="生成报表"/>
			</s:form>
  		</div>
	</div>
	<!-- 生成报表界面 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件start	
    $('#createnew').click(function() {
        $('#code').center();
        $('#goodcover').show();
        $('#code').fadeIn();
    });
    $('#closebt').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
	$('#goodcover').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
	//弹出层事件end
});
</script>
	
  </body>
</html>
