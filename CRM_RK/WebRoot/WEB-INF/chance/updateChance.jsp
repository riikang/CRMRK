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
		    }else{
				var idid=$('#cid').text();
				window.location.href="<%=path %>/crm/chanceAction_deleteTheChance.action?chance.id="+idid;
				alert("删除成功");
			}				
		}
		//打开该机会的相关“跟进记录”
		function followup(){
			window.location.href="<%=path %>/crm/followupAction_findAllFollowup.action";
		}
		
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">销售机会详情</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/chanceAction_findAllchance.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="update"><a href="javascript:void(0)">编辑</a></li>
           		  <li onclick="followup()"><a href="javascript:void(0)">跟进记录</a></li>
        		</ul>
    		</div>
		</div>
		<!-- 数据表格  start-->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">机会信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">机会编号:&nbsp;</td><td id="cid" width="25%">${chance.id}</td>
						<td align="right" width="25%">机会名称:&nbsp;</td><td width="25%">${chance.name}</td>
					</tr>
					<tr>
						<td align="right">客户名称:&nbsp;</td><td id="t1">${chance.customerP.cname}</td>
						<td align="right">机会来源:&nbsp;</td><td id="t4">${chance.source}</td>
					</tr>
					<tr>
						<td align="right">负责渠道:&nbsp;</td><td id="t2">${chance.channel.cname}</td>
						<td align="right">负责销售员:&nbsp;</td><td id="t3">${chance.salesman.sname}</td>
					</tr>
					<tr>
						<td align="right">机会描述:&nbsp;</td><td id="t5">${chance.description}</td>
						<td align="right">获取机会时间:&nbsp;</td><td>${chance.getDate}</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">商品信息</td>
					</tr>
					<tr>
						<td align="right">意向商品:&nbsp;</td><td id="t6">${chance.product.pname}</td>
						<td align="right">需求数量:&nbsp;</td><td>${chance.amount}</td>
					</tr>
					<tr>
						<td align="right">预计成交总额:&nbsp;</td><td>${chance.total}</td>
						<td align="right">机会阶段:&nbsp;</td><td id="t7">${chance.stage}</td>
					</tr>
					<tr>
						<td align="right">备注:&nbsp;</td>
						<td colspan="3" id="t8">${chance.remarks}</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">跟踪记录</td>
					</tr>
					<s:iterator value="followups" id="ff1">
					<tr id="followuptr">
						<td align="right">跟进日期:&nbsp;</td><td><s:property value="#ff1.connectTime"/></td>
						<td align="right">跟进内容:&nbsp;</td><td><s:property value="#ff1.project"/></td>
					</tr>
					</s:iterator>
				</table>
			</div>
		<!-- 数据表格  end-->
		</div>
	</div>
	
	<!--弹出窗口、 修改界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatechanceform" action="chanceAction_updateChance" method="post" namespace="/crm">
 			<input type="hidden" id="chanceid" name="chance.id" value="${chance.id}"/>
 			<input type="hidden" name="chance.getDate" value="${chance.getDate}"/>
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
						<td width="60%"><input type="text" id="chancename" style="width:185px;height:30px;" value="${chance.name}" name="chance.name"/></td>
						</tr>
						<tr>
						<td align="right">*客户名称:</td>
						<td><select style="width:185px;height:30px;" id="sel1" name="customerP.cname">
							<s:iterator value="customerPs" id="cp1">
							<option value="<s:property value='#cp1.cname'/>"><s:property value='#cp1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*渠道名称:</td>
						<td><select style="width:185px;height:30px;" id="channelid" name="channel.cname">
							<s:iterator value="channels" id="ch1">
							<option value="<s:property value='#ch1.cname'/>"><s:property value='#ch1.cname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*销售员:</td>
						<td><select style="width:185px;height:30px;" id="salesmanid" name="salesman.sname">
								<s:iterator value="salesmans" id="sl1">
								<option value='<s:property value="#sl1.sname"/>'><s:property value="#sl1.sname"/></option>
								</s:iterator>
						</select></td>
						</tr>
						<tr>
						<td align="right">机会来源</td>
						<td><select style="width:185px;height:30px;" id="sel2" name="chance.source">
							<option value="">--请选择--</option>
							<option value="市场活动">市场活动</option>
							<option value="客户介绍">客户介绍</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">机会描述</td>
						<td><textarea name="chance.description" id="tt1" style="resize:none;width:300px;height:100px;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">*意向商品</td>
						<td width="60%"><select style="width:185px;height:30px;" id="sel3" name="product.pname">
							<option value="">--请选择--</option>
							<s:iterator value="products" id="p1">
							<option value="<s:property value='#p1.pname'/>"><s:property value='#p1.pname'/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">需求数量:</td>
						<td><input style="width:185px;height:30px;" id="cnum" value="${chance.amount}" name="chance.amount" type="text"/></td>
						</tr>
						<tr>
						<td align="right">机会阶段:</td>
						<td><select style="width:185px;height:30px;" id="sel4" name="chance.stage">
							<option value="初期沟通">初期沟通</option>
							<option value="商务谈判">商务谈判</option>
							<option value="确认订单">确认订单</option>
							<option value="成功交易">成功交易</option>
							<option value="失败交易">失败交易</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">备注:</td>
						<td><textarea name="chance.Remarks" id="tt2" style="resize:none;width:300px;height:100px;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="updatechanceb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//如果用户等级为3（渠道商）,设置渠道商为不可编辑
	if("${applicationScope.level}"==3){
		$('#channelid').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
	}
	//如果用户等级为2（销售员）,设置渠道商和销售员为不可编辑
	if("${applicationScope.level}"==2){
		$('#channelid').attr("disabled","desabled");
		$('#salesmanid').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
		$('#tabs').append("<input type='hidden' id='hid2' name='salesman.sname'/>");
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
    $('#update').click(function() {
    	$('#sel1').val($('#t1').text());
    	$('#channelid').val($('#t2').text());
    	$('#salesmanid').val($('#t3').text());
    	$('#sel2').val($('#t4').text());
    	$('#tt1').val($('#t5').text());
    	$('#sel3').val($('#t6').text());
    	$('#sel4').val($('#t7').text());
    	$('#tt2').val($('#t8').text());
    	
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
