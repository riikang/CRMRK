<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>系统版本</title>
<script type="text/javascript" src="js/jquery-2.0.0.min.js"></script>
<script>
//动态显示时间
setInterval(function(){   
    $("#atime").text("当前时间 ： "+new Date().toLocaleString());   
},1000); 
</script>
</head>
<body>
<div>
	<h3>客户关系管理系统</h3>
	<h4>version ： 1.0.0</h4>
	<h4><span id="atime"></span></h4>
</div>
</body>
</html>