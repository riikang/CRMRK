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
	<script src="<%=path%>/js/TableValidate.js"></script>
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
		
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0);">订单详情</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
        		<!--<li><a href="<%=path %>/crm/orderAction_findAllOrder.action">返回列表</a></li>  -->
           		  <li><a onclick="javascript:history.go(-1)" href="javascript:void(0);">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="update"><a href="javascript:void(0)">编辑</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 数据表格start  -->
			<div id="tableDiv">
				<input type="hidden" id="hh1" value="${orders.salesman.channel.cname}" />
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">订单信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">订单编号:&nbsp;</td><td id="oid" width="25%">${orders.id}</td>
						<td align="right" width="25%">主题:&nbsp;</td><td width="25%">${orders.title}</td>
					</tr>
					<tr>
						<td align="right">客户名称:&nbsp;</td><td id="t1">${orders.customerP.cname}</td>
						<td align="right">负责销售员:&nbsp;</td><td id="t2">${orders.salesman.sname}</td>
					</tr>
					<tr>
						<td align="right">成交商品:&nbsp;</td><td id="t3">${orders.product.pname}</td>
						<td align="right">关联销售机会:&nbsp;</td><td id="t4">${orders.chance.name}</td>
					</tr>
					<tr>
						<td align="right">更新客户状态:&nbsp;</td><td id="t5">${orders.cstatus}</td>
						<td align="right">更新客户类型:&nbsp;</td><td id="t6">${orders.ctype}</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">交易信息</td>
					</tr>
					<tr>
						<td align="right">付款时间:&nbsp;</td><td>${orders.paydate}</td>
						<td align="right">交货时间:&nbsp;</td><td>${orders.senddate}</td>
					</tr>
					<tr>
						<td align="right">接单时间:&nbsp;</td><td>${orders.dealdate}</td>
						<td align="right">成交数量:&nbsp;</td><td>${orders.amount}</td>
					</tr>
					<tr>
						<td align="right">实际成交单价:&nbsp;</td><td>${orders.dealprice}</td>
						<td align="right">利润:&nbsp;</td><td>${orders.profits}</td>
						
					</tr>
					<tr>
						<td align="right">实际成交总价:&nbsp;</td><td>${orders.dealpriceT}</td>
						<td align="right">商品总成本:&nbsp;</td><td>${orders.costingT}</td>
					</tr>
					<tr>
						<td align="right">订单状态:&nbsp;</td><td id="t7">${orders.status}</td>
						<td align="right">支付方式:&nbsp;</td><td id="t8">${orders.payways}</td>
					</tr>
					<tr>
						<td align="right">货币单位:&nbsp;</td><td id="t11">${orders.currency}</td>
						<td align="right">说明:&nbsp;</td><td id="t9">${orders.remarker}</td>
					</tr>
				</table>
			</div>
			<!-- 数据表格end  -->
		</div>
	</div>
	
	<!--弹出窗口、 修改界面 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updateordersform" action="orderAction_updateOrder" method="post" namespace="/crm">
 			<input type="hidden" name="orders.id" value="${orders.id}"/>
 			<input type="hidden" name="orders.dealdate" value="${orders.dealdate}"/>
 			<input type="hidden" name="orders.remainingPay" value="${orders.remainingPay}"/>
 			<input type="hidden" name="orders.paymoney" value="${orders.paymoney}"/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>订单信息</span></a></li>
						<li><a href="#section-2" ><span>交易信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">主题:</td>
						<td width="60%"><input type="text" value="${orders.title}" style="width:185px;height:30px;" name="orders.title"/></td>
						</tr>
						<tr>
						<td align="right">*客户名称:</td>
						<td><select style="width:185px;height:30px;" id="sel1" name="customerP.cname">
							<option value="">--请选择--</option>
							<s:iterator value="customerPs" id="cp1">
							<option value="<s:property value='#cp1.cname'/>"><s:property value='#cp1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">负责渠道:</td>
						<td><select style="width:185px;height:30px;" id="channelid" name="channel.cname">
							<s:iterator value="channels" id="ch1">
							<option value="<s:property value='#ch1.cname'/>"><s:property value='#ch1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*负责销售员:</td>
						<td><select style="width:185px;height:30px;" id="salesmanid" name="salesman.sname">
							<s:iterator value="salesmans" id="sm1">
							<option value='<s:property value="#sm1.sname"/>'><s:property value="#sm1.sname"/></option>
							</s:iterator>
						</select></td>
						</tr>
						<tr>
						<td align="right">*成交商品</td>
						<td><select style="width:185px;height:30px;" id="sel2" name="product.pname">
							<option value="">--请选择--</option>
							<s:iterator value="products" id="pp1">
							<option value="<s:property value='#pp1.pname'/>"><s:property value='#pp1.pname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">关联销售机会:</td>
						<td><select style="width:185px;height:30px;" id="sel3" name="chance.name">
							<option value="">--请选择--</option>
							<s:iterator value="chances" id="ch2">
							<option value="<s:property value='#ch2.name'/>"><s:property value='#ch2.name'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">更新客户状态:</td>
						<td><select style="width:185px;height:30px;" id="sel4" name="orders.cstatus">
							<option value="">--请选择--</option>
							<option value="潜在客户">潜在客户</option>
							<option value="意向客户">意向客户</option>
							<option value="成交客户">成交客户</option>
							<option value="已流失客户">已流失客户</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">更新客户类型:</td>
						<td><select style="width:185px;height:30px;" id="sel5" name="orders.ctype">
							<option value="">--请选择--</option>
							<option value="普通客户">普通客户</option>
							<option value="VIP1">VIP1</option>
							<option value="VIP2">VIP2</option>
							<option value="VIP3">VIP3</option>
  						</select></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="8">
						<tr>
						<td width="40%" align="right">付款时间</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" value="${orders.paydate}" name="orders.paydate"/></td>
						</tr>
						<tr>
						<td width="40%" align="right">交货时间</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" value="${orders.senddate}" name="orders.senddate"/></td>
						</tr>
						<tr>
						<td align="right">成交数量:</td>
						<td><input style="width:185px;height:30px;" id="num2" value="${orders.amount}" name="orders.amount" type="text"/></td>
						</tr>
						<tr>
						<td align="right">货币单位:</td>
						<td><select style="width:185px;height:30px;" id="sel11" name="orders.currency">
   						<s:iterator value="productDicts" id="pd4">
							<s:if test="#pd4.currency!=null">
							<option value="<s:property value='#pd4.currency'/>"><s:property value='#pd4.currency'/></option>
							</s:if></s:iterator></select></td>
						</tr>
						<tr>
						<td align="right">实际成交单价:</td>
						<td><input type="text" value="${orders.dealprice}" id="price2" style="width:185px;height:30px;" name="orders.dealprice"></td>
						</tr>
						<tr>
						<td align="right">订单状态:</td>
						<td><select style="width:185px;height:30px;" id="sel6" name="orders.status">
							<option value="">--请选择--</option>
							<option value="已付清款项">已付清款项</option>
							<option value="已付部分款项">已付部分款项</option>
							<option value="未付款">未付款</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">支付方式:</td>
						<td><select style="width:185px;height:30px;" id="sel7" name="orders.payways">
							<option value="">--请选择--</option>
							<option value="现金">现金</option>
							<option value="网上银行">网上银行</option>
							<option value="支票">支票</option>
							<option value="支付宝">支付宝</option>
							<option value="邮局付款">邮局付款</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">说明:</td>
						<td><textarea name="orders.remarker" id="tt1" style="width:300px;height:50px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input id="updateordersb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改界面 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//渠道商,销售员级联
	$('#channelid').change(function(){
		$("#salesmanid").empty();//清空  
	    var ccid = document.getElementById("channelid").value;  
	    var url = "crm/chanceAction_findSalesman.action?channel.cname=" + ccid;  
	    $.ajax( {  
	        type : "POST",  
	        url : url,  
	        data : {},  
	        dataType : "JSON",  
	        success : function(jsonStr) { 
	        	$.each(jsonStr,function(i,date){  
                    var _tr = $("<option value='"+date.sname+"'>"+date.sname+"</option>");  
                    $("#salesmanid").append(_tr);  
                }); 
	        }  
	    });  
	});
	
	//弹出层事件start
    $('#update').click(function() {
    	$('#sel1').val($('#t1').text());
    	$('#salesmanid').val($('#t2').text());
    	$('#sel2').val($('#t3').text());
    	$('#sel3').val($('#t4').text());
    	$('#sel4').val($('#t5').text());
    	$('#sel5').val($('#t6').text());
    	$('#sel6').val($('#t7').text());
    	$('#sel7').val($('#t8').text());
    	$('#tt1').val($('#t9').text());
    	$('#channelid').val($('#hh1').val());
    	$('#sel11').val($('#t11').text());
    	
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
