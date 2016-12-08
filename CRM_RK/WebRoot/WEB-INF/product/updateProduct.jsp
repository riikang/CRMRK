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
	<link rel="stylesheet" href="css/addProductMain.css" />
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
			if (!confirm("确认删除该产品？")) {
		    	window.event.returnValue = false;
		    }
			else{
				$.ajax({
					type: "POST",
					url: "crm/productAction_ifcandeleteone.action",
					data: {deleteid:$('#pid').text()},
					dataType: 'text',
					success: function(result) {
						if (result=="1") {
							alert("该商品存在关联数据，请删相关销售机会、订单和服务记录后，再进行此操作");
							return 
						}else{
							var idid=$('#pid').text();
							window.location.href="<%=path %>/crm/productAction_deleteTheProduct.action?product.id="+idid;
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
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">商品信息详细</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/productAction_findAllProduct.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="updateproduct"><a href="javascript:void(0)">编辑</a></li>
           		 <!-- <li onclick=""><a href="javascript:void(0)">销量统计</a></li> -->
        		</ul>
    		</div>
		</div>
			<!-- 表格div start -->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
				<s:iterator value="product" id="p1">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">销售信息</td>
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
						<td colspan="4" width="100%">商品信息</td>
					</tr>
					<tr>
						<td align="right">商品编号:&nbsp;</td><td id="pid"><s:property value='#p1.id'/></td>
						<td align="right">商品名称:&nbsp;</td><td id="pname"><s:property value='#p1.pname'/></td>
					</tr>
					<tr>
						<td align="right">商品类型:&nbsp;</td><td id="ptype"><s:property value='#p1.type'/></td>
						<td align="right">商品单价:&nbsp;</td><td id="price"><s:property value='#p1.price'/></td>
					</tr>
					<tr>
						<td align="right">商品成本:&nbsp;</td><td id="pcosting"><s:property value='#p1.costing'/></td>
						<td align="right">商品计数单位:&nbsp;</td><td id="punit"><s:property value='#p1.unit'/></td>
					</tr>
					<tr>
						<td align="right">商品状态:&nbsp;</td><td id="pstatus"><s:property value='#p1.status'/></td>
						<td align="right">上市时间:&nbsp;</td><td id="pmarket_time">
						<input type="text" readonly="readonly" id="time1" value='<s:date format="yyyy-MM-dd" name="product.market_time"/>' /> 
						</td>
					</tr>
					<tr>
						<td align="right">商品样图:&nbsp;</td><td id="ppicture"><a id="picture11" href="javascript:void(0)"><s:property value='#p1.picture'/></a></td>
						<td align="right">货币单位:&nbsp;</td><td id="hb"><s:property value='#p1.currency'/></td>
					</tr>
					<tr>
						<td align="right">商品简介:&nbsp;</td><td colspan="3" id="pdescription"><s:property value='#p1.description'/></td>
					</tr>
					</s:iterator>
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
 		<s:form theme="simple" id="updateproductform" action="updateProductAction" method="post" enctype="multipart/form-data" namespace="/crm">
 			<input type="hidden" name="product.id" id="pid2"/>
    		<div id="tabs" style="margin-bottom: 0px;" class="tabs">
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
						<td width="60%"><input type="text" style="width:185px;height:30px;" id="pname2" name="product.pname"/></td>
						</tr>
						<tr>
						<td align="right">*商品类型:</td>
						<td>
						<select style="width:185px;height:30px;" id="ptype2" name="product.type">
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
						<select style="width:185px;height:30px;" id="punit2" name="product.unit">
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
						<select style="width:185px;height:30px;" id="hb2" name="product.currency">
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
						<select style="width:185px;height:30px;" id="pstatus2" name="product.status">
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
						<table width=100% align="center" cellpadding="15">
						<tr>
						<td width="40%" align="right">销售单价:</td>
						<td width="60%">
						<input type="text" style="width:185px;height:30px;" id="pprice2" name="product.price"/>
						</td>
						</tr>
						<tr>
						<td align="right">制造成本:</td>
						<td>
						<input type="text" style="width:185px;height:30px;" id="pcosting2" name="product.costing"/>
  						</td>
						</tr>
						<tr>
						<td align="right">上市时间:</td>
						<td>
						<input type="date" style="width:185px;height:30px;" id="ptime2" name="product.market_time"/>
  						</td>
						</tr>
						<tr>
						<td align="right">商品样图:</td>
						<td>
						<input type="text" readonly="readonly" style="width:185px;height:30px;" name="product.picture" id="ppicture2"/>
  						</td>
						</tr>
						<tr>
						<td align="right">重新上传:</td>
						<td>
						<input type="file" style="width:185px;height:30px;" name="upload"/>
  						</td>
						</tr>
						<tr>
						<td align="right">商品简介:</td>
						<td>
						<textarea id="pde" name="product.description" placeholder="最多50个汉字" style="resize: none;width: 250px;height: 100px;max-width: 250px;max-height: 100px;"></textarea>
						</td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="updateproductb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改商品界面  end-->
	
	<!--预览图片  start-->
	<div id="goodcover2"></div>
	<div id="code2">
		<div class="close1"><a href="javascript:void(0)" id="closebt2"><img src="images/close.gif"></a></div>
		<div class="goodtxt">
			<img id="img" width="80%" height="80%" src=""/>
		</div>
	</div>
	<!--预览图片  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//弹出层事件start
	$('#code2').hide();
	$('#picture11').click(function(){
		$('#img').attr("src",$('#ppicture').text());
		$('#code2').center();
        $('#goodcover2').show();
        $('#code2').fadeIn();
	});
	 $('#closebt2').click(function() {
	        $('#code2').hide();
	        $('#goodcover2').hide();
	    });
	 $('#goodcover2').click(function() {
	        $('#code2').hide();
	        $('#goodcover2').hide();
	    });
    $('#updateproduct').click(function() {
    	$('#pid2').val($('#pid').text());
    	$('#pname2').val($('#pname').text());
    	$('#ptype2').val($('#ptype').text());
    	$('#punit2').val($('#punit').text());
    	$('#pstatus2').val($('#pstatus').text());
    	$('#pprice2').val($('#price').text());
    	$('#ppicture2').val($('#ppicture').text());
    	$('#pde').val($('#pdescription').text());
    	$('#ptime2').val($('#time1').val());
    	$('#pcosting2').val($('#pcosting').text());
    	$('#hb2').val($('#hb').text());
    	
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
