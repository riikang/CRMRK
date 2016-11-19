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
	<link rel="stylesheet" href="css/bootstrap.css" />
	<link rel="stylesheet" href="css/bootstrap-table.css" />
	<link rel="stylesheet" href="css/horizontalNav.css" />
	<link rel="stylesheet" href="css/addProductMain.css" />
	<link rel="stylesheet" href="css/tabsDemo.css" />
	<link rel="stylesheet" href="css/tabsComponent.css" />
	
	<script src="js/jquery-3.0.0.min.js"></script>
	<script src="js/bootstrap.min.js"></script>	
	<script src="js/bootstrap-table.js"></script>
	<script src="js/bootstrap-table-export.js"></script>
	<script src="js/jquery.base64.js"></script>
	<script src="js/tableExport.js"></script>
	<script src="js/jquery.horizontalNav.js"></script>
	<script src="js/cbpFWTabs.js"></script>
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		//确认是否删除
		function confirm_delete(){
			if (!confirm("确认删除？")) {
		        window.event.returnValue = false;
		    }
			else{
				var idid=$('#fid').text();
				window.location.href="<%=path %>/crm/followupAction_deleteTheFollowup.action?followup.id="+idid;
				alert("删除成功");
			}				
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
           		  <li><a href="<%=path %>/crm/followupAction_findAllFollowup.action">返回跟进记录列表</a></li>
           		  <li><a href="<%=path %>/crm/chanceAction_goBackTheChance.action">返回销售机会</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="update"><a href="javascript:void(0)">编辑</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 数据表格  start-->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">跟踪记录信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">记录编号:&nbsp;</td><td id="fid" width="25%">${followup.id}</td>
						<td align="right" width="25%">联系时间:&nbsp;</td><td width="25%">${followup.connectTime}</td>
					</tr>
					<tr>
						<td align="right">关联销售机会:&nbsp;</td><td>${followup.chance.id}</td>
						<td align="right">联系方式:&nbsp;</td><td id="t1">${followup.connectType}</td>
					</tr>
					<tr>
						<td align="right">跟踪阶段:&nbsp;</td><td id="t2">${followup.followstage}</td>
						<td align="right">跟踪后销售机会阶段:&nbsp;</td><td id="t3">${followup.stage}</td>
					</tr>
					<tr>
						<td align="right">计划内容:&nbsp;</td><td>${followup.project}</td>
						<td align="right">结果:&nbsp;</td><td>${followup.result}</td>
					</tr>
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
 		<s:form theme="simple" action="followupAction_updateFollowup" method="post" namespace="/crm">
 			<input type="hidden" name="followup.id" value="${followup.id}"/>
 			<input type="hidden" name="followup.chance.id" value="${followup.chance.id}"/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>跟进记录</span></a></li>
						<li><a href="#section-2" ><span>跟进结果</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="40%" align="right">联系时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" value="${followup.connectTime}" name="followup.connectTime"/></td>
						</tr>
						<tr>
						<td align="right">联系方式:</td>
						<td><select style="width:185px;height:30px;" id="sel1" name="followup.connectType">
							<option value="">--请选择--</option>
							<option value="电话">电话</option>
							<option value="传真">传真</option>
							<option value="邮件">邮件</option>
							<option value="短信">短信</option>
							<option value="通讯软件">通讯软件</option>
							<option value="上门拜访">上门拜访</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">计划内容:</td>
						<td><input type="text" style="width:250px;height:30px;" value="${followup.project}" name="followup.project"/></td>
						</tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="40%" align="right">跟踪阶段:</td>
						<td width="60%"><select style="width:185px;height:30px;" id="sel2" name="followup.followstage">
							<option value="跟踪中">跟踪中</option>
							<option value="跟踪完成">跟踪完成</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">跟踪后销售机会阶段:</td>
						<td><select style="width:185px;height:30px;" id="sel3" name="followup.stage">
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
						<td align="right">结果:</td>
						<td><input type="text" style="width:250px;height:30px;" value="${followup.result}" name="followup.result"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件 start
    $('#update').click(function() {
    	$('#sel1').val($('#t1').text());
    	$('#sel2').val($('#t2').text());
    	$('#sel3').val($('#t3').text());
    	
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
