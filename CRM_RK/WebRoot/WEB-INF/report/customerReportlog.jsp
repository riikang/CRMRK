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
				window.location.href="<%=path %>/crm/customerReportAction_deleteTheCustomerReport.action?customerReport.id=${customerReport.id}";
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
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">客户消费统计明细</a></li>
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
			<!-- 表格div start -->
			<div id="tableDiv" style="margin-top:30px;">
				<table width="100%" border="1" cellpadding="10">
					<tr bgcolor="#40E0D0">
						<td colspan="6" align="center" width="100%">${customerReport.reportname}</td>
					</tr>
					<tr>
						<td width="30%">客户姓名</td><td width="15%">购买总量</td>
						<td width="15%">总金额</td><td width="15%">已付款金额</td>
						<td width="15%">未付款金额</td>
					</tr>
					<s:iterator value="customerReportlogs" id="crl1">
					<tr>
						<td><a href="javascript:void(0)" onclick="javascript:
							$.ajax( {  
								type : 'POST',  
								url : '<%=path%>/crm/customerReportAction_findCustomerConsumelog.action?customerP.id=${crl1.customerP.id}&customerReport.id=${customerReport.id}',  
								data : {},  
								dataType : 'JSON',  
								success : function(jsonStr) {
									$('#hh3').text('${crl1.customerP.cname},${customerReport.starttime}—${customerReport.endtime}消费记录')
									$('#tt1 tr:gt(0)').remove();
									var html='';
									$.each(jsonStr,function(i,date){
										html=html+'<tr><td>'+date.id+'</td><td>'+date.dealdate+'</td>'+
										'<td>'+date.product.pname+'</td><td>'+date.amount+'</td>'+
										'<td>'+date.dealpriceT+'</td></tr>'
									});
									$('#mingxit').after(html);
									$('#code8').center();
        							$('#goodcover8').show();
       								$('#code8').fadeIn();
								}  
							});">${crl1.customerP.cname}</a></td><td>${crl1.total}</td>
						<td>${crl1.money}</td><td>${crl1.moneyed}</td>
						<td>${crl1.moneying}</td>
					</tr>
					</s:iterator>
				</table>
				*点击客户名称可查看${customerReport.starttime}到${customerReport.endtime}的详细消费记录
			</div>
			<!-- 表格div end -->
		</div>
	</div>
	
	<!--弹出窗口、商品报表明细  start-->
	<div id="goodcover8"></div>
	<div id="code8">
		<div class="close1"><a href="javascript:void(0)" id="closebt8"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<h3 id="hh3"></h3>
			<table width="90%" id="tt1" align="center" border="1" cellpadding="3" style="margin-top:40px;text-align:center;">
			<tr id="mingxit"><td width='20%'>订单编号</td><td width='20%'>消费时间</td>
			<td width='15%'>购买商品</td><td width='15%'>数量</td><td width='15%'>消费金额</td></tr>
			</table>
		</div>
	</div>
	<!--弹出窗口、商品报表明细  end-->
	
	<!--调整排版 
	<div id="goodcover"></div>
	<div id="code">
		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
		</div>
	</div>-->
	
	
	<script>
$(function() {
	//弹出层事件 start
	$('#closebt8').click(function() {
		$('#code8').hide();
		$('#goodcover8').hide();
	});
	$('#goodcover8').click(function() {
		$('#code8').hide();
		$('#goodcover8').hide();
	});
	//弹出层事件 end
});
</script>
	
  </body>
</html>
