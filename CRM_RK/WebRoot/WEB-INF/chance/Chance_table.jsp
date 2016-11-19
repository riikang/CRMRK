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
		//判断所选行是否为空，以及确认是否删除-S
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
		//判断所选行是否为空，以及确认是否删除-E
		
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
           		  <li><a href="javascript:void(0)">销售机会</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">批量删除</a></li>
           		  <li id="addnew"><a href="javascript:void(0)">新增销售机会</a></li>
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
	
	<!-- 添加界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addchanceform" action="chanceAction_addchance" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>机会信息</span></a></li>
						<li><a href="#section-2" ><span>商品信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">*机会名称:</td>
						<td width="60%"><input type="text" id="chancename" style="width:185px;height:30px;" name="chance.name"/></td>
						</tr>
						<tr>
						<td align="right">*客户名称:</td>
						<td><select style="width:185px;height:30px;" id="cpname" name="customerP.cname">
							<option value="">--请选择--</option>
							<s:iterator value="customerPs" id="cp1">
							<option value="<s:property value='#cp1.cname'/>"><s:property value='#cp1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*渠道名称:</td>
						<td><select style="width:185px;height:30px;" id="channelid" name="channel.cname">
							<option value="null">--请选择--</option>
							<s:iterator value="channels" id="ch1">
							<option value="<s:property value='#ch1.cname'/>"><s:property value='#ch1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*销售员:</td>
						<td><select style="width:185px;height:30px;" id="salesmanid" name="salesman.sname"></select></td>
						</tr>
						<tr>
						<td align="right">机会来源</td>
						<td><select style="width:185px;height:30px;" name="chance.source">
							<option value="">--请选择--</option>
							<option value="市场活动">市场活动</option>
							<option value="客户介绍">客户介绍</option>
							<option value="自动上门">自动上门</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">机会描述</td>
						<td><textarea name="chance.description" id="cdes" style="resize:none;width:300px;height:100px;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">*意向商品</td>
						<td width="60%"><select style="width:185px;height:30px;" id="pname" name="product.pname">
							<option value="">--请选择--</option>
							<s:iterator value="products" id="p1">
							<option value="<s:property value='#p1.pname'/>"><s:property value='#p1.pname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">需求数量:</td>
						<td><input style="width:185px;height:30px;" id="cnum" name="chance.amount" type="text"/></td>
						</tr>
						<tr>
						<td align="right">机会阶段:</td>
						<td><select style="width:185px;height:30px;" name="chance.stage">
							<option value="初期沟通">初期沟通</option>
							<option value="立项评估">立项评估</option>
							<option value="商务谈判">商务谈判</option>
							<option value="确认订单">确认订单</option>
							<option value="成功交易">成功交易</option>
							<option value="失败交易">失败交易</option>
							<option value="游说">游说</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">备注:</td>
						<td><textarea name="chance.Remarks" id="remark" style="width:300px;height:100px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="addchanceb" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//判断用户等级，如果是3（渠道商）,读出销售员列表,设渠道商为不可编辑
	if("${applicationScope.level}"==3){
		var ccid = "${applicationScope.user.channel.cname}";
		$.ajax({  
	        type : "POST",  
	        url : "crm/chanceAction_findSalesman.action?channel.cname=" + ccid,  
	        data : {},  
	        dataType : "JSON",  
	        success : function(jsonStr) {
	        	$.each(jsonStr,function(i,date){  
                    var _tr = $("<option value='"+date.sname+"'>"+date.sname+"</option>");  
                    $("#salesmanid").append(_tr);  
                }); 
	        }  
	    }); 
		$('#channelid').val("${applicationScope.user.channel.cname}");
		$('#channelid').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
	}
	
	//判断用户等级，如果是2（销售员）,读出销售员的渠道商，并设渠道商和销售员为不可编辑
	if("${applicationScope.level}"==2){
		var ccid = "${applicationScope.user.channel.cname}";
		$.ajax({  
	        type : "POST",  
	        url : "crm/chanceAction_findSalesman.action?channel.cname=" + ccid,  
	        data : {},  
	        dataType : "JSON",  
	        success : function(jsonStr) {
	        	$.each(jsonStr,function(i,date){  
                    var _tr = $("<option value='"+date.sname+"'>"+date.sname+"</option>");  
                    $("#salesmanid").append(_tr);  
                }); 
	        }  
	    });
		$('#channelid').val("${applicationScope.user.channel.cname}");
		$('#channelid').attr("disabled","desabled");
		$('#salesmanid').val("${applicationScope.user.sname}");
		$('#salesmanid').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#tabs').append("<input type='hidden' id='hid2' name='salesman.sname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
		$('#hid2').val("${applicationScope.user.sname}");
	}
	
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
})
</script>
	
  </body>
</html>
