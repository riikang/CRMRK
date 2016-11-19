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
				var idid=$('#oid').text();
				window.location.href="<%=path %>/crm/orderAction_deleteTheOrder.action?orders.id="+idid;
				alert("删除成功");
			}				
		}
		
		//收缩按钮动画
		$(function(){
			$('#b1').click(function(){
				if($('#b1').text()=='▲'){
					$('#tableDiv1').animate({height:'toggle'});
					$('#b1').text('▼');
				}else{
					$('#tableDiv1').animate({height:'toggle'});
					$('#b1').text('▲');
				}
			});
		});
		$(function(){
			$('#b2').click(function(){
				if($('#b2').text()=='▲'){
					$('#tableDiv2').animate({height:'toggle'});
					$('#b2').text('▼');
				}else{
					$('#tableDiv2').animate({height:'toggle'});
					$('#b2').text('▲');
				}
			});
		});
		
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!-- 导航条 -->
		<div class="demo">
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
        		<!--<li><a href="<%=path %>/crm/orderAction_findAllOrder.action">返回列表</a></li>  -->
           		  <li><a onclick="javascript:history.go(-1)" href="javascript:void(0);">返回列表</a></li>
           		  <li><a id="addnewp" href="javascript:void(0)">新增付款记录</a></li>
           		  <li><a id="addnews" href="javascript:void(0)">新增交货记录</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 数据表格start  -->
			<div id="tableDiv">
				<table width="100%" cellpadding="10">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="50%">订单信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">订单编号:&nbsp;</td><td id="oid" width="25%">${orders.id}</td>
						<td align="right" width="25%">接单时间:&nbsp;</td><td width="25%">${orders.dealdate}</td>
					</tr>
					<tr>
						<td align="right">付款时间:&nbsp;</td><td id="t1">${orders.paydate}</td>
						<td align="right">交货时间:&nbsp;</td><td id="t2">${orders.senddate}</td>
					</tr>
					<tr>
						<td align="right">订单总额:&nbsp;</td><td id="t3">${orders.dealpriceT}</td>
						<td align="right">欠未收款:&nbsp;</td><td id="t4">${orders.remainingPay}</td>
					</tr>
					<tr>
						<td align="right">已收款:&nbsp;</td><td id="t5">${orders.paymoney}</td>
						<td align="right">总需求货量:&nbsp;</td><td id="t3">${orders.amount}</td>
					</tr>
				</table>
				
				<table width="100%" cellpadding="10">
					<tr bgcolor="#40E0D0">
						<td colspan="2" width="50%">付款记录</td>
						<td align="right" colspan="2" width="50%"><a id="b1" href="javascript:void(0);">▲</a></td>
					</tr>
				</table>
				<div id="tableDiv1">
				<table width="100%" border="1" cellpadding="10">
					<tr>
						<td align="center" width="20%">编号&nbsp;</td><td align="center" width="20%">实际付款日期&nbsp;</td>
						<td align="center" width="20%">付款金额&nbsp;</td><td align="center" width="20%">欠未付款&nbsp;</td>
						<td align="center" width="20%">操作&nbsp;</td>
					</tr>
					<s:iterator value="paylogs" id="pl1">
					<tr>
						<td align="center"><s:property value="#pl1.id"/></td>
						<td align="center"><s:property value="#pl1.realPayDate"/></td>
						<td align="center"><s:property value="#pl1.realPay"/></td>
						<td align="center"><s:property value="#pl1.remainingPay"/></td>
						<td align="center"><a href="javascript:void(0)" onclick="javascript:
								if (!confirm('确认删除？')) {
		           	 				window.event.returnValue = false;
		       		 			}else{
									window.location.href='<%=path %>/crm/orderslogAction_deletePaylog.action?paylog.id=${pl1.id}&orders.id=${orders.id}';
									alert('删除成功');
								}">删除</a>
						<a href="javascript:void(0);" onclick="javascript:
										$.ajax( {  
	        								type : 'POST',  
	        								url : '<%=path%>/crm/orderslogAction_updatePaylog.action?paylog.id='+${pl1.id},  
	        								data : {},  
	        								dataType : 'JSON',  
	        								success : function(jsonStr) { 
	        									$('#hpid').val(jsonStr.id);
	        									$('#hoid').val(jsonStr.orders.id);
	        									$('#prd').val(jsonStr.realPayDate);
	        									$('#prp').val(jsonStr.realPay);
	        									$('#code').center();
	     										$('#goodcover').show();
	     										$('#code').fadeIn();
	     										$('#closebt').click(function() {
        											$('#code').hide();
        											$('#goodcover').hide();
    											});
												$('#goodcover').click(function() {
        											$('#code').hide();
        											$('#goodcover').hide();
    											});
	        								}  
	    								}); " >编辑</a></td>
					</tr>
					</s:iterator>
				</table>
				</div>
				
				<table width="100%" cellpadding="10">
					<tr bgcolor="#40E0D0">
						<td colspan="2" width="50%">交货记录</td>
						<td align="right" colspan="2" width="50%"><a id="b2" href="javascript:void(0);">▲</a></td>
					</tr>
				</table>
				<div id="tableDiv2">
				<table width="100%" border="1" cellpadding="10">
					<tr>
						<td align="center" width="10%">编号&nbsp;</td><td align="center" width="20%">实际交货日期&nbsp;</td>
						<td align="center" width="20%">交货数量&nbsp;</td><td align="center" width="20%">交货金额&nbsp;</td>
						<td align="center" width="20%">剩余交货量&nbsp;</td><td align="center" width="10%">操作&nbsp;</td>
					</tr>
					<s:iterator value="sendlogs" id="slg1">
					<tr>
						<td align="center"><s:property value="#slg1.id"/></td>
						<td align="center"><s:property value="#slg1.realSendDate"/></td>
						<td align="center"><s:property value="#slg1.sendNum"/></td>
						<td align="center"><s:property value="#slg1.sendPrice"/></td>
						<td align="center"><s:property value="#slg1.remainingSend"/></td>
						<td align="center"><a href="javascript:void(0);" onclick="javascript:
							if (!confirm('确认删除？')) {
		           	 				window.event.returnValue = false;
		       		 			}else{
									window.location.href='<%=path %>/crm/orderslogAction_deleteSendlog.action?sendlog.id=${slg1.id}&orders.id=${orders.id}';
									alert('删除成功');
								}">删除</a>
						<a href="javascript:void(0);" onclick="javascript:
										$.ajax( {  
	        								type : 'POST',  
	        								url : '<%=path%>/crm/orderslogAction_updateSendlog.action?sendlog.id='+${slg1.id},  
	        								data : {},  
	        								dataType : 'JSON',  
	        								success : function(jsonStr1) { 
	        									$('#hsid').val(jsonStr1.id);
	        									$('#hoid2').val(jsonStr1.orders.id);
	        									$('#srsd').val(jsonStr1.realSendDate);
	        									$('#ssn').val(jsonStr1.sendNum);
	        									$('#code4').center();
	     										$('#goodcover4').show();
	     										$('#code4').fadeIn();
	     										$('#closebt4').click(function() {
        											$('#code4').hide();
        											$('#goodcover4').hide();
    											});
												$('#goodcover4').click(function() {
        											$('#code4').hide();
        											$('#goodcover4').hide();
    											});
	        								}  
	    								}); " >编辑</a></td>
					</tr>
					</s:iterator>
				</table>
				</div>
				
			</div>
			<!-- 数据表格end  -->
		</div>
	</div>
	
	<!--弹出窗口、添加付款记录界面  start-->
	<div id="goodcover2"></div>
	<div id="code2">
		<div class="close1"><a href="javascript:void(0)" id="closebt2"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<s:form theme="simple" action="orderslogAction_addOrderslog" method="post" namespace="/crm">
			<input type="hidden" value="${orders.id}" name="orders.id"/>
    		<div id="tabs2" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>付款信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">实际付款时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" name="paylog.realPayDate"/></td>
						</tr>
						<tr>
						<td align="right">付款金额:</td>
						<td><input type="text" style="width:185px;height:30px;" name="paylog.realPay"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存信息"/>
			</s:form>
		</div>
	</div>
	<!--弹出窗口、添加付款记录界面  start-->	
	
	<!--弹出窗口、添加交货记录界面 start-->
	<div id="goodcover3"></div>
	<div id="code3">
		<div class="close1"><a href="javascript:void(0)" id="closebt3"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<s:form theme="simple" action="orderslogAction_addOrderslog2" method="post" namespace="/crm">
			<input type="hidden" value="${orders.id}" name="orders.id"/>
    		<div id="tabs3" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>交货信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">实际交货时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" name="sendlog.realSendDate"/></td>
						</tr>
						<tr>
						<td align="right">交货数量:</td>
						<td><input type="text" style="width:185px;height:30px;" name="sendlog.sendNum"/></td>
						</tr>
						</table>
					</section>
				</div>
			</div>
			<input type="submit" value="保存信息"/>
			</s:form>
		</div>
	</div>
	<!--弹出窗口、添加交货记录界面 end-->
	
	<!--弹出窗口、修改交易记录 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" action="orderslogAction_updatePaylog2" method="post" namespace="/crm">
 			<input type="hidden" id="hpid" name="paylog.id" value=""/>
 			<input type="hidden" id="hoid" name="orders.id" value=""/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>付款信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">实际付款时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" id="prd" name="paylog.realPayDate"/></td>
						</tr>
						<tr>
						<td align="right">付款金额:</td>
						<td><input type="text" style="width:185px;height:30px;" id="prp" name="paylog.realPay"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、修改交易记录 end-->
	
	<!--弹出窗口、修改交货记录start-->
	<div id="goodcover4"></div>
	<div id="code4">
  		<div class="close1"><a href="javascript:void(0)" id="closebt4"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" action="orderslogAction_updateSendlog2" method="post" namespace="/crm">
 			<input type="hidden" id="hsid" name="sendlog.id" value=""/>
 			<input type="hidden" id="hoid2" name="orders.id" value=""/>
    		<div id="tabs4" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>交货信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">实际交货时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" id="srsd" name="sendlog.realSendDate"/></td>
						</tr>
						<tr>
						<td align="right">交货数量:</td>
						<td><input type="text" style="width:185px;height:30px;" id="ssn" name="sendlog.sendNum"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、修改交货记录end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
new CBPFWTabs( document.getElementById( 'tabs2' ) );
new CBPFWTabs( document.getElementById( 'tabs3' ) );
new CBPFWTabs( document.getElementById( 'tabs4' ) );
$(function() {
	//弹出层事件start
	$('#addnewp').click(function(){
		 $('#code2').center();
	     $('#goodcover2').show();
	     $('#code2').fadeIn();
	});
    $('#closebt2').click(function() {
        $('#code2').hide();
        $('#goodcover2').hide();
    });
	$('#goodcover2').click(function() {
        $('#code2').hide();
        $('#goodcover2').hide();
    });
	
	$('#addnews').click(function(){
		 $('#code3').center();
	     $('#goodcover3').show();
	     $('#code3').fadeIn();
	});
   $('#closebt3').click(function() {
       $('#code3').hide();
       $('#goodcover3').hide();
   });
	$('#goodcover3').click(function() {
       $('#code3').hide();
       $('#goodcover3').hide();
   });
	//弹出层事件end
});
</script>
	
  </body>
</html>
