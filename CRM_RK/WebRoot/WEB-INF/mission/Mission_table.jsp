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
		<s:form id="f1" action="missionAction_deleteSomeMission" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">营销任务列表</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li id="deletesome" onclick="confirm_delete()"><a href="javascript:void(0)">批量删除</a></li>
           		  <li id="addnewmission"><a href="javascript:void(0)">新增任务</a></li>
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
				search: true,
				clickToSelect: true,
				columns: [{field:"title",title:"任务主题",align:"left",valign:"middle",sortable:"true"},
				          {field:"level",title:"优先级",align:"center",valign:"middle",sortable:"true"},
				          {field:"channel",title:"负责渠道",align:"center",valign:"middle",sortable:"true"},
				          {field:"status",title:"任务状态",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出任务数据  start-->
	<s:iterator value="missions" id="m1">
		<script>
		init.dates[ii] = {
				'title' : '<input type="checkbox" onchange="confirm_checked(this)" id="mid" name="mid" value="<s:property value="#m1.id"/>"/>&nbsp;'+
							'<a href="<%=path %>/crm/missionAction_findThemission.action?mission.id=<s:property value='#m1.id'/>"><s:property value="#m1.title"/></a>',
				'level' : '<s:property value="#m1.level"/>',
				'channel' : '<s:property value="#m1.channel.cname"/>',
				'status' : '<s:property value="#m1.ststus"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出任务数据  end-->
	
	<!-- 添加界面 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addmissionform" action="missionAction_addMission" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>任务信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="5">
						<tr>
						<td width="40%" align="right">*主题:</td>
						<td width="60%"><input type="text" style="width:200px;height:30px;" id="title1" name="mission.title"/></td>
						</tr>
						<tr>
						<td align="right">*负责渠道:</td>
						<td><select style="width:200px;height:30px;" id="cname" name="channel.cname">
							<option value="">--请选择--</option>
							<s:iterator value="channels" id="cls">
							<option value='<s:property value="#cls.cname"/>'><s:property value="#cls.cname"/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">任务等级:</td>
						<td><select style="width:200px;height:30px;" name="mission.level">
							<option value="">--请选择--</option>
							<option value="最高">最高</option>
							<option value="高">高</option>
							<option value="中">中</option>
							<option value="低">低</option>
							<option value="最低">最低</option>
  						</select></td>
						</tr>
						<tr>
						<td align='right'>开始时间</td>
						<td><input type='date' style='width:200px;height:30px;' name='mission.startDate'/></td>
						</tr>
						<tr>
						<td align='right'>结束时间</td>
						<td><input type='date' style='width:200px;height:30px;' name='mission.endDate'/></td>
						</tr>
						<tr id="tr1">
						<td align="right">*任务类型:</td>
						<td><select style="width:200px;height:30px;" id="sel1" name="mission.type">
							<option value="">--请选择--</option>
							<option value="单次任务">单次任务</option>
							<option value="重复任务">重复任务</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*任务内容</td>
						<td><textarea id="context" name="mission.context" style="width:300px;height:100px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="addmissionb" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加界面 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//如果用户等级为3,channel不能改
	if("${applicationScope.level}"==3){
		$('#cname').val("${applicationScope.user.channel.cname}");
		$('#cname').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
	}
	//如果用户等级为2,不能新建和删除任务
	if("${applicationScope.level}"==2){
		$('#deletesome').remove();
		$('#addnewmission').remove();
	}
	
	//动态加载任务类型
	$('#sel1').change(function(){
		var type=$('#sel1').val();
		if(type==""){
			$('#tr2').remove();
			$('#tr3').remove();
			$('#tr4').remove();
		}
		if(type=="单次任务"){
			$('#tr2').remove();
			$('#tr3').remove();
			$('#tr4').remove();
		}
		if(type=="重复任务"){
			$('#tr1').after(
					"<tr id='tr2'><td align='right'>重复方式</td><td><select style='width:200px;height:30px;' id='sel2' name='mission.repeatType'>"+
					"<option value=''>--请选择--</option><option value='每周'>每周</option><option value='每月'>每月</option></select></td></tr>"
			);
		}
	});
	
	//sel2改变时，级联出月选择或是周选择
	$(document).on("change", "#sel2", function(){ 
		var type=$('#sel2').val();
		if(type==""){
			$('#tr3').remove();
			$('#tr4').remove();
		}
		if(type=="每周"){
			$('#tr4').remove();
			$('#tr2').after(
				"<tr id='tr3'><td colspan='2' align='center'><input type='checkbox' name='mission.repeatTime' value='星期一'/>星期一"+
				"<input type='checkbox' name='mission.repeatTime' value='星期二'/>星期二"+
				"<input type='checkbox' name='mission.repeatTime' value='星期三'/>星期三"+
				"<input type='checkbox' name='mission.repeatTime' value='星期四'/>星期四"+
				"<input type='checkbox' name='mission.repeatTime' value='星期五'/>星期五"+
				"<input type='checkbox' name='mission.repeatTime' value='星期六'/>星期六"+
				"<input type='checkbox' name='mission.repeatTime' value='星期日'/>星期日</td></tr>"
			);
		}
		if(type=="每月"){
			$('#tr3').remove();
			$('#tr2').after(
					"<tr id='tr4'><td colspan='2' align='center'><input type='checkbox' name='mission.repeatTime' value='一月'/>一月"+
					"<input type='checkbox' name='mission.repeatTime' value='二月'/>二月"+
					"<input type='checkbox' name='mission.repeatTime' value='三月'/>三月"+
					"<input type='checkbox' name='mission.repeatTime' value='四月'/>四月"+
					"<input type='checkbox' name='mission.repeatTime' value='五月'/>五月"+
					"<input type='checkbox' name='mission.repeatTime' value='六月'/>六月"+
					"<input type='checkbox' name='mission.repeatTime' value='七月'/>七月"+
					"<input type='checkbox' name='mission.repeatTime' value='八月'/>八月"+
					"<input type='checkbox' name='mission.repeatTime' value='九月'/>九月"+
					"<input type='checkbox' name='mission.repeatTime' value='十月'/>十月"+
					"<input type='checkbox' name='mission.repeatTime' value='十一月'/>十一月"+
					"<input type='checkbox' name='mission.repeatTime' value='十二月'/>十二月</td></tr>"
			);
		}
	}); 
	
	//弹出层事件start
    $('#addnewmission').click(function() {
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
