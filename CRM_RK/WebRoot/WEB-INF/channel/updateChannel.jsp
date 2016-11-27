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
	<script src="<%=path%>/js/PCASClass.js"></script>
	<script src="<%=path%>/js/TableValidate.js"></script>
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		//确认是否删除
		function confirm_delete(){
			if (!confirm("确认删除该渠道？")) {
		         window.event.returnValue = false;
		    }
			else{
				var idid=$('#cid').text();
				window.location.href="<%=path %>/crm/channelAction_deleteTheChannel.action?channel.id="+idid;
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
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">渠道商详细信息</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/channelAction_findAllchannel.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="updatechannel"><a href="javascript:void(0)">编辑</a></li>
           		  <li onclick=""><a href="javascript:void(0)">销量统计</a></li>
        		</ul>
    		</div>
		</div>
		<!-- 数据表格  start -->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">渠道业绩</td>
					</tr>
					<tr>
						<td align="right" width="25%">成交次数:</td><td width="25%">&nbsp;</td>
						<td align="right" width="25%">成交数量:</td><td width="25%">&nbsp;0</td>
					</tr>
					<tr>
						<td align="right">成交总额:</td><td>&nbsp;0</td>
						<td align="right">成交成本总额:</td><td>&nbsp;0</td>
					</tr>
					<tr>
						<td align="right">总利润:</td><td>&nbsp;0</td>
						<td align="right">当前意向客户:</td><td>&nbsp;0</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">渠道信息</td>
					</tr>
					<tr>
						<td align="right">渠道编号:&nbsp;</td><td id="cid">${channel.id}</td>
						<td align="right">渠道名称:&nbsp;</td><td>${channel.cname}</td>
					</tr>
					<tr>
						<td align="right">省份:&nbsp;</td><td id="t1">${channel.province}</td>
						<td align="right">城市:&nbsp;</td><td id="t2">${channel.city}</td>
					</tr>
					<tr>
						<td align="right">渠道等级:&nbsp;</td><td id="t3">${channel.level}</td>
						<td align="right">录入时间:&nbsp;</td><td>
							<input type="text" readonly="readonly" value='<s:date format="yyyy-MM-dd" name="channel.enjoyDate"/>' /> 
						</td>
					</tr>
					<tr>
						<td align="right">邮编:&nbsp;</td><td>${channel.postcode}</td>
						<td align="right">公司地址:&nbsp;</td><td>${channel.address}</td>
					</tr>
					<tr>
						<td align="right">公司主页:&nbsp;</td><td id="ppicture">${channel.website}</td>
						<td align="right"></td><td></td>
					</tr>
				</table>
			</div>
			<!-- 数据表格  end -->
		</div>
	</div>
	
	<!--弹出窗口、 修改商品界面 start -->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatechannelform" action="channelAction_updateChannel" method="post" namespace="/crm">
 			<input type="hidden" id="channelid" name="channel.id" value="${channel.id}"/>
 			<input type="hidden" name="channel.enjoyDate" value="${channel.enjoyDate}" />
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>渠道信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">*渠道名称:</td>
						<td width="60%"><input type="text" id="cname" style="width:185px;height:30px;" value='${channel.cname}' name="channel.cname"/></td>
						</tr>
						<tr>
						<td align="right">*邮编:</td>
						<td><input type="text" style="width:185px;height:30px;" id="postcode" value='${channel.postcode}' name="channel.postcode"/></td>
						</tr>
						<tr>
						<td align="right">*省份/城市:</td>
						<td>
						<select style="width:185px;height:30px;" id="prov" name="channel.province"></select>
						<select id="citys" style="width:185px;height:30px;" id="city" name="channel.city"></select>
  						</td>
						</tr>
						<tr>
						<td align="right">*渠道等级</td>
						<td>
						<select id="level" style="width:185px;height:30px;" name="channel.level">
							<option value="">--请选择渠道等级--</option>
							<option value="省级代理">省级代理</option>
							<option value="市级代理">市级代理</option>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">公司主页</td>
						<td><input type="text" style="width:185px;height:30px;" id="website" value='${channel.website}' name="channel.website"/></td>
						</tr>
						<tr>
						<td align="right">公司地址</td>
						<td><input type="text" style="width:185px;height:30px;" id="address" value='${channel.address}' name="channel.address"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="updatechannelb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改商品界面 end -->
	
<script>
new PCAS("channel.province","channel.city");//"选择城市"赋值
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件 start
    $('#updatechannel').click(function() {
    	$('#prov').val($('#t1').text());
    	$('#city').val($('#t2').text());
    	$('#level').val($('#t3').text());
    	
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
