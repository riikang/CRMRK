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
		<s:form id="f1" action="customerPAction_deleteSomecustomerp" namespace="/crm">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">所有客户列表</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">批量删除</a></li>
           		  <li id="addnewchannel"><a href="javascript:void(0)">新增客户</a></li>
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
				columns: [{field:"id",title:"客户编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"gtime",title:"获取时间",align:"center",valign:"middle",sortable:"true"},
				          {field:"name",title:"姓名",align:"center",valign:"middle",sortable:"true"},
				          {field:"prov",title:"所在省份",align:"center",valign:"middle",sortable:"true"},
				          {field:"city",title:"所在城市",align:"center",valign:"middle",sortable:"true"},
				          {field:"conn",title:"联系方式",align:"center",valign:"middle",sortable:"true"},
				          {field:"email",title:"电子邮件",align:"center",valign:"middle",sortable:"true"},
				          {field:"type",title:"客户类型",align:"center",valign:"middle",sortable:"true"},
				          {field:"status",title:"客户状态",align:"center",valign:"middle",sortable:"true"},
				          {field:"sex",title:"性别",align:"center",valign:"middle",sortable:"true"},
				          {field:"birth",title:"生日",align:"center",valign:"middle",sortable:"true"},
				          {field:"company",title:"工作公司",align:"center",valign:"middle",sortable:"true"},
				          {field:"ctype",title:"公司行业",align:"center",valign:"middle",sortable:"true"}
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
	
	<!-- 迭代读出客户数据  start-->
	<s:iterator value="customerPs" id="cps">
		<script>
		init.dates[ii] = {
				'id' : '<input type="checkbox" onchange="confirm_checked(this)" id="ccid" name="ccid" value="<s:property value="#cps.id"/>"/>&nbsp;<s:property value="#cps.id"/>',
				'gtime' : '${ppc1.gettime}<s:property value="#cps.gettime"/>',
				'name' : '<a href="<%=path %>/crm/customerPAction_findThecustomerp.action?customerP.id=<s:property value='#cps.id'/>"><s:property value="#cps.cname"/></a>',
				'prov':'<s:property value="#cps.prov"/>',
				'city' : '<s:property value="#cps.city"/>',
				'conn':'<s:property value="#cps.phonenum"/>',
				'email':'<s:property value="#cps.email"/>',
				'type':'<s:property value="#cps.type"/>',
				'status':'<s:property value="#cps.status"/>',
				'sex':'<s:property value="#cps.sex"/>',
				'birth':'<s:property value="#cps.birth"/>',
				'company':'<s:property value="#cps.company"/>',
				'ctype':'<s:property value="#cps.company_type"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出客户数据  start-->
	
	<!-- 添加客户界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addcustomerform" action="customerPAction_addcustomerp" method="post" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>个人信息</span></a></li>
						<li><a href="#section-2" ><span>公司信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="8">
						<tr>
						<td width="40%" align="right">*客户名称:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="cname" name="customerP.cname"/></td>
						</tr>
						<tr>
						<td align="right">*客户获取时间:</td>
						<td><input type="date" style="width:185px;height:30px;" id="d1" name="customerP.gettime"/></td>
						</tr>
						<tr>
						<td align="right">*客户生日:</td>
						<td><input type="date" style="width:185px;height:30px;" id="d2" name="customerP.birth"/></td>
						</tr>
						<tr>
						<td align="right">*所在省份/城市:</td>
						<td>
						<select style="width:185px;height:30px;" name="customerP.prov"></select>
						<select style="width:185px;height:30px;" id="cpc" name="customerP.city"></select>
  						</td>
						</tr>
						<tr>
							<td align="right">性别</td>
							<td>
							<select style="width:185px;height:30px;" name="customerP.sex">
								<option value=""></option>
								<option value="男">男</option>
								<option value="女">女</option>
  							</select>
  							</td>
  						</tr>
  						<tr>
						<td align="right">客户类型</td>
						<td>
						<select style="width:185px;height:30px;" name="customerP.type">
							<option value="">--请选择--</option>
							<option value="普通客户">普通客户</option>
							<option value="VIP1">VIP1</option>
							<option value="VIP2">VIP2</option>
							<option value="VIP3">VIP3</option>
  						</select>
  						</td>
  						</tr>
						<tr>
						<td align="right">客户状态</td>
						<td>
						<select style="width:185px;height:30px;" name="customerP.status">
							<option value="">--请选择--</option>
							<option value="潜在客户">潜在客户</option>
							<option value="意向客户">意向客户</option>
							<option value="成交客户">成交客户</option>
							<option value="已流失客户">已流失客户</option>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">联系方式</td>
						<td><input type="text" style="width:185px;height:30px;" id="phonenum" name="customerP.phonenum"/></td>
						</tr>
						<tr>
						<td align="right">*邮箱地址</td>
						<td><input type="text" style="width:185px;height:30px;" id="email" name="customerP.email"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">公司名称:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="companyname" name="customerP.company"/></td>
						</tr>
						<tr>
						<td width="40%" align="right">*是否为企业客户:</td>
						<td width="60%">
						<select style="width:185px;height:30px;" name="customerP.ifcompany">
							<option value="">--请选择--</option>
							<option value="是">是</option>
							<option value="否">否</option>
  						</select>
						</td>
						</tr>
						<tr>
						<td align="right">公司座机:</td>
						<td><input type="text" style="width:185px;height:30px;" id="company_num" name="customerP.company_num"/></td>
						</tr>
						<tr>
						<td align="right">公司地址:</td>
						<td><input type="text" style="width:185px;height:30px;" id="postcode" name="customerP.company_address"/></td>
						</tr>
						<tr>
						<td align="right">所属行业:</td>
						<td>
						<select style="width:185px;height:30px;" name="customerP.company_type">
							<option value="">--请选择--</option>
							<option value="消费者非必需品">消费者非必需品</option>
							<option value="消费者常用品">消费者常用品</option>
							<option value="基础材料">基础材料</option>
							<option value="能源">能源</option>
							<option value="金融">金融</option>
							<option value="医疗保健">医疗保健</option>
							<option value="工业">工业</option>
							<option value="信息技术">信息技术</option>
							<option value="电信服务">电信服务</option>
							<option value="公用事业">公用事业</option>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">公司简介</td>
						<td><textarea name="customerP.description" style="width:300px;height:100px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容,邮箱地址将作为登录用户名</h4>
			<input id="addcustomerb" type="button" value="保存信息"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加客户界面  start-->
	
<script>
new PCAS("customerP.prov","customerP.city");//"选择城市"赋值
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
});
</script>
	
  </body>
</html>
