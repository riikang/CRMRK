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
	//删除
	function confirm_delete(){
		var rows=$('#reportTable').bootstrapTable('getSelections');
		if(rows.length==0){
			alert('请选择需要删除的数据（多选）');
			return;
		}
		if(rows.length>=1){
			if(!confirm("确认删除？")){
	           	 window.event.returnValue = false;
	        }else{
	        	var deleteid="";
	        	for(var i=0;i<rows.length;i++){
	        		if(i==rows.length-1){
	        			deleteid=deleteid+rows[i].cid;
	        		}else{
	        			deleteid=deleteid+rows[i].cid+", ";
	        		}
	        	}
	        	$.ajax({
					type: "POST",
					url: "crm/channelAction_ifcandelete.action",
					data: {deleteid:deleteid},
					dataType: 'text',
					success: function(result) {
						if (result=="1") {
							alert("所选渠道商存在关联数据，请删相关任务、销售机会、销售员、订单和服务记录后，再进行此操作");
							return 
						}else{
							window.location.href='<%=path %>/crm/channelAction_deleteSomeChannel.action?cid='+deleteid;
							alert("删除成功");
						}
					}
				});
			}	
		}
	}
		
		$(document).ready(function() {
    		$('.full-width').horizontalNav({});//表格自适应
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="channelAction_deleteSomeChannel" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">渠道商列表</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="addnewchannel"><a href="javascript:void(0)">新增</a></li>
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
				pageSize: 14,
				pageNumber:1,
				pageList: [10, 20, 50, 100, 200, 500],
				search: true,
				showColumns: true,
				showRefresh: true,
				showExport: true,
				exportTypes: ['excel'],
				search: true,
				clickToSelect: true,
				columns: [{field:"checkbox",checkbox: true,align:"center",valign:"middle"},
						  {field:"cid",title:"渠道编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"cname",title:"渠道名称",align:"center",valign:"middle",sortable:"true"},
				          {field:"postcode",title:"邮政编码",align:"center",valign:"middle",sortable:"true"},
				          {field:"province",title:"省份",align:"center",valign:"middle",sortable:"true"},
				          {field:"city",title:"城市",align:"center",valign:"middle",sortable:"true"},
				          {field:"website",title:"公司主页",align:"center",valign:"middle",sortable:"true"},
				          {field:"address",title:"公司地址",align:"center",valign:"middle",sortable:"true"},
				          {field:"edate",title:"加入时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"level",title:"渠道等级",align:"center",valign:"middle",sortable:"true"}
				          ],
				data : init.dates,
				onPageChange: function (size, number) {
					//$("#pageSizeInput").val(size);
					//$("#pageNumberInput").val(number);
					//var form = $('#tableForm');
					//form.action= '${base}/showReport';
					//form.submit();
                },
				//onSort: function (name, order) {
               // },
				//formatShowingRows: function (pageFrom, pageTo, totalRows) {
				//	return '';
               // },
				//formatRecordsPerPage: function () {
				//	return '';
              //  },
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
	<s:iterator value="channels" id="c1">
		<script>
		init.dates[ii] = {
				//<input type="checkbox" onchange="confirm_checked(this)" id="cid" name="cid" value="<s:property value="#c1.id"/>"/>&nbsp;
				'cid' : '<s:property value="#c1.id"/>',
				'cname' : '<a href="<%=path %>/crm/channelAction_findTheChannel.action?channel.id=<s:property value='#c1.id'/>"><s:property value="#c1.cname"/></a>',
				'postcode' : '<s:property value="#c1.postcode"/>',
				'province':'<s:property value="#c1.province"/>',
				'city' : '<s:property value="#c1.city"/>',
				'website':'<s:property value="#c1.website"/>',
				'address':'<s:property value="#c1.address"/>',
				'level':'<s:property value="#c1.level"/>',
				'edate':'<s:property value="#c1.enjoyDate"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出数据  end-->
	
	<!-- 添加渠道界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addchannelform" action="channelAction_addChannel" method="post" namespace="/crm">
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
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="cname" name="channel.cname"/></td>
						</tr>
						<tr>
						<td align="right">*邮编:</td>
						<td><input type="text" style="width:185px;height:30px;" id="postcode" name="channel.postcode"/></td>
						</tr>
						<tr>
						<td align="right">*省份/城市:</td>
						<td>
						<select style="width:185px;height:30px;" name="channel.province"></select>
						<select id="citys" style="width:185px;height:30px;" name="channel.city"></select>
  						</td>
						</tr>
						<tr>
						<td align="right">*渠道等级</td>
						<td>
						<select style="width:185px;height:30px;" id="levels" name="channel.level">
							<option value="">--请选择渠道等级--</option>
							<option value="省级代理">省级代理</option>
							<option value="市级代理">市级代理</option>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">公司主页</td>
						<td><input type="text" style="width:185px;height:30px;" id="website" name="channel.website"/></td>
						</tr>
						<tr>
						<td align="right">公司地址</td>
						<td><input type="text" style="width:185px;height:30px;" id="address" name="channel.address"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="addchannelb" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加渠道界面  end-->
	
<script>
new PCAS("channel.province","channel.city");//"选择城市"赋值
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件 start
    $('#addnewchannel').click(function() {
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
