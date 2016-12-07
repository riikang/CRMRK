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
	        			deleteid=deleteid+rows[i].sid;
	        		}else{
	        			deleteid=deleteid+rows[i].sid+", ";
	        		}
	        	}
	        	$.ajax({
					type: "POST",
					url: "crm/salesmanAction_ifcandelete.action",
					data: {deleteid:deleteid},
					dataType: 'text',
					success: function(result) {
						if (result=="1") {
							alert("所选销售员存在关联数据，请删相关订单、销售机会、任务和服务记录后，再进行此操作");
							return 
						}else{
							window.location.href='<%=path %>/crm/salesmanAction_deleteSomeSalesman.action?sid='+deleteid;
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
		<s:form id="f1" action="salesmanAction_deleteSomeSalesman" namespace="/crm">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">销售员列表</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="addnewchannel"><a href="javascript:void(0)">新增</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 表格div  -->
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
				exportTypes: ['excel'],
				search: true,
				clickToSelect: true,
				columns: [{field:"checkbox",checkbox: true,align:"center",valign:"middle"},
						  {field:"sid",title:"编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"sname",title:"姓名",align:"center",valign:"middle",sortable:"true"},
				          {field:"sex",title:"性别",align:"center",valign:"middle",sortable:"true"},
				          {field:"birth",title:"生日",align:"center",valign:"middle",sortable:"true"},
				          {field:"phone",title:"联系方式",align:"center",valign:"middle",sortable:"true"},
				          {field:"email",title:"邮件地址",align:"center",valign:"middle",sortable:"true"},
				          {field:"address",title:"住址",align:"center",valign:"middle",sortable:"true"},
				          {field:"channel",title:"所属渠道",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出销售员数据  start-->
	<s:iterator value="salesmans" id="s1">
		<script>
		init.dates[ii] = {
				//<input type="checkbox" onchange="confirm_checked(this)" id="sid" name="sid" value="<s:property value="#s1.id"/>"/>&nbsp;
				'sid' : '<s:property value="#s1.id"/>',
				'sname' : '<a href="<%=path %>/crm/salesmanAction_findTheSalesman.action?salesman.id=<s:property value='#s1.id'/>"><s:property value="#s1.sname"/></a>',
				'sex' : '<s:property value="#s1.sex"/>',
				'birth':'<s:property value="#s1.birth"/>',
				'phone' : '<s:property value="#s1.phone"/>',
				'email':'<s:property value="#s1.email"/>',
				'address':'<s:property value="#s1.address"/>',
				'channel':'<s:property value="#s1.channel.cname"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出销售员数据  end-->
	
	<!-- 添加渠道界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addsalesmanform" action="salesmanAction_addSalesman" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>个人信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="8">
						<tr>
						<td width="40%" align="right">*姓名:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="cname" name="salesman.sname"/></td>
						</tr>
						<tr>
						<td align="right">性别:</td>
						<td><select style="width:185px;height:30px;" name="salesman.sex">
							<option value=""></option>
							<option value="男">男</option>
							<option value="女">女</option>
						</select></td>
						</tr>
						<tr>
						<td align="right">*所属渠道:</td>
						<td><select style="width:185px;height:30px;" id="channels" name="channel.cname">
							<option value=""></option>
							<s:iterator value="channels" id="c1">
							<option value='<s:property value="#c1.cname"/>'><s:property value="#c1.cname"/></option>
							</s:iterator>
						</select></td>
						</tr>
						<tr>
						<td align="right">是否为渠道管理员:</td>
						<td><label><INPUT type="radio" name="idtype" value="是" >是</label>&nbsp;&nbsp;
						<label><INPUT type="radio" name="idtype" value="否" checked="checked">否</label></td>
						</tr>
						<tr>
						<td align="right">生日:</td>
						<td><input type="date" style="width:185px;height:30px;" id="birth" name="salesman.birth"/></td>
						</tr>
						<tr>
						<td align="right">联系方式</td>
						<td><input type="text" style="width:185px;height:30px;" id="phone" name="salesman.phone"/></td>
						</tr>
						<tr>
						<td align="right">*电子邮件</td>
						<td><input type="text" style="width:185px;height:30px;" id="email" name="salesman.email"/></td>
						</tr>
						<tr>
						<td align="right">家庭住址</td>
						<td><input type="text" style="width:185px;height:30px;" id="address" name="salesman.address"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容,电子邮箱将作为登录的用户名</h4>
			<input id="addsalesmanb" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加渠道界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件start
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
	//弹出层事件end
});
</script>
  </body>
</html>
