<%@page import="java.text.SimpleDateFormat"%>
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
		//确认是否删除
		function confirm_delete(){
			if (!confirm("确认删除？")) {
		        window.event.returnValue = false;
		    }
			else{
				window.location.href="<%=path %>/crm/productReportAction_deleteTheProductReport.action?productReport.id=${productReport.id}";
				alert("删除成功");
			}				
		}
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">商品销量统计明细</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
        		<!--<li><a href="<%=path %>/crm/orderAction_findAllOrder.action">返回列表</a></li>  -->
           		  <li><a onclick="javascript:history.go(-1)" href="javascript:void(0);">返回列表</a></li>
           		  <li><a onclick="confirm_delete()" href="javascript:void(0);">删除</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 列表数据div start-->
			<div id="tableDiv" style="margin-top:30px;">
				<table width="100%" border="1" cellpadding="10">
					<tr bgcolor="#40E0D0">
						<td colspan="6" align="center" width="100%">${productReport.starttime}—${productReport.endtime}商品销售统计报表</td>
					</tr>
					<tr>
						<td width="30%">商品名称</td><td width="15%">销量</td>
						<td width="15%">总金额</td><td width="15%">已收货款</td>
						<td width="15%">未收货款</td>
					</tr>
					<s:iterator value="reportlogs" id="rl1">
					<tr>
						<td><a href="javascript:void(0)" onclick="javascript:
							$.ajax( {  
								type : 'POST',  
								url : '<%=path%>/crm/productReportAction_findReportlogByPid.action?product.id=${rl1.product.id}&productReport.id=${productReport.id}',  
								data : {},  
								dataType : 'JSON',  
								success : function(jsonStr) {
									$('#hh3').text('${rl1.product.pname},${productReport.starttime}—${productReport.endtime}销售详情');
									$('#tt1 tr:gt(0)').remove();
									var html='';
									$.each(jsonStr,function(i,date){
										html=html+'<tr><td>'+date.id+'</td><td>'+date.dealdate+'</td>'+
										'<td>'+date.salesman.channel.cname+'</td><td>'+date.salesman.sname+'</td>'+
										'<td>'+date.dealpriceT+'</td><td>'+date.customerP.cname+'</td></tr>'
									});
									$('#mingxit').after(html);
									$('#code8').center();
        							$('#goodcover8').show();
       								$('#code8').fadeIn();
								}  
							});">${rl1.product.pname}</a></td><td>${rl1.total}</td>
						<td>${rl1.money}</td><td>${rl1.moneyed}</td>
						<td>${rl1.moneying}</td>
					</tr>
					</s:iterator>
					<tr>
						<td>总计</td><td>${productReport.total}</td>
						<td>${productReport.money}</td><td>${productReport.moneyed}</td>
						<td>${productReport.moneying}</td>
					</tr>
				</table>
				*点击商品名称、未收货款可查看明细
			</div>
			<!-- 列表数据div end-->
		</div>
	</div>
	
	<!--弹出窗口、商品报表明细  start-->
	<div id="goodcover8"></div>
	<div id="code8">
		<div class="close1"><a href="javascript:void(0)" id="closebt8"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<h3 id="hh3"></h3>
			<table width="90%" id="tt1" align="center" border="1" cellpadding="3" style="margin-top:40px;text-align:center;">
			<tr id="mingxit"><td width='20%'>订单编号</td><td width='20%'>下单时间</td>
			<td width='15%'>销售渠道</td><td width='15%'>销售员</td><td width='15%'>总金额</td><td width='15%'>客户</td></tr>
			</table>
		</div>
	</div>
	<!--弹出窗口、商品报表明细  end-->
	
	<!--弹出窗口、未收款明细  start-->
	<div id="goodcover"></div>
	<div id="code">
		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
		</div>
	</div>
	<!--弹出窗口、未收款明细  end-->
	
	<script>
$(function() {
	//弹出层事件start
	$('#closebt8').click(function() {
		$('#code8').hide();
		$('#goodcover8').hide();
	});
	$('#goodcover8').click(function() {
		$('#code8').hide();
		$('#goodcover8').hide();
	});
	//弹出层事件end
});
</script>
	
  </body>
</html>
