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
		$(document).ready(function() {
			//表格自适应
    		$('.full-width').horizontalNav({});
		});
	</script>
  </head>
  
  <body>
  
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="orderAction_deleteSomeorder" namespace="/crm">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">应收款项</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		 <!--  <li id="addnew"><a href="javascript:void(0)">新增订单</a></li> -->
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
				exportTypes: ['excel'],
				search: true,
				clickToSelect: true,
				columns: [{field:"id",title:"订单标题",align:"center",valign:"middle",sortable:"true"},
				          {field:"time",title:"接单时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"pdate",title:"付款日期",align:"center",valign:"middle",sortable:"true"},
				          {field:"pmoney",title:"付款金额",align:"center",valign:"middle",sortable:"true"},
				          {field:"hpmoney",title:"已付款",align:"center",valign:"middle",sortable:"true"},
				          {field:"npmoney",title:"欠未付款",align:"center",valign:"middle",sortable:"true"},
				          {field:"op",title:"操作",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出列表数据  start-->
	<s:iterator value="orderss" id="od1">
		<script>
		init.dates[ii] = {
				'id' : '<a href="<%=path %>/crm/orderAction_findTheOrder.action?orders.id=<s:property value='#od1.id'/>">'+
							'&nbsp;<s:property value="#od1.title"/></a>',
				'time' : '<s:property value="#od1.dealdate"/>',
				'pdate':'<s:property value="#od1.paydate"/>',
				'pmoney' : '<s:property value="#od1.dealpriceT"/>',
				'hpmoney' : '<s:property value="#od1.paymoney"/>',
				'npmoney':'<s:property value="#od1.remainingPay"/>',
				'op' : '<a href="<%=path %>/crm/orderslogAction_findTheOrderlog.action?orders.id=<s:property value='#od1.id'/>">明细</a>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出列表数据  end-->
	
	<!-- 添加界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" action="orderAction_addorder" method="post" namespace="/crm">
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
						<td width="60%"><input type="text" style="width:185px;height:30px;" name="orders.title"/></td>
						</tr>
						<tr>
						<td align="right">客户名称:</td>
						<td><select style="width:185px;height:30px;" name="customerP.cname">
							<option value="">--请选择--</option>
							<s:iterator value="customerPs" id="cp1">
							<option value="<s:property value='#cp1.cname'/>"><s:property value='#cp1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">负责渠道:</td>
						<td><select style="width:185px;height:30px;" id="channelid" name="channel.cname">
							<option value="">--请选择--</option>
							<s:iterator value="channels" id="ch1">
							<option value="<s:property value='#ch1.cname'/>"><s:property value='#ch1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">负责销售员:</td>
						<td><select style="width:185px;height:30px;" id="salesmanid" name="salesman.sname"></select></td>
						</tr>
						<tr>
						<td align="right">成交商品</td>
						<td><select style="width:185px;height:30px;" name="product.pname">
							<option value="">--请选择--</option>
							<s:iterator value="products" id="pp1">
							<option value="<s:property value='#pp1.pname'/>"><s:property value='#pp1.pname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">关联销售机会:</td>
						<td><select style="width:185px;height:30px;" name="chance.name">
							<option value="">--请选择--</option>
							<s:iterator value="chances" id="ch2">
							<option value="<s:property value='#ch2.name'/>"><s:property value='#ch2.name'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">更新客户状态:</td>
						<td><select style="width:185px;height:30px;" name="orders.cstatus">
							<option value="">--请选择--</option>
							<option value="潜在客户">潜在客户</option>
							<option value="意向客户">意向客户</option>
							<option value="成交客户">成交客户</option>
							<option value="已流失客户">已流失客户</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">更新客户类型:</td>
						<td><select style="width:185px;height:30px;" name="orders.ctype">
							<option value="">--请选择--</option>
							<option value="普通客户">普通客户</option>
							<option value="VIP1">VIP1</option>
							<option value="VIP2">VIP2</option>
							<option value="VIP3">VIP3</option>
  						</select></td>
						</tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="8">
						<tr>
						<td width="40%" align="right">付款时间</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" name="orders.paydate"/></td>
						</tr>
						<tr>
						<td width="40%" align="right">交货时间</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" name="orders.senddate"/></td>
						</tr>
						<tr>
						<td align="right">成交数量:</td>
						<td><input style="width:185px;height:30px;" name="orders.amount" type="text"/></td>
						</tr>
						<tr>
						<td align="right">货币单位:</td>
						<td><select style="width:185px;height:30px;" name="orders.currency">
   						<s:iterator value="productDicts" id="pd4">
							<s:if test="#pd4.currency!=null">
							<option value="<s:property value='#pd4.currency'/>"><s:property value='#pd4.currency'/></option>
							</s:if></s:iterator></select></td>
						</tr>
						<tr>
						<td align="right">实际成交单价:</td>
						<td><input type="text" style="width:185px;height:30px;" name="orders.dealprice"></td>
						</tr>
						<tr>
						<td align="right">订单状态:</td>
						<td><select style="width:185px;height:30px;" name="orders.status">
							<option value="">--请选择--</option>
							<option value="已付清款项">已付清款项</option>
							<option value="已付部分款项">已付部分款项</option>
							<option value="未付款">未付款</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">支付方式:</td>
						<td><select style="width:185px;height:30px;" name="orders.payways">
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
						<td><textarea name="orders.remarker" style="width:300px;height:50px;resize:none;"></textarea></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//选择渠道商时，级联出销售员
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
	//弹出层事件 start
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
	//弹出层事件 end
});
</script>
	
  </body>
</html>
