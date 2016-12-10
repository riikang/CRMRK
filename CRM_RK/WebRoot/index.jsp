<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>客户关系管理系统-RK</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">  
	<script type="text/javascript" src="js/jquery-2.0.0.min.js"></script>
	<script type="text/javascript" src="js/daohang.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<link href="css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
	<link href="css/daohang.css" rel="stylesheet">
	<script> 
		$(function(){
			//检查登录权限
			if("${applicationScope.level}"!=4){
				alert("您没有权限浏览该页面，请重新登录");
				window.location.href="<%=path%>/login.jsp";
			}
			//默认加载页面
			document.getElementById("if1").setAttribute("src","version.jsp");
			//动态显示时间
			setInterval(function(){   
	            $("#atime").text("当前时间:"+new Date().toLocaleString());   
	        },1000); 
			
			/*控制切换菜单 start*/
			var isHiden = false;/*控制切换菜单*/
			$('#hiddenbar').click(function(){
				 if(isHiden){  
			        $('#daohang').animate({left:'+=180px'});//菜单块向左移动  
			     }else{  
			        $('#daohang').animate({left:'-=180px'}); //菜单块向右移动  
			     }  
			     isHiden = !isHiden; 
			});
			/*控制切换菜单 end*/
			
			/*个人信息，工作台样式切换 start*/
			$('#info').click(function(){
				$('#info').addClass("active");
				$('#workspace').removeClass("active");
				$('#if1').attr('src', '<%=path %>/crm/informationAction_managerInfo.action');
			});
			$('#workspace').click(function(){
				$('#workspace').addClass("active");
				$('#info').removeClass("active");
				$('#if1').attr('src', 'version.jsp');
			});
			$('dd').click(function(){
				$('#workspace').addClass("active");
				$('#info').removeClass("active");
			});
			/*个人信息，工作台样式切换 end*/
		});
	</script>  
	<style type="text/css">
		body{
			padding: 0;
			margin: 0;
		}
		.container-fluid{
			margin: 0;
			padding: 0;
		}
		.navbar{
			margin: 0;
			padding: 0;
		}
		.span10{
			margin-top: 10px;
			margin-bottom: 10px;
			padding-left:10px;
			padding-right:20px;
			width: 100%;
		}
	</style>
  </head>
  
  <body>
    <div class="container-fluid" id="LG">
    <!-- 顶部导航条 start -->
	<div class="row-fluid">
		<div class="span12" style="position:fixed;z-index:1008;">
			<div class="navbar">
				<div class="navbar-inner">
					<div class="container-fluid">
						 <a data-target=".navbar-responsive-collapse" data-toggle="collapse" class="btn btn-navbar">
						 	<span class="icon-bar"></span>
						 	<span class="icon-bar"></span>
						 	<span class="icon-bar"></span>
						 </a>
						 <a id="hiddenbar" href="javascript:void(0)" class="brand">客户关系管理系统</a>
						<div class="nav-collapse collapse navbar-responsive-collapse">
							<ul class="nav">
								<li id="workspace" class="active">
									<a href="javascript:void(0)">工作台</a>
								</li>
								<li id="info">
									<a href="javascript:void(0)">个人信息</a>
								</li>
							</ul>
							<ul class="nav pull-right">
								<li>
									<a href="javascript:void(0)">您好,${applicationScope.manager.email}</a>
								</li>
								<li>
									<a href="javascript:void(0)" id="atime"></a>
								</li>
								<li class="divider-vertical">
								</li>
								<li class="dropdown">
									 <a data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0)">主要功能<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findAllcustomer.action');">客户管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productAction_findAllProduct.action');">商品管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productReportAction_findAllProductReport.action');">商品销售报表</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerReportAction_findAllCustomerReport.action');">客户消费报表</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderAction_findAllOrder.action');">订单管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/salesmanAction_findAllsalesman.action');">销售员管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/channelAction_findAllchannel.action');">渠道商管理</a>
										</li>
										<li class="divider"></li>
										<li class="nav-header">
											账户
										</li>
										<li>
											<a href="javascript:$('#info').addClass('active');$('#workspace').removeClass('active');$('#if1').attr('src', '<%=path %>/crm/informationAction_managerInfo.action');">个人信息</a>
										</li>
										<li>
											<a href="javascript:window.location.href='<%=path%>/crm/loginRegisterAction_logout.action' ">注销</a>
										</li>
									</ul>
								</li>
								<li class="divider-vertical">
								</li>
								<li class="dropdown">
									 <a data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0)">消息(<span>0</span>)<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
									<!-- 
										<li>
											<a href="javascript:void(0)">新订单(<span>0</span>)</a>
										</li>
									
										<li>
											<a href="javascript:void(0)">新任务(<span>0</span>)</a>
										</li>
									-->
										<li>
											<a href="javascript:void(0)">新回复(<span>0</span>)</a>
										</li>
									</ul>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 顶部导航条 end -->
	
	<div class="row-fluid" style="margin-top:42px;">
		<div class="span12">
			<div class="row-fluid">
				<!-- 左侧导航条  start-->
				<div class="span2">
				<div class="leftsidebar_box" id="daohang">
					<div class="line"></div>
					<dl class="channel">
						<dt onClick="">销售管理<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderAction_findAllOrder.action');">销售订单</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/channelAction_findAllchannel.action');">销售渠道</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/salesmanAction_findAllsalesman.action');">销售员信息</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderslogAction_findAllOrders.action');">应收款项</a></dd>
					</dl>
	
					<dl class="channel">
						<dt onClick="">市场营销管理<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/missionAction_findAllmission.action');">营销任务</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/chanceAction_findAllchance.action');">销售机会</a></dd>
					</dl>
		
					<dl class="statistics">
						<dt onClick="">统计报表<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productReportAction_findAllProductReport.action');">商品销售报表</a></dd>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerReportAction_findAllCustomerReport.action');">客户消费统计</a></dd>
					</dl>
	
					<dl class="system_log">
						<dt>客户服务<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/emailMessageAction_customerpServer.action');">客户关怀</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_sfindAllservice.action');">投诉/意见/咨询处理</a></dd>
						<!--  <dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_sfindAllservice.action');">产品问答</a></dd>
						<dd><a href="#">客户满意度</a></dd>-->
					</dl>
	
					<dl class="custom">
						<dt onClick="">全部客户<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findAllcustomer.action');">所有客户</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findAllcustomerp.action');">个人客户</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findAllcustomerc.action');">企业客户</a></dd>
					</dl>
		
					<dl class="custom">
						<dt onClick="">客户状态<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer1.action');">潜在客户</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer2.action');">意向客户</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer3.action');">成交客户</a></dd>
						<!--<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer4.action');">已流失客户</a></dd> -->
					</dl>
		
					<dl class="custom">
						<dt onClick="">客户类型<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer5.action');">普通会员</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer6.action');">VIP1</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer7.action');">VIP2</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer8.action');">VIP3</a></dd>
					</dl>
		
					<dl class="source">
						<dt onClick="">商品管理<img src="images/left/select_xl01.png"></dt>
						<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productAction_findAllProduct.action');">
						所有商品</a></dd>
						<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productDictAction_findAllDict.action');">
						商品数据字典</a></dd>
					</dl>
				</div>
				</div>
				<!-- 左侧导航条  end-->
				
				
				<div class="span10">
					<iframe id="if1" width="100%" scrolling="auto" height="800" marginheight="0" frameBorder=0 name="ifrmtest" src="">
					</iframe>
				</div>
				
			</div>
			<!-- <div class="row-fluid"><div class="span12">页脚</div></div>  -->
		</div>
	</div>
</div>
  </body>
</html>
