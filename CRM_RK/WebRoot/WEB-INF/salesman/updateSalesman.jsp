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
				$.ajax({
					type: "POST",
					url: "crm/salesmanAction_ifcandeleteone.action",
					data: {deleteid:$('#sid').text()},
					dataType: 'text',
					success: function(result) {
						if (result=="1") {
							alert("该销售员存在关联数据，请删相关订单、销售机会、任务和服务记录后，再进行此操作");
							return 
						}else{
							var idid=$('#sid').text();
							window.location.href="<%=path %>/crm/salesmanAction_deleteTheSalesman.action?salesman.id="+idid;
							alert("删除成功");
						}
					}
				});
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
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">销售员详细信息</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/salesmanAction_findAllsalesman.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="updatesalesman"><a href="javascript:void(0)">编辑</a></li>
           		  <!--  <li onclick=""><a href="javascript:void(0)">销售业绩</a></li> -->
        		</ul>
    		</div>
		</div>
			<!-- 表格div start -->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">业绩详情</td>
					</tr>
					<tr>
						<td align="right" width="25%">成交次数:</td><td width="25%">&nbsp;0</td>
						<td align="right" width="25%">成交数量:</td><td width="25%">&nbsp;0</td>
					</tr>
					<tr>
						<td align="right">成交总额:</td><td>&nbsp;0</td>
						<td align="right">成交成本总额:</td><td>&nbsp;0</td>
					</tr>
					<tr>
						<td align="right">总利润:</td><td>&nbsp;0</td>
						<td align="right">当前负责客户:</td><td>&nbsp;0</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">销售员信息</td>
					</tr>
					<tr>
						<td align="right">姓名:&nbsp;</td><td>${salesman.sname}</td>
						<td align="right">编号:&nbsp;</td><td id="sid">${salesman.id}</td>
					</tr>
					<tr>
						<td align="right">生日:&nbsp;</td><td id="birth">${salesman.birth}</td>
						<td align="right">性别:&nbsp;</td><td id="sex">${salesman.sex}</td>
					</tr>
					<tr>
						<td align="right">电子邮件:&nbsp;</td><td>${salesman.email}</td>
						<td align="right">联系方式:&nbsp;</td><td>${salesman.phone}</td>
					</tr>
					<tr>
						<td align="right">所属渠道:&nbsp;</td><td id="channel">${salesman.channel.cname}</td>
						<td align="right">地址:&nbsp;</td><td>${salesman.address}</td>
					</tr>
				</table>
			</div>
			<!-- 表格div end -->
		</div>
	</div>
	
	<!--弹出窗口、 修改商品界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatesalesmanform" action="salesmanAction_updateSalesman" method="post" namespace="/crm">
 			<input type="hidden" id="salesmanid" value="${salesman.id}" name="salesman.id"/>
 			<input type="hidden" id="upid" value="${salesman.userPower.id}" name="userPower.id"/>
 			<input type="hidden" value="${salesman.userPower.level}" id="idtype"/>
    		<div id="tabs" style="margin-bottom: 0px;" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>个人信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="10">
						<tr>
						<td width="40%" align="right">*姓名:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" value="${salesman.sname}" id="cname" name="salesman.sname"/></td>
						</tr>
						<tr>
						<td align="right">性别:</td>
						<td><select style="width:185px;height:30px;" id="ssex" name="salesman.sex">
							<option value=""></option>
							<option value="男">男</option>
							<option value="女">女</option>
						</select></td>
						</tr>
						<tr>
						<td align="right">*所属渠道:</td>
						<td><select style="width:185px;height:30px;" id="schannel" name="channel.cname">
							<option value=""></option>
							<s:iterator value="channels" id="c1">
							<option value='<s:property value="#c1.cname"/>'><s:property value="#c1.cname"/></option>
							</s:iterator>
						</select></td>
						</tr>
						<tr>
						<td align="right">是否为渠道管理员:</td>
						<td><label><INPUT type="radio" id="rd1" name="idtype" value="是" >是</label>&nbsp;&nbsp;
						<label><INPUT type="radio" id="rd2" name="idtype" value="否">否</label></td>
						</tr>
						<tr>
						<td align="right">生日:</td>
						<td><input type="date" style="width:185px;height:30px;" id="bdate" value="${salesman.birth}" name="salesman.birth"/></td>
						</tr>
						<tr>
						<td align="right">联系方式</td>
						<td><input type="text" style="width:185px;height:30px;" value="${salesman.phone}" name="salesman.phone"/></td>
						</tr>
						<tr>
						<td align="right">*电子邮件</td>
						<td><input type="text" style="width:185px;height:30px;" id="email" value="${salesman.email}" name="salesman.email"/></td>
						</tr>
						<tr>
						<td align="right">家庭住址</td>
						<td><input type="text" style="width:185px;height:30px;" value="${salesman.address}" name="salesman.address"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容,电子邮箱将作为登录的用户名</h4>
			<input id="updatesalesmanb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改商品界面  end-->
	
	<!-- 查看图片start -->
	<div id="goodcover2"></div>
	<div id="code2">
		<div class="close1"><a href="javascript:void(0)" id="closebt2"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<img id="img" width="80%" height="80%" src=""/>
		</div>
	</div>
	<!-- 查看图片end -->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件start
    $('#updatesalesman').click(function() {
    	if($('#idtype').val()==3){
    		$('#rd1').attr("checked","checked");
    	}else{
    		$('#rd2').attr("checked","checked");
    	}
    	$('#schannel').val($('#channel').text());
    	$('#ssex').val($('#sex').text());
    	
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
	//弹出层事件start
});
</script>
	
  </body>
</html>
