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
			if (!confirm("确认删除？")) {
		        window.event.returnValue = false;
		    }
			else{
				var idid=$('#cpid').text();
				window.location.href="<%=path %>/crm/customerPAction_deleteThecustomerp.action?customerP.id="+idid;
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
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">客户详细信息</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/customerPAction_findAllcustomerp.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="updatecustomerp"><a href="javascript:void(0)">编辑</a></li>
        		</ul>
    		</div>
		</div>
			<!-- 数据表格  start-->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">消费记录</td>
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
						<td colspan="4" width="100%">客户信息</td>
					</tr>
					<tr>
						<td align="right">客户编号:&nbsp;</td><td id="cpid">${customerP.id}</td>
						<td align="right">客户名称:&nbsp;</td><td>${customerP.cname}</td>
					</tr>
					<tr>
						<td align="right">获取时间:&nbsp;</td><td>${customerP.gettime}</td>
						<td align="right">生日:&nbsp;</td><td>${customerP.birth}</td>
					</tr>
					<tr>
						<td align="right">性别:&nbsp;</td><td id="t1">${customerP.sex}</td>
						<td align="right">所在省份:&nbsp;</td><td id="t2">${customerP.prov}</td>
					</tr>
					<tr>
						<td align="right">联系方式:&nbsp;</td><td>${customerP.phonenum}</td>
						<td align="right">所在城市:&nbsp;</td><td id="t3">${customerP.city}</td>
					</tr>
					<tr>
						<td align="right">电子邮件:&nbsp;</td><td id="ppicture">${customerP.email}</td>
						<td align="right">客户状态:&nbsp;</td><td id="t4">${customerP.status}</td>
					</tr>
					<tr>
						<td align="right">客户类型:&nbsp;</td><td id="t5">${customerP.type}</td>
						<td align="right"></td><td></td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">公司信息</td>
					</tr>
					<tr>
						<td align="right">是否为企业客户:&nbsp;</td><td id="ifcom">${customerP.ifcompany}</td>
						<td align="right"></td><td></td>
					</tr>
					<tr>
						<td align="right">公司名称:&nbsp;</td><td id="ppicture">${customerP.company}</td>
						<td align="right">公司座机:&nbsp;</td><td>${customerP.company_num}</td>
					</tr>
					<tr>
						<td align="right">公司地址:&nbsp;</td><td id="ppicture">${customerP.company_address}</td>
						<td align="right">公司类型:&nbsp;</td><td id="t6">${customerP.company_type}</td>
					</tr>
					<tr>
						<td align="right">简介:&nbsp;</td><td id="t7">${customerP.description}</td>
						<td align="right"></td><td></td>
					</tr>
				</table>
			</div>
			<!-- 数据表格  end-->
		</div>
	</div>
	
	<!--弹出窗口、 修改商品界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatecustomerform" action="customerPAction_updatecustomerp" method="post" namespace="/crm">
 			<input type="hidden" id="cid" name="customerP.id" value="${customerP.id}"/>
 			<input type="hidden" id="uid" name="userPower.id" value="${customerP.userPower.id}"/>
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
						<td width="60%"><input type="text" style="width:185px;height:30px;" value="${customerP.cname}" id="cname" name="customerP.cname"/></td>
						</tr>
						<tr>
						<td align="right">*客户获取时间:</td>
						<td><input type="date" style="width:185px;height:30px;" id="d1" value="${customerP.gettime}" name="customerP.gettime"/></td>
						</tr>
						<tr>
						<td align="right">*客户生日:</td>
						<td><input type="date" style="width:185px;height:30px;" id="d2" value="${customerP.birth}" name="customerP.birth"/></td>
						</tr>
						<tr>
						<td align="right">*所在省份/城市:</td>
						<td>
						<select style="width:185px;height:30px;" id="cpp" name="customerP.prov"></select>
						<select style="width:185px;height:30px;" id="cpc" name="customerP.city"></select>
  						</td>
						</tr>
						<tr>
							<td align="right">性别</td>
							<td>
							<select style="width:185px;height:30px;" id="cps" name="customerP.sex">
								<option value=""></option>
								<option value="男">男</option>
								<option value="女">女</option>
  							</select>
  							</td>
  						</tr>
  						<tr>
						<td align="right">客户类型</td>
						<td>
						<select style="width:185px;height:30px;" id="cpt" name="customerP.type">
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
						<select style="width:185px;height:30px;" id="cpst" name="customerP.status">
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
						<td><input type="text" style="width:185px;height:30px;" id="phonenum" value="${customerP.phonenum}" name="customerP.phonenum"/></td>
						</tr>
						<tr>
						<td align="right">*电子邮件</td>
						<td><input type="text" style="width:185px;height:30px;" id="email" value="${customerP.email}" name="customerP.email"/></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr> 
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">公司名称:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" value="${customerP.company}" name="customerP.company"/></td>
						</tr>
						<tr>
						<td width="40%" align="right">*是否为企业客户:</td>
						<td width="60%">
						<select style="width:185px;height:30px;" id="ifsel" name="customerP.ifcompany">
							<option value="">--请选择--</option>
							<option value="是">是</option>
							<option value="否">否</option>
  						</select>
						</td>
						</tr>
						<tr>
						<td align="right">公司座机:</td>
						<td><input type="text" style="width:185px;height:30px;" id="company_num" value="${customerP.company_num}" name="customerP.company_num"/></td>
						</tr>
						<tr>
						<td align="right">公司地址:</td>
						<td><input type="text" style="width:185px;height:30px;" value="${customerP.company_address}" name="customerP.company_address"/></td>
						</tr>
						<tr>
						<td align="right">所属行业:</td>
						<td>
						<select style="width:185px;height:30px;" id="cpct" name="customerP.company_type">
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
						<td><textarea id="t8" name="customerP.description" style="width:300px;height:100px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容,邮箱地址将作为登录用户名</h4>
			<input id="updatecustomerb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改商品界面  end-->s
	
<script>
new PCAS("customerP.prov","customerP.city");//"选择城市"赋值
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件 start
    $('#updatecustomerp').click(function() {
    	$('#cpp').val($('#t2').text());
    	$('#cpc').val($('#t3').text());
    	$('#cps').val($('#t1').text());
    	$('#cpt').val($('#t5').text());
    	$('#cpst').val($('#t4').text());
    	$('#cpct').val($('#t6').text());
    	$('#t8').val($('#t7').text());
    	$('#ifsel').val($('#ifcom').text());
    	
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
