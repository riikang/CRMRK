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
		var neworders=0,newmission=0,newchance=0,newservice=0,newcallback=0,newall=0;
		var neworders2="",newmission2="",newchance2="",newservice2="",newcallback2="",newall2="";
		var newchanceid="",newmissionid="";
		$(function(){
			if("${applicationScope.level}"!=2){
				alert("您没有权限浏览该页面，请重新登录");
				window.location.href="<%=path%>/login.jsp";
			}
			//默认加载页面
			document.getElementById("if1").setAttribute("src","version.jsp");
			
			setInterval(function(){   
	            $("#atime").text("当前时间:"+new Date().toLocaleString());   
	        },1000); 
			
			var isHiden = false;/*控制切换菜单*/
			$('#hiddenbar').click(function(){
				 if(isHiden){  
			        $('#daohang').animate({left:'+=180px'});//菜单块向左移动  
			     }else{  
			        $('#daohang').animate({left:'-=180px'}); //菜单块向右移动  
			     }  
			     isHiden = !isHiden; 
			});
			
			$('#info').click(function(){
				$('#info').addClass("active");
				$('#workspace').removeClass("active");
				$('#if1').attr('src', '<%=path %>/crm/informationAction_salesmanInfo.action');
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
		});
	</script> 
	
	<s:iterator value="messages" id="m1" status="st">
	<s:if test="#m1.iflook==1">
		<s:if test="#m1.type==1">
		<script>
			neworders++;
			if(neworders2==""){
				neworders2=${m1.mid};
			}else{
				neworders2=neworders2+","+${m1.mid};
			}
		</script>
		</s:if>
		<s:if test="#m1.type==4">
		<script>
			newmission++;
			if(newmission2==""){
				newmission2=${m1.mid};
			}else{
				newmission2=newmission2+","+${m1.mid};
			}
			if(newmissionid==""){
				newmissionid=${m1.id};
			}else{
				newmissionid=newmissionid+","+${m1.id};
			}
		</script>
		</s:if>
		<s:if test="#m1.type==5">
		<script>
			newchance++;
			if(newchance2==""){
				newchance2=${m1.mid};
			}else{
				newchance2=newchance2+","+${m1.mid};
			}
			if(newchanceid==""){
				newchanceid=${m1.id};
			}else{
				newchanceid=newchanceid+","+${m1.id};
			}
		</script>
		</s:if>
		<s:if test="#m1.type==2">
		<script>
			newservice++;
			if(newservice2==""){
				newservice2=${m1.mid};
			}else{
				newservice2=newservice2+","+${m1.mid};
			}
		</script>
		</s:if>
		<s:if test="#m1.type==3">
		<script>
			newcallback++;
			if(newcallback2==""){
				newcallback2=${m1.mid};
			}else{
				newcallback2=newcallback2+","+${m1.mid};
			}
		</script>
		</s:if>
	</s:if>
	</s:iterator>
	
	<script>
		newall=neworders+newmission+newchance+newservice+newcallback;
		$(function(){
			$('#mm6').text(newall);
			$('#mm1').text(neworders);
			$('#mm2').text(newchance);
			$('#mm3').text(newmission);
			$('#mm4').text(newservice);
			$('#mm5').text(newcallback);
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
									<a href="javascript:void(0)">您好,${applicationScope.user.email}</a>
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
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderAction_findAllOrder.action);">订单管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/missionAction_findAllmission.action');">任务管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/chanceAction_findAllchance.action');">机会管理</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/productReportAction_findAllProductReport.action');">商品销售报表</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerReportAction_findAllCustomerReport.action');">客户消费报表</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/emailMessageAction_customerpServer.action');">客户关怀</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_sfindAllservice.action');">客户服务</a>
										</li>
										<li class="divider"></li>
										<li class="nav-header">
											账户
										</li>
										<li>
											<a href="javascript:$('#info').addClass('active');$('#workspace').removeClass('active');$('#if1').attr('src', '<%=path %>/crm/informationAction_salesmanInfo.action');">个人信息</a>
										</li>
										<li>
											<a href="javascript:window.location.href='<%=path%>/crm/loginRegisterAction_logout.action'">注销</a>
										</li>
									</ul>
								</li>
								<li class="divider-vertical">
								</li>
								<li class="dropdown">
									 <a data-toggle="dropdown" class="dropdown-toggle" href="javascript:void(0)">消息(<span id='mm6'>0</span>)<strong class="caret"></strong></a>
									<ul class="dropdown-menu">
										<!-- 
										<li>
											<a href="#">新订单(<span id='mm1'>0</span>)</a>
										</li>
										 -->
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src','<%=path %>/crm/chanceAction_findnewchance.action?meid='+newchance2+'&newchanceid='+newchanceid)">新销售机会(<span id='mm2'>0</span>)</a>
										</li>
										<li>
											<a href="javascript:document.getElementById('if1').setAttribute('src','<%=path %>/crm/missionAction_findnewmission.action?meid='+newmission2+'&newmissionid='+newmissionid)">新营销任务(<span id='mm3'>0</span>)</a>
										</li>
										<li>
											<a href="#">待处理客服服务(<span id='mm4'>0</span>)</a>
										</li>
										<li>
											<a href="#">新回复(<span id='mm5'>0</span>)</a>
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
	
	<div class="row-fluid" style="margin-top:42px;">
		<div class="span12">
			<div class="row-fluid">
				<div class="span2">
				
				<!-- 左侧导航条 -->
				<div class="leftsidebar_box" id="daohang">
		<div class="line"></div>
		<dl class="channel">
			<dt onClick="">销售管理<img src="images/left/select_xl01.png"></dt>
			<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/orderAction_findAllOrder.action');">销售订单</a></dd>
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
			<!-- <dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/serviceAction_sfindAllservice.action');">产品问答</a></dd>
			<dd><a href="#">客户满意度</a></dd> -->
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
			<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer4.action');">已流失客户</a></dd>
		</dl>
		
		<dl class="custom">
			<dt onClick="">客户类型<img src="images/left/select_xl01.png"></dt>
			<dd class="first_dd"><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer5.action');">普通会员</a></dd>
			<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer6.action');">VIP1</a></dd>
			<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer7.action');">VIP2</a></dd>
			<dd><a href="javascript:document.getElementById('if1').setAttribute('src', '<%=path %>/crm/customerPAction_findcustomer8.action');">VIP3</a></dd>
		</dl>
		
	</div>
		</div>
		<!-- //左侧导航条 -->
		
				<div class="span10">
				<iframe id="if1" width="100%" height="800" scrolling="auto" marginheight="0" frameBorder=0 name="ifrmtest" src=""></iframe>
				</div>
			</div>
			
			<!--<div class="row-fluid"><div class="span12">页脚 </div></div>-->
		</div>
	</div>
</div>
  </body>
</html>
