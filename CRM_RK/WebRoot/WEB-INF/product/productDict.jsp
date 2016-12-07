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
    
    <title>商品数据字典</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="<%=path%>/css/jquery.treemenu.css" rel="stylesheet">
	<link href="<%=path%>/css/tree.css" rel="stylesheet">
	<script src="<%=path%>/js/jquery-3.0.0.min.js"></script>
	<script src="<%=path%>/js/jquery.treemenu.js"></script> 
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		$(function(){
			$('#atype').click(function(){
				$('#type').append(
						"<li><input style='height:30px;border:solid  #46CFB0;' type='text' id='dd2'/>&nbsp;<a id='submit' href='javascript:void(0)'>╋</a></li>"
						);
			});
			$('#acount').click(function(){
				$('#count').append(
						"<li><input style='height:30px;border:solid  #46CFB0;' type='text' id='dd3'/>&nbsp;<a id='submit2' href='javascript:void(0)'>╋</a></li>"
						);
			});
			$('#astatus').click(function(){
				$('#status').append(
						"<li><input style='height:30px;border:solid  #46CFB0;' type='text' id='dd4'/>&nbsp;<a id='submit3' href='javascript:void(0)'>╋</a></li>"
						);
			});
			$('#amoney').click(function(){
				$('#money').append(
						"<li><input style='height:30px;border:solid  #46CFB0;' type='text' id='dd5'/>&nbsp;<a id='submit4' href='javascript:void(0)'>╋</a></li>"
						);
			});
			
			$(document).on("click","#submit",function(){
				var ddd=$('#dd2').val();
				window.location.href="<%=path %>/crm/productDictAction_addDict.action?productDict.type="+ddd;
			});
			$(document).on("click","#submit2",function(){
				var ddd=$('#dd3').val();
				window.location.href="<%=path %>/crm/productDictAction_addDict.action?productDict.unit="+ddd;
			});
			$(document).on("click","#submit3",function(){
				var ddd=$('#dd4').val();
				window.location.href="<%=path %>/crm/productDictAction_addDict.action?productDict.status="+ddd;
			});
			$(document).on("click","#submit4",function(){
				var ddd=$('#dd5').val();
				window.location.href="<%=path %>/crm/productDictAction_addDict.action?productDict.currency="+ddd;
			});
		});
	</script>
	
  </head>
  
  <body>
    <ul class="tree">
    
  <li>&nbsp;商品类型&nbsp;<a id="atype" href="javascript:void(0)">╋</a>
    <ul id="type">
      <s:iterator value="productDicts" id="pd1" status="st">
      <s:if test="#pd1.type!=null">
      <li><a href="javascript:void(0)"><s:property value="#pd1.type"/></a>
      <a href="<%=path %>/crm/productDictAction_deleteDict.action?productDict.id=<s:property value="#pd1.id"/>">×</a>
      </li>
      </s:if>
      </s:iterator>
    </ul>
  </li>
  
  <li>&nbsp;商品计数单位&nbsp;<a id="acount" href="javascript:void(0)">╋</a>
    <ul id="count">
      <s:iterator value="productDicts" id="pd2" status="st">
      <s:if test="#pd2.unit!=null">
      <li><a href="#"><s:property value="#pd2.unit"/></a>
      <a href="<%=path %>/crm/productDictAction_deleteDict.action?productDict.id=<s:property value="#pd2.id"/>">×</a>
      </li>
      </s:if>
      </s:iterator>
    </ul>
  </li>
  
  <li>&nbsp;商品状态&nbsp;<a id="astatus" href="javascript:void(0)">╋</a>
    <ul id="status">
      <s:iterator value="productDicts" id="pd3" status="st">
      <s:if test="#pd3.status!=null">
      <li><a href="#"><s:property value="#pd3.status"/></a>
      <a href="<%=path %>/crm/productDictAction_deleteDict.action?productDict.id=<s:property value="#pd3.id"/>">×</a>
      </li>
      </s:if>
      </s:iterator>
    </ul>
  </li>
  
  <li>&nbsp;货币单位&nbsp;<a id="amoney" href="javascript:void(0)">╋</a>
    <ul id="money">
      <s:iterator value="productDicts" id="pd4" status="st">
      <s:if test="#pd4.currency!=null">
      <li><a href="#"><s:property value="#pd4.currency"/></a>
      <a href="<%=path %>/crm/productDictAction_deleteDict.action?productDict.id=<s:property value="#pd4.id"/>">×</a>
      </li>
      </s:if>
      </s:iterator>
    </ul>
  </li>
</ul>

	<script>
	$(function(){
        $(".tree").treemenu({delay:300}).openActive();
    });
	</script>

  </body>
</html>
