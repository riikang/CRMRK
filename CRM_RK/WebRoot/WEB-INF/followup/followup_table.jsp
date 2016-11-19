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
	<script src="<%=path%>/js/myjq.js"></script>
	
	<script>
		//判断所选行是否为空，以及确认是否删除 start
	    var flag=0;
		function confirm_delete(){
			if(flag>0){
				if (!confirm("确认删除？")) {
		           	 window.event.returnValue = false;
		       		 }
					else{
						var f1=document.getElementById("f1");
						f1.submit();
						alert("删除成功");
					}	
			}else{
				alert("未选中任何行");
			}				
		}
		function confirm_checked(obj){
			if(obj.checked==true){
				flag++;
			}else{
				flag--;
			}
		}
		//判断所选行是否为空，以及确认是否删除 end
		
		$(document).ready(function() {
    		$('.full-width').horizontalNav({});//表格自适应
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="followupAction_deleteSomefollowup" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a>销售机会跟进记录</a></li>
           		  <li><a href="<%=path %>/crm/chanceAction_goBackTheChance.action">返回销售机会</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">批量删除</a></li>
           		  <li id="addnew"><a href="javascript:void(0)">新增跟进记录</a></li>
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
				pageSize: 20,
				pageNumber:1,
				pageList: [10, 20, 50, 100, 200, 500],
				search: true,
				showColumns: true,
				showRefresh: true,
				showExport: true,
				exportTypes: ['csv','txt','xml'],
				search: true,
				clickToSelect: true,
				columns: [{field:"id",title:"编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"time",title:"联系时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"project",title:"计划内容",align:"center",valign:"middle",sortable:"true"},
				          {field:"result",title:"跟进结果",align:"center",valign:"middle",sortable:"true"}
				          ],
				data : init.dates,
				onPageChange: function (size, number) {
                },
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
	
	<!-- 迭代读出数据 start-->
	<s:iterator value="followups" id="f1">
		<script>
		init.dates[ii] = {
				'id' : '<input type="checkbox" onchange="confirm_checked(this)" id="fid" name="fid" value="<s:property value="#f1.id"/>"/>&nbsp;'+
							'<a href="<%=path %>/crm/followupAction_findThefollowup.action?followup.id=<s:property value='#f1.id'/>"><s:property value="#f1.id"/></a>',
				'time' : '<s:property value="#f1.connectTime"/>',
				'project':'<a href="<%=path %>/crm/followupAction_findThefollowup.action?followup.id=<s:property value='#f1.id'/>">'+
								'<s:property value="#f1.project"/></a>',
				'result' : '<s:property value="#f1.result"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出数据 end-->
	
	<!-- 添加界面 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" action="followupAction_addfollowup" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>跟进记录</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="40%" align="right">联系时间:</td>
						<td width="60%"><input type="date" style="width:185px;height:30px;" name="followup.connectTime"/></td>
						</tr>
						<tr>
						<td align="right">联系方式:</td>
						<td><select style="width:185px;height:30px;" name="followup.connectType">
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
						<td><input type="text" style="width:230px;height:30px;" name="followup.project"/></td>
						</tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<input type="submit" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加界面 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件 start
    $('#addnew').click(function() {
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
