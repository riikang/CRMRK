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
			//表格自适应
    		$('.full-width').horizontalNav({});
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="serviceAction_deleteSomeservice" namespace="/crm">
		<!-- 导航条 -->
		<div class="demo">
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a>服务记录</a></li>
           		  <li id="addnew"><a href="javascript:void(0)">新增服务记录</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 表格div  -->
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
				columns: [{field:"title",title:"简述",align:"center",valign:"middle",sortable:"true"},
				          {field:"stime",title:"服务时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"stype",title:"服务类型",align:"center",valign:"middle",sortable:"true"},
				          {field:"status",title:"状态",align:"center",valign:"middle",sortable:"true"},
				          {field:"sways",title:"服务方式",align:"center",valign:"middle",sortable:"true"},
				          {field:"salesman",title:"负责客服",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出数据 start-->
	<s:iterator value="servicelogs" id="sl1">
		<s:if test="#sl1.salesman!=null">
		<script>
		init.dates[ii] = {
				'title' : '<a href="<%=path %>/crm/serviceAction_findTheService.action?servicelog.id=<s:property value='#sl1.id'/>">'+
							'<s:property value="#sl1.title"/></a>',
				'stime' : '<s:property value="#sl1.servicedate"/>',
				'stype':'<s:property value="#sl1.servicetype"/>',
				'status' : '<s:property value="#sl1.status"/>',
				'sways':'<s:property value="#sl1.serviceways"/>',
				'salesman':'<s:property value="#sl1.salesman.sname"/>'
			};
			ii++;
		</script>
		</s:if>
		<s:if test="#sl1.salesman==null">
		<script>
		init.dates[ii] = {
				'title' : '<a href="<%=path %>/crm/serviceAction_findTheService.action?servicelog.id=<s:property value='#sl1.id'/>">'+
							'<s:property value="#sl1.title"/></a>',
				'stime' : '<s:property value="#sl1.servicedate"/>',
				'stype':'<s:property value="#sl1.servicetype"/>',
				'status' : '<s:property value="#sl1.status"/>',
				'sways':'<s:property value="#sl1.serviceways"/>',
				'salesman':'未分配'
			};
			ii++;
		</script>
		</s:if>
	</s:iterator>
	<!-- 迭代读出数据 end-->
	
	<!-- 添加界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addserviceform2" action="serviceAction_addservice" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>服务记录</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="8">
						<tr>
						<td width="40%" align="right">*问题简述:</td>
						<td width="60%"><textarea name="servicelog.title" id="title2" style="width:300px;height:150px;resize:none;"></textarea></td>
						</tr>
						<tr>
						<td align="right">*服务类型:</td>
						<td><select style="width:185px;height:30px;" id="sel2" name="servicelog.servicetype">
							<option value="">--请选择--</option>
							<option value="客户意见">客户意见</option>
							<option value="产品咨询">产品咨询</option>
							<option value="产品投诉">产品投诉</option>
							<option value="产品售后">产品售后</option>
							<option value="其他">其他</option>
  						</select></td>
						</tr>
						<tr id="checktr1">
						<td align="right">是否关联订单:</td>
						<td><input type="checkbox" id="checkbox1"/></td>
						</tr>
						<tr id="checktr2">
						<td align="right">是否关联商品:</td>
						<td><input type="checkbox" id="checkbox2"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="addserviceb2" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加界面  start-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//"是否关联订单"事件
	$('#checkbox1').change(function(){
		if($('#checkbox1').prop('checked')){
			$('#checktr1').after(
				"<tr id='newtr1'><td align='right'>请选择订单号:</td>"+
				"<td><select style='width:185px;height:30px;' id='box1' name='orders.id'></select></td></tr>"	
			);
			 $.ajax( {  
			        type : "POST",  
			        url : "crm/findAllOrdersByAjax.action",  
			        data : {},  
			        dataType : "JSON",  
			        success : function(jsonStr) { 
			        	$.each(jsonStr,function(i,date){  
		                    var _tr = $("<option value='"+date.id+"'>"+date.title+"</option>");  
		                    $("#box1").append(_tr);  
		                }); 
			        }  
			    });  
		}else{
			$('#newtr1').remove();
		}
	});
	
	//"是否关联商品"事件
	$('#checkbox2').change(function(){
		if($('#checkbox2').prop('checked')){
			$('#checktr2').after(
				"<tr id='newtr2'><td align='right'>请选择商品:</td>"+
				"<td><select style='width:185px;height:30px;' id='box2' name='product.pname'></select></td></tr>"	
			);
			 $.ajax( {  
			        type : "POST",  
			        url : "crm/findAllProductByAjax.action",  
			        data : {},  
			        dataType : "JSON",  
			        success : function(jsonStr) { 
			        	$.each(jsonStr,function(i,date){  
		                    var _tr = $("<option value='"+date.pname+"'>"+date.pname+"</option>");  
		                    $("#box2").append(_tr);  
		                }); 
			        }  
			    });  
		}else{
			$('#newtr2').remove();
		}
	});
	//弹出层事件start
    $('#addnew').click(function() {
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
