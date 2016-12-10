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
	<link rel="stylesheet" href="<%=path%>/UEditor/themes/default/css/ueditor.css">
	<script src="<%=path%>/UEditor/ueditor.config.js"></script>
	<script src="<%=path%>/UEditor/ueditor.all.js"></script>
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
		//确认是否选中客户，并发送邮件 start
		var flag=false;
		function confirm_send(){
			if(flag){
				if (!confirm("确认发送？")) {
		           	 window.event.returnValue = false;
		       		 }
					else{
						var f1=document.getElementById("f1");
						f1.submit();
						alert("发送成功");
					}	
			}else{
				alert("未选中任何客户");
			}				
		}
		function confirm_checked(){
			flag=true;
		}
		//确认是否选中客户，并发送邮件 end
		
		$(document).ready(function() {
    		$('.full-width').horizontalNav({});//表格自适应
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<s:form id="f1" action="emailMessageAction_sendSomeEmail" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">客户关怀</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_send()"><a href="javascript:void(0);">发送祝福</a></li>
           		  <li id="edit"><a href="javascript:void(0)">编辑内容</a></li>
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
				exportTypes: ['csv','txt','xml'],
				search: true,
				clickToSelect: true,
				columns: [{field:"id",title:"客户编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"name",title:"客户姓名",align:"center",valign:"middle",sortable:"true"},
				          {field:"birthday",title:"生日",align:"center",valign:"middle",sortable:"true"},
				          {field:"email",title:"电子邮箱",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出客户数据  start-->
	<s:iterator value="customerPs" id="cps">
		<script>
		init.dates[ii] = {
				'id' : '<input type="checkbox" onchange="confirm_checked()" id="ccid" name="ccid" value="<s:property value="#cps.id"/>"/>&nbsp;<s:property value="#cps.id"/>',
				'name' : '<s:property value="#cps.cname"/>',
				'birthday' : '<s:property value="#cps.birth"/>',
				'email' : '<s:property value="#cps.email"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出客户数据  end-->
	
	<!-- 编辑界面  start-->
	<s:hidden id="h2" value="%{emailMessage.context}"/>
 	<input type="hidden" id="h3" value="${emailMessage.type}" />
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatemessageform" action="emailMessageAction_updateMessage" method="post" namespace="/crm">
 			<input type="hidden" id="h1" name="emailMessage.id" value="${emailMessage.id}"/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>编辑内容</span></a></li>
						<li><a href="#section-2" ><span>编辑其它</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<textarea name="emailMessage.context" id="myEditor" style="width:100%;height:500px;max-height:500px;overflow-y:scroll;resize:none;"></textarea>
						<script type="text/javascript">
							var text1=$('#h2').val();
							UE.getEditor('myEditor',{
								 initialContent:text1
								,autoClearinitialContent:false
								,focus:false
							});
						</script>	
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="20%" align="right">主题:</td>
						<td width="80%"><input type="text" value="${emailMessage.title}" style="width:450px;height:35px;" id="title" name="emailMessage.title"/></td>
						</tr>
						<tr>
						<td align="right">类型:</td>
						<td>
						<select style="width:185px;height:30px;" id="sel1" name="emailMessage.type">
							<option value="">--请选择--</option>
							<option value="生日">生日</option>
							<option value="国庆">国庆</option>
							<option value="春节">春节</option>
							<option value="中秋">中秋</option>
							<option value="端午">端午</option>
  						</select>
  						</td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
						<input id="updatemessageb" type="button" value="保存信息"/>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			</s:form>
  		</div>
	</div>
	<!-- 编辑界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	$('#sel1').val($('#h3').val());
	//弹出层事件 start
    $('#edit').click(function() {
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
