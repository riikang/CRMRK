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
	
	<script type="text/javascript" src="js/jquery-3.0.0.min.js"></script>
	<script type="text/javascript" src="js/daohang.js"></script>
	<script type="text/javascript" src="js/jquery-ui.js"></script>
	<script type="text/javascript" src="js/bootstrap.min.js"></script>
	<link href="css/bootstrap-combined.min.css" rel="stylesheet" media="screen">
	<link href="css/daohang.css" rel="stylesheet">
	
	<script>  
	$(function(){
		//检查登录权限
		if("${applicationScope.level}"!=1){
			alert("您没有权限浏览该页面，请重新登录");
			window.location.href="<%=path%>/login.jsp";
		}
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
			$('#if1').attr('src', '');
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
								<li>
									<a href="#">备用链接</a>
								</li>
								
							</ul>
							<ul class="nav pull-right">
								<li>
									<a href="#">您好,${applicationScope.user.email}</a>
								</li>
								<li>
									<a href="javascript:void(0);" id="atime"></a>
								</li>
								<li class="divider-vertical">
								</li>
								<li class="dropdown">
									 <a data-toggle="dropdown" class="dropdown-toggle" href="#">下拉菜单<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<li>
											<a href="#">下拉导航1</a>
										</li>
										<li>
											<a href="#">下拉导航2</a>
										</li>
										<li>
											<a href="#">其他</a>
										</li>
										<li class="divider">
										</li>
										<li class="nav-header">
											标签
										</li>
										<li>
											<a href="#">链接1</a>
										</li>
										<li>
											<a href="#">链接2</a>
										</li>
									</ul>
								</li>
								<li class="divider-vertical">
								</li>
								<li class="dropdown">
									 <a data-toggle="dropdown" class="dropdown-toggle" href="#">消息(<span>0</span>)<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<li>
											<a href="#">新订单(<span>0</span>)</a>
										</li>
										<li>
											<a href="#">新销售机会(<span>0</span>)</a>
										</li>
										<li>
											<a href="#">新营销任务(<span>0</span>)</a>
										</li>
										<li>
											<a href="#">新回复(<span>0</span>)</a>
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
							<dt>客户服务<img src="images/left/select_xl01.png"></dt>
							<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderAction_findCustomerOrder.action');">消费记录</a></dd>
							<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_findAllservice.action');">投诉/意见/咨询</a></dd>
							<!-- <dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_findAllservice.action');">产品问答</a></dd> -->
						</dl>
					</div>
				</div>
				<!-- 左侧导航条  end-->
				
				<!-- 右侧主要内容显示区域  start-->
				<div class="span10">
					<iframe id="if1" width="100%" height="800" scrolling="auto" marginheight="0" frameBorder=0 name="ifrmtest" src=""></iframe>
				</div>
				<!-- 右侧主要内容显示区域  end-->
			</div>
			<!--<div class="row-fluid"><div class="span12">页脚 </div></div>-->
		</div>
	</div>
	</div>
  </body>
</html>
