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
	        			deleteid=deleteid+rows[i].pid;
	        		}else{
	        			deleteid=deleteid+rows[i].pid+", ";
	        		}
	        	}
	        	$.ajax({
					type: "POST",
					url: "crm/productAction_ifcandelete.action",
					data: {deleteid:deleteid},
					dataType: 'text',
					success: function(result) {
						if (result=="1") {
							alert("所选商品存在关联数据，请删相关销售机会、订单和服务记录后，再进行此操作");
							return 
						}else{
							window.location.href='<%=path %>/crm/productAction_deleteSomeProduct.action?pid='+deleteid;
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
		<s:form id="f1" action="productAction_deleteSomeProduct" namespace="/crm">
		<!-- 导航条 -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">商品信息列表</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="addnewproduct"><a href="javascript:void(0)">新增</a></li>
            	 <!--  <li><a href="#">有销售记录的</a></li>
           		  <li><a href="#">有客户意向的</a></li>
          		  <li><a href="#">无人问津的</a></li> -->
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
				search: true,
				clickToSelect: true,
				columns: [{field:"checkbox",checkbox: true,align:"center",valign:"middle"},
						  {field:"pid",title:"商品编号",align:"center",valign:"middle",sortable:"true"},
				          {field:"pname",title:"商品名称",align:"center",valign:"middle",sortable:"true"},
				          {field:"type",title:"类型",align:"center",valign:"middle",sortable:"true"},
				          {field:"price",title:"单价",align:"center",valign:"middle",sortable:"true"},
				          {field:"hb",title:"货币",align:"center",valign:"middle",sortable:"true"},
				          {field:"cost",title:"成本",align:"center",valign:"middle",sortable:"true"},
				          {field:"dw",title:"计数单位",align:"center",valign:"middle",sortable:"true"},
				          {field:"state",title:"状态",align:"center",valign:"middle",sortable:"true"},
				          {field:"market_time",title:"上市时间",align:"center",valign:"middle",sortable:"true"}],
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
	
	<!-- 迭代读出商品数据 start-->
	<s:iterator value="products" id="p1">
		<script>
		init.dates[ii] = {
				//<input type="checkbox" onchange="confirm_checked(this)" id="pid" name="pid" value="<s:property value="#p1.id"/>"/>&nbsp;
				'pid' : '<s:property value="#p1.id"/>',
				'pname' : '<a href="<%=path %>/crm/productAction_findTheProduct.action?product.id=<s:property value='#p1.id'/>"><s:property value="#p1.pname"/></a>',
				'type' : '<s:property value="#p1.type"/>',
				'price' : '<s:property value="#p1.price"/>',
				'hb' : '<s:property value="#p1.currency"/>',
				'cost' : '<s:property value="#p1.costing"/>',
				'dw' : '<s:property value="#p1.unit"/>',
				'state' : '<s:property value="#p1.status"/>',
				'market_time' : '<s:property value="#p1.market_time"/>'
			};
			ii++;
		</script>
	</s:iterator>
	<!-- 迭代读出商品数据 end-->
	
	<!-- 添加商品界面 start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="addproductform" action="addProductAction" method="post" enctype="multipart/form-data" namespace="/crm">
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>基本信息</span></a></li>
						<li><a href="#section-2" ><span>详细信息</span></a></li>				
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="40%" align="right">*商品名称:</td>
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="pname" name="product.pname"/></td>
						</tr>
						<tr>
						<td align="right">*商品类型:</td>
						<td>
						<select style="width:185px;height:30px;" id="sel1" name="product.type">
						<s:iterator value="porductDicts" id="pd1">
							<s:if test="#pd1.type!=null">
							<option value="<s:property value='#pd1.type'/>"><s:property value='#pd1.type'/></option>
							</s:if>
						</s:iterator>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">计数单位:</td>
						<td>
						<select style="width:185px;height:30px;" name="product.unit">
   						<s:iterator value="porductDicts" id="pd2">
							<s:if test="#pd2.unit!=null">
							<option value="<s:property value='#pd2.unit'/>"><s:property value='#pd2.unit'/></option>
							</s:if>
						</s:iterator>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">货币单位:</td>
						<td>
						<select style="width:185px;height:30px;" name="product.currency">
   						<s:iterator value="porductDicts" id="pd4">
							<s:if test="#pd4.currency!=null">
							<option value="<s:property value='#pd4.currency'/>"><s:property value='#pd4.currency'/></option>
							</s:if>
						</s:iterator>
  						</select>
  						</td>
						</tr>
						<tr>
						<td align="right">商品状态:</td>
						<td>
						<select style="width:185px;height:30px;" name="product.status">
   						<s:iterator value="porductDicts" id="pd3">
							<s:if test="#pd3.status!=null">
							<option value="<s:property value='#pd3.status'/>"><s:property value='#pd3.status'/></option>
							</s:if>
						</s:iterator>
  						</select>
  						</td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="20">
						<tr>
						<td width="40%" align="right">销售单价:</td>
						<td width="60%">
						<input type="text" style="width:185px;height:30px;" id="tprice" name="product.price"/>
						</td>
						</tr>
						<tr>
						<td align="right">制造成本:</td>
						<td>
						<input type="text" style="width:185px;height:30px;" id="tcost" name="product.costing"/>
  						</td>
						</tr>
						<tr>
						<td align="right">上市时间:</td>
						<td>
						<input type="date" style="width:185px;height:30px;" name="product.market_time"/>
  						</td>
						</tr>
						<tr>
						<td align="right">商品样图:</td>
						<td>
						<input type="file" style="width:185px;height:30px;" name="upload"/>
  						</td>
						</tr>
						<tr>
						<td align="right">商品简介:</td>
						<td>
						<textarea name="product.description" id="tt1" placeholder="最多50个汉字" style="resize: none;width: 250px;height: 100px;max-width: 250px;max-height: 100px;"></textarea>
						</td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="addproductb" type="button" value="新增商品"/>
			</s:form>
  		</div>
	</div>
	<!-- 添加商品界面 end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件start
    $('#addnewproduct').click(function() {
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
