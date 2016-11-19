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
	<script type="text/javascript">
	var index=0;
	//判断用户权限等级
	$(function(){
		var ll="${applicationScope.level}";
		if(ll==4){
			$('#lname').text("经理");
		}else if(2<=ll<4){
			$('#lname').text("${applicationScope.ssname}");
		}else{
			$('#lname').text("${applicationScope.ssname}");
		}
	});
	//屏幕滚动事件,显示隐藏回到顶部按钮
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
  <div id="gotop" style="z-index:9999;position:fixed;bottom:100px;right:20px;display:none;">
  		<a href="javascript:scroll(0,0)"><img src="<%=path%>/images/top.png"></a>
  	</div>
    <div id="content">
		<div id="content-body">
		<!-- 导航条 -->
		<div class="demo">
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/serviceAction_findAllservice.action">返回列表</a></li>
           		  <li id="update"><a href="javascript:void(0)">结束服务</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 表格div start -->
			<div id="tableDiv">
				<input type="hidden" value="${servicelog.id}" id="servicelogid"/>
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">服务信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">客户:&nbsp;</td><td width="25%">${servicelog.customerP.cname}</td>
						<td align="right" width="25%">负责客服:&nbsp;</td><td width="25%">${servicelog.salesman.sname}</td>
					</tr>
					<tr>
						<td align="right">简述:&nbsp;</td><td colspan="3">${servicelog.title}</td>
					</tr>
					<tr>
						<td align="right">关联商品:&nbsp;</td><td>${servicelog.product.pname}</td>
						<td align="right">关联订单:&nbsp;</td><td>${servicelog.orders.title}</td>
					</tr>
					<tr>
						<td align="right">服务时间:&nbsp;</td><td>${servicelog.servicedate}</td>
						<td align="right">服务类型:&nbsp;</td><td>${servicelog.servicetype}</td>
					</tr>
					<tr>
						<td align="right">服务状态:&nbsp;</td><td>${servicelog.status}</td>
						<td align="right">服务方式:&nbsp;</td><td>${servicelog.serviceways}</td>
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
					<img src="images/customer.jpg" width="50px" height="50px" />
					<p>${servicelog.customerP.cname}</p>
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
			        		if(date.crole=='负责人'){
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
	
<!--服务评价界面 start -->
<div id="goodcover"></div>
<div id="code">
  	<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 	<div class="goodtxt">
 		<s:form theme="simple" id="updateserviceform2" action="serviceAction_updateServicelog" method="post" namespace="/crm">
 			<input type="hidden" name="servicelog.id" value="${servicelog.id}"/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>结束服务</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="20">
						<tr>
							<td width=100% colspan="2" align="center">感谢您的到来</td>
						</tr>
						<tr>
							<td width="40%" align="right">请对本次服务进行评价:</td>
							<td width="60%"><select style="width:185px;height:30px;" id="sel3" name="servicelog.evaluation">
								<option value="">--请选择--</option>
								<option value="非常满意">非常满意</option>
								<option value="满意">满意</option>
								<option value="一般">一般</option>
								<option value="不满意">不满意</option>
								<option value="非常不满意">非常不满意</option>
  							</select></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input id="updateserviceb2" type="button" value="结束服务"/>
		</s:form>
  	</div>
</div>
<!--服务评价界面 end -->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//显示、隐藏交流记录
	$('#aaa1').click(function(){
		if($('#aaa1').text()=="显示交流记录"){
			$('#aaa1').text("隐藏交流记录");
			//t = setTimeout(function() {                    
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
				        	if(date.crole=='负责人'){
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
		     //}, 1500);
		}else{
			$('#aaa1').text("显示交流记录");
			$('#info-show ul').empty();	
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
	
	//弹出层事件start
    $('#update').click(function() {
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
