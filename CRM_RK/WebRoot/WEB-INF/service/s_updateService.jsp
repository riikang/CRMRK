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
	<link rel="stylesheet" href="<%=path%>/css/inputmain.css" />
	<link rel="stylesheet" href="<%=path%>/css/sinaFaceAndEffec.css" />
	
	
	<script src="<%=path%>/js/jquery-3.0.0.min.js"></script>
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
	
	var index=0;
	$(function(){
		//判断用户权限，不同权限显示不同的照片
		var ll="${applicationScope.level}";
		if(ll==4){
			$('#lname').text("经理");
			$('#img1').attr('src','images/salesman.jpg');
		}else if(2<=ll<4){
			$('#lname').text("${applicationScope.ssname}");
			$('#img1').attr('src','images/salesman.jpg');
		}else{
			$('#lname').text("${applicationScope.ssname}");
			$('#img1').attr('src','images/salesman.jpg');
		}
	});
	//确认删除
	function confirm_delete(){
		if (!confirm("确认删除？")) {
        	window.event.returnValue = false;
       	}
		else{
			var idid=$('#servicelogid').val();
			window.location.href="<%=path %>/crm/serviceAction_deleteTheService.action?servicelog.id="+idid;
			alert("删除成功");
		}				
	}
	//滚动事件
	window.onscroll = function(){  
        if(document.body.scrollTop>100){  
                $('#gotop').show();  
        }  
        if(document.body.scrollTop<=100){  
                $('#gotop').hide();  
        }  
	}
	
	</script>
	
  </head>
  
  <body>
  	<!-- 回到顶部 start -->
  	<div id="gotop" style="z-index:9999;position:fixed;bottom:100px;right:20px;display:none;">
  		<a href="javascript:scroll(0,0)"><img src="<%=path%>/images/top.png"></a>
  	</div>
  	<!-- 回到顶部 end -->
  	
    <div id="content">
		<div id="content-body">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">交流记录</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/serviceAction_sfindAllservice.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="update"><a href="javascript:void(0)">编辑</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 表格div start -->
			<div id="tableDiv">
				<input type="hidden" value="${servicelog.id}" id="servicelogid"/>
				<input type="hidden" value="${servicelog.salesman.channel.cname}" id="ccname"/>
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">服务信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">客户:&nbsp;</td><td id="t2" width="25%">${servicelog.customerP.cname}</td>
						<td align="right" width="25%">负责客服:&nbsp;</td><td id="t6" width="25%">${servicelog.salesman.sname}</td>
					</tr>
					<tr>
						<td align="right">简述:&nbsp;</td><td id="t1" colspan="3">${servicelog.title}</td>
					</tr>
					<tr>
						<td align="right">关联商品:&nbsp;</td><td id="t7">${servicelog.product.pname}</td>
						<td align="right">关联订单:&nbsp;</td><td id="t8">${servicelog.orders.title}</td>
					</tr>
					<tr>
						<td align="right">服务时间:&nbsp;</td><td>${servicelog.servicedate}</td>
						<td align="right">服务类型:&nbsp;</td><td id="t3">${servicelog.servicetype}</td>
					</tr>
					<tr>
						<td align="right">服务状态:&nbsp;</td><td id="t5">${servicelog.status}</td>
						<td align="right">服务方式:&nbsp;</td><td id="t4">${servicelog.serviceways}</td>
					</tr>
					<tr>
						<td align="right">服务评价:&nbsp;</td><td colspan="3">${servicelog.evaluation}</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">交流区</td>
					</tr>
				</table>
			</div>
			<!-- 表格div end -->
		</div>
		
		<!-- 评论输入框  start-->
		<div  class="wrap" style="margin-top:30px;">
				<div class="comment">
					<div class="head-face">
						<img id="img1" src="" width="50px" height="50px" />
						<p id="lname"></p>
					</div>
					<div class="content">
						<div class="cont-box">
							<textarea class="text" placeholder="请输入..."></textarea>
						</div>
						<div class="tools-box">
							<div class="operator-box-btn"><span class="face-icon">☺</span><span class="img-icon">▧</span>
							<span style="margin-left:15px;"><a id="aaa1" href="javascript:void(0)">显示交流记录</a></span></div>
							<div class="submit-btn"><input type="button" onClick="out()" value="提交评论" /></div>
						</div>
					</div>
				</div>
				<div id="info-show">
					<ul></ul>
				</div>
				<div id="loading" style="margin-top:30px;display:none;">
					<h4 align="center">——————————<a id="loading2" href="javascript:void(0)">显示更多</a>——————————</h4>
				</div>
			</div>
			<!-- 评论输入框  end-->
	</div>
	
<script src="<%=path%>/js/inputmain.js"></script>
<script src="<%=path%>/js/sinaFaceAndEffec.js"></script>
<script type="text/javascript">
	// 绑定表情
	$('.face-icon').SinaEmotion($('.text'));
	// 测试本地解析
	function out() {	
		$.ajax( {  
			type : "POST",  
			url : "<%=path %>/crm/communionlogAction_addCommunionlogByAjax.action",  
			data : {c_id:$('#servicelogid').val(),c_context:$('.text').val()},  
			dataType : "JSON",  
			success : function(jsonStr2) {
			      	  	index=0;
			        	$('#info-show ul').empty();
			        	var html="";
			        	var role="";
			        	$.each(jsonStr2,function(i,date){
			        		index++;
			        		if(date.crole=="负责人"){
			        			role="客服";
			        		}else if(date.crole=="经理"){
			        			role="经理";
			        		}else{
			        			role="客户";
			        		}
		                    html  = '<li>';
		        			html += '<div class="head-face">';
		        			if(role=="客服"){
				    			html += '<img <img src="images/salesman.jpg" width="50px" height="50px" / >';
				    		}else if(role=="经理"){
				    			html += '<img <img src="images/manager.jpg" width="50px" height="50px" / >';
				    		}else{
				    			html += '<img <img src="images/customer.jpg" width="50px" height="50px" / >';
				    		}
		        			html += '</div>';
		        			html += '<div class="reply-cont">';
		        			html += '<p class="username">'+date.name+'&nbsp;&nbsp;'+role+'</p>';
		        			html += '<p class="comment-body">'+AnalyticEmotion(date.context)+'</p>';
		        			html += '<p class="comment-footer">'+ date.cdate +'</p>';
		        			html += '</div>';
		        			html += '</li>';
		                    $('#info-show ul').append(html);
		               });
			        	$('.text').val("");
			        	if($('#aaa1').text()=="显示交流记录"){
			        		$('#aaa1').text("隐藏交流记录");
			        	}
			        	if(index>=10){
			        		$('#loading').show();
			        	}
			        }  
			}); 			
		}	
</script>
	
<!--编辑服务记录 start-->
<div id="goodcover"></div>
<div id="code">
  	<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 	<div class="goodtxt">
 	<s:form theme="simple" id="updateserviceform" action="serviceAction_supdateServicelog" method="post" namespace="/crm">
 		<input type="hidden" name="servicelog.id" value="${servicelog.id}"/>
 		<input type="hidden" name="servicelog.servicedate" value="${servicelog.servicedate}"/>
    	<div id="tabs" class="tabs">
			<nav>
				<ul>
					<li><a href="#section-1" ><span>编辑服务</span></a></li>
					<li><a href="#section-1" ><span>服务状态</span></a></li>
				</ul>
			</nav>
			<div class="content">
				<section id="section-1">
					<table width=100% align="center" cellpadding="5">
					<tr>
					<td width="40%" align="right">*问题简述:</td>
					<td width="60%"><textarea name="servicelog.title" id="tt1" style="width:300px;height:150px;resize:none;"></textarea></td>
					</tr>
					<tr>
					<td align="right">*服务对象:</td>
					<td><select style="width:185px;height:30px;" id="sel1" name="customerP.cname">
						<option value="">--请选择--</option>
						<s:iterator value="customerPs" id="cp1">
						<option value="<s:property value='#cp1.cname'/>"><s:property value='#cp1.cname'/></option>
						</s:iterator>
  					</select></td>
					</tr>
					<tr>
					<td align="right">服务类型:</td>
					<td><select style="width:185px;height:30px;" id="sel2" name="servicelog.servicetype">
						<option value="">--请选择--</option>
						<option value="客户意见">客户意见</option>
						<option value="产品咨询">产品咨询</option>
						<option value="产品投诉">产品投诉</option>
						<option value="产品售后">产品售后</option>
						<option value="其他">其他</option>
  					</select></td>
					</tr>
					<tr>
					<td align="right">服务方式:</td>
					<td><select style="width:185px;height:30px;" id="sel3" name="servicelog.serviceways">
						<option value="">--请选择--</option>
						<option value="电话">电话</option>
						<option value="在线交流">在线交流</option>
						<option value="邮件">邮件</option>
						<option value="传真">传真</option>
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
					<section id="section-2">
						<table width=100% align="center" cellpadding="8">
						<tr>
							<td width="40%" align="right">服务状态:</td>
							<td width="60%"><select style="width:185px;height:30px;" id="sel4" name="servicelog.status">
								<option value="">--请选择--</option>
								<option value="未处理">未处理</option>
								<option value="已处理">已处理</option>
  							</select></td>
						</tr>
						<tr>
							<td align="right">分配销售员:</td>
							<td><select style="width:185px;height:30px;" id="channelid" name="channel.cname">
								<s:iterator value="channels" id="ch1">
								<option value="<s:property value='#ch1.cname'/>"><s:property value='#ch1.cname'/></option>
								</s:iterator>
  							</select>
  							<select style="width:185px;height:30px;" id="salesmanid" name="salesman.sname">
								<s:iterator value="salesmans" id="sa1">
								<option value="<s:property value='#sa1.sname'/>"><s:property value='#sa1.sname'/></option>
								</s:iterator>
  							</select>
  						</td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="updateserviceb" type="button" value="保存更改"/>
	</s:form>
  	</div>
</div>
<!--编辑服务记录 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//显示（隐藏）交流记录相关jq事件
	$('#aaa1').click(function(){
		if($('#aaa1').text()=="显示交流记录"){
			$('#aaa1').text("隐藏交流记录");
			$.ajax( {  
		        type : "POST",  
		        url : "<%=path %>/crm/communionlogAction_findAllCommunionlogByAjax.action",  
		        data : {ididid:$('#servicelogid').val()},  
		        dataType : "JSON",  
		        success : function(jsonStr) {
		        	index=0;
		        	var html;
		        	var role="";
		        	$.each(jsonStr,function(i,date){
		        		index++;
		        		if(date.crole=="负责人"){
		        			role="客服";
		        		}else if(date.crole=="经理"){
		        			role="经理";
		        		}else{
		        			role="客户";
		        		}
		                html  = '<li>';
		    			html += '<div class="head-face">';
		    			if(role=="客服"){
			    			html += '<img <img src="images/salesman.jpg" width="50px" height="50px" / >';
			    		}else if(role=="经理"){
			    			html += '<img <img src="images/manager.jpg" width="50px" height="50px" / >';
			    		}else{
			    			html += '<img <img src="images/customer.jpg" width="50px" height="50px" / >';
			    		}
		    			html += '</div>';
		    			html += '<div class="reply-cont">';
		    			html += '<p class="username">'+date.name+'&nbsp;&nbsp;'+role+'</p>';
		    			html += '<p class="comment-body">'+AnalyticEmotion(date.context)+'</p>';
		    			html += '<p class="comment-footer">'+ date.cdate +'</p>';
		    			html += '</div>';
		    			html += '</li>';
		                $('#info-show ul').append(html);
		            });
		        	if(index>=10){
		        		$('#loading').show();
		        	}
		        }  
		    });
		}else{
			$('#aaa1').text("显示交流记录");
			$('#info-show ul').empty();
			index=0;
		}
	});
	
	//加载更多记录
	$('#loading2').click(function(){
		$.ajax( {  
	        type : "POST",  
	        url : "<%=path %>/crm/communionlogAction_findMoreCommunionlogByAjax.action",  
	        data : {index2:index,c_id:$('#servicelogid').val()},  
	        dataType : "JSON",  
	        success : function(jsonStr) {
	        	var html2=$('#info-show ul').html();
	        	$('#info-show ul').empty();
	        	var index2=0;
	        	var html;
	        	var role="";
	        	$.each(jsonStr,function(i,date){
	        		if(date.context=="endendend"){
	        			$('#info-show ul').html(html2);
	        			alert('没有更多记录');
	        		}else{
	        			index2++;
	        			index=index2;
		        		if(date.crole=="负责人"){
		        			role="客服";
		        		}else if(date.crole=="经理"){
		        			role="经理";
		        		}else{
		        			role="客户";
		        		}
		                html  = '<li>';
		    			html += '<div class="head-face">';
		    			if(role=="客服"){
			    			html += '<img <img src="images/salesman.jpg" width="50px" height="50px" / >';
			    		}else if(role=="经理"){
			    			html += '<img <img src="images/manager.jpg" width="50px" height="50px" / >';
			    		}else{
			    			html += '<img <img src="images/customer.jpg" width="50px" height="50px" / >';
			    		}
		    			html += '</div>';
		    			html += '<div class="reply-cont">';
		    			html += '<p class="username">'+date.name+'&nbsp;&nbsp;'+role+'</p>';
		    			html += '<p class="comment-body">'+AnalyticEmotion(date.context)+'</p>';
		    			html += '<p class="comment-footer">'+ date.cdate +'</p>';
		    			html += '</div>';
		    			html += '</li>';
		                $('#info-show ul').append(html);
	        		}
	            });
	        	$('#loading').show();
	        }
		});
	});
	
	//渠道商,销售员级联事件
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
	
	//"是否关联订单号"相关事件
	$('#checkbox1').change(function(){
		if($('#checkbox1').prop('checked')){
			$('#checktr1').after(
				"<tr id='newtr1'><td align='right'>请选择订单号:</td>"+
				"<td><select style='width:185px;height:30px;' id='box1' name='orders.title'></select></td></tr>"	
			);
			 $.ajax( {  
			        type : "POST",  
			        url : "crm/serviceAction_findAllOrdersByAjax.action",  
			        data : {},  
			        dataType : "JSON",  
			        success : function(jsonStr) { 
			        	$.each(jsonStr,function(i,date){  
		                    var _tr = $("<option value='"+date.title+"'>"+date.title+"</option>");  
		                    $("#box1").append(_tr);  
		                }); 
			        }  
			    });  
		}else{
			$('#newtr1').remove();
		}
	});
	
	//"是否关联商品"相关事件
	$('#checkbox2').change(function(){
		if($('#checkbox2').prop('checked')){
			$('#checktr2').after(
				"<tr id='newtr2'><td align='right'>请选择商品:</td>"+
				"<td><select style='width:185px;height:30px;' id='box2' name='product.pname'></select></td></tr>"	
			);
			 $.ajax( {  
			        type : "POST",  
			        url : "crm/serviceAction_findAllProductByAjax.action",  
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
	
	/*弹出层相关事件start */
    $('#update').click(function() {
    	$('#tt1').val($('#t1').text());
    	$('#sel1').val($('#t2').text());
    	$('#sel2').val($('#t3').text());
    	$('#sel3').val($('#t4').text());
    	$('#sel4').val($('#t5').text());
    	$('#salesmanid').val($('#t6').text());
    	$('#channelid').val($('#ccname').val());
    	
    	$('#newtr1').remove();
    	$('#newtr2').remove();
    	var t7=$('#t7').text();
    	var t8=$('#t8').text();
    	if(t7==null||t7==""){
    		$('#checkbox2').attr('checked',false);
    	}else{
    		$('#checkbox2').attr('checked',true);
    		$('#checktr2').after(
    				"<tr id='newtr2'><td align='right'>请选择商品:</td>"+
    				"<td><select style='width:185px;height:30px;' id='box2' name='product.pname'>"+
    				"<s:iterator value='products' id='pd1'>"+
    				"<option value='<s:property value='#pd1.pname'/>'><s:property value='#pd1.pname'/></option>"+
    				"</s:iterator>"+
    				"</select></td></tr>"	
    			);
    		$('#box2').val(t7);
    	}
    	if(t8==null||t8==""){
    		$('#checkbox1').attr('checked',false);
    	}else{
    		$('#checkbox1').attr('checked',true);
    		$('#checktr1').after(
    				"<tr id='newtr1'><td align='right'>请选择订单号:</td>"+
    				"<td><select style='width:185px;height:30px;' id='box1' name='orders.title'>"+
    				"<s:iterator value='orderss' id='or1'>"+
    				"<option value='<s:property value='#or1.title'/>'><s:property value='#or1.title'/></option>"+
    				"</s:iterator>"+
    				"</select></td></tr>"	
    			);
    		$('#box1').val(t8);
    	}
    	
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
	/*弹出层相关事件end */
});
</script>
	
  </body>
</html>
