<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>个人信息</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<link href="<%=path%>/css/info.css" rel="stylesheet" type="text/css" />
	<link rel="stylesheet" href="<%=path%>/css/addProductMain.css" />
	<script src="<%=path%>/js/jquery-3.0.0.min.js"></script>
	<script src="<%=path%>/js/myjq.js"></script>
	<script>
		$(function(){
			//保存信息，方便取消修改时还原
			var nameid=$('#nameid').text();
			var connid=$('#connid').text();
			var homeid=$('#homeid').text();
			var nameid2=$('#nameid').text();
			var connid2=$('#connid').text();
			var homeid2=$('#homeid').text();
			//修改密码判断条件
			var updateok=false,updateok2=false,updateok3=false;
			
			/*
				click4为个人信息修改初始化;
				click3为个人信息保存修改的资料;
				click1为个人信息取消修改;
				click2为个人信息修改密码初始化
			*/ 
			function click1(){
				$('#nameid').html(nameid);
				$('#connid').html(connid);
				$('#homeid').html(homeid);
				$('#edit').text('编辑资料');
				$('#updatepw').html('修改密码&raquo;');
				$('#updatepw').off("click",click1);
				$('#edit').off('click',click3);
				$('#updatepw').on("click",click2);
				$('#edit').on('click',click4);
			}
			function click2(){
				$('#code6').center();
		        $('#goodcover').show();
		        $('#code6').fadeIn();
			}
			function click3(){
				$.ajax({
					type: "POST",
					url: "crm/informationAction_updatesalesmanInfo.action",
					data: {sid:$('#sid').val(),name:$('#name2').val(),conn:$('#conn2').val(),home:$('#home2').val()},
					dataType: 'json',
					success: function(jsonStr2) {
						nameid=jsonStr2.sname;
						connid=jsonStr2.phone;
						homeid=jsonStr2.address;
						$('#nameid').html(jsonStr2.sname);
						$('#connid').html(jsonStr2.phone);
						$('#homeid').html(jsonStr2.address);
						$('#edit').text('编辑资料');
						$('#updatepw').html('修改密码&raquo;');
						$('#updatepw').off("click",click1);
						$('#edit').off('click',click3);
						$('#updatepw').on("click",click2);
						$('#edit').on('click',click4);
					}
				});
			}
			function click4(){
				$('#edit').off('click',click4);
				$('#updatepw').off("click",click2);
				$('#nameid').html('<input id="name2" type="text" style="height:30px;"/>');
				$('#name2').val(nameid);
				$('#connid').html('<input id="conn2" type="text" style="height:30px;"/>');
				$('#conn2').val(connid);
				$('#homeid').html('<input id="home2" type="text" style="height:30px;"/>');
				$('#home2').val(homeid);
				$('#edit').text('保存资料');
				$('#updatepw').html('返回&raquo;');
				$('#edit').on('click',click3);
				$('#updatepw').on("click",click1);
			}
			
			$('#edit').on('click',click4);
			$('#updatepw').on('click',click2);
			
			
			/*
			click5为渠道信息修改初始化;
			click6为个人信息保存修改的资料;
			click7为个人信息取消修改;
			*/ 
			
			var codeid=$('#codeid').text();
			var comid=$('#comid').text();
			var comadid=$('#comadid').text();
			
			function click5(){
				$('#edit2').off('click',click5);
				$('#codeid').html('<input id="inpp" type="text" style="height:30px;"/>');
				$('#inpp').val(codeid);
				$('#comid').html('<input id="com" type="text" style="height:30px;"/>');
				$('#com').val(comid);
				$('#comadid').html('<input id="comad" type="text" style="height:30px;"/>');
				$('#comad').val(comadid);
				$('#edit2').html('保存资料');
				$('#edit3').html('返回&raquo;');
				$('#edit2').on('click',click6);
				$('#edit3').on('click',click7);
			}
			
			function click6(){
				$.ajax({
					type: "POST",
					url: "crm/informationAction_updatechannelInfo.action",
					data: {cid:$('#cid').val(),codeid:$('#inpp').val(),comid:$('#com').val(),comadid:$('#comad').val()},
					dataType: 'json',
					success: function(jsonStr) {
						codeid=jsonStr.cname;
						comid=jsonStr.website;
						comadid=jsonStr.address;
						$('#codeid').html(jsonStr.cname);
						$('#comid').html(jsonStr.website);
						$('#comadid').html(jsonStr.address);
						$('#edit2').html('编辑资料');
						$('#edit3').html('');
						$('#edit2').off("click",click6);
						$('#edit3').off('click',click7);
						$('#edit2').on("click",click5);
					}
				});
			}
			
			function click7(){
				$('#codeid').html(codeid);
				$('#comid').html(comid);
				$('#comadid').html(comadid);
				$('#edit2').html('编辑资料');
				$('#edit3').html('');
				$('#edit2').off("click",click6);
				$('#edit3').off('click',click7);
				$('#edit2').on("click",click5);
			}
			
			$('#edit2').on('click',click5);
			
			//inp1,inp2,inp3为修改密码时的验证
			$('#inp1').blur(function(){
				$.ajax({
					type: "POST",
					url: "crm/informationAction_validate1.action",
					data: {idid:$('#sid').val(),num1:$('#inp1').val()},
			        async: false,
					dataType: 'text',
					success: function(flag) {
						if(flag=="1"){
							updateok=true;
							$('#t1').text("✔");
						}else{
							updateok=false;
							$('#t1').text("×原密码输入错误");
						}
					}
				});
			});
			$('#inp2').blur(function(){
				var passwordfilter=/^(\w){6,20}$/;
				if(passwordfilter.test($('#inp2').val())){
					updateok2=true;
					$('#t2').text("✔");
				}else{
					updateok2=false;
					$('#t2').text("×请输入6~20位密码(字母,数字,下划线)");
				}
			});
			$('#inp3').blur(function(){
				if($('#inp3').val()==$('#inp2').val()){
					updateok3=true;
					$('#t3').text("✔");
				}else{
					updateok3=false;
					$('#t3').text("×两次密码输入不一致");
				}
			});
			//修改密码点击事件
			$('#updatebtn').click(function(){
				if(updateok&&updateok2&&updateok3){
					$.ajax({
						type: "POST",
						url: "crm/informationAction_updatepw.action",
						data: {idid:$('#sid').val(),num1:$('#inp3').val()},
				        async: false,
						dataType: 'text',
						success: function(flag) {
							updateok=false;updateok2=false;updateok3=false;
							$('#code6').hide();
					        $('#goodcover').hide();
					        $('#inp1').val("");$('#t1').text("");
					        $('#inp2').val("");$('#t2').text("");
					        $('#inp3').val("");$('#t3').text("");
							alert("修改成功");
						}
					});
				}
			});
				
		});
	</script>
  </head>
  
  <body>
  	<!-- 修改密码 start -->
  	<div id="goodcover"></div>
	<div id="code6">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 			<table cellpadding="5" style="margin-top:60px;margin-left:20px;">
 			<tr><td align="right">原密码 : </td><td><input id="inp1" style="height:30px;font-size:16px;" type="password"/></td><td id="t1"></td></tr>
 			<tr><td align="right">新密码 : </td><td><input id="inp2" style="height:30px;font-size:16px;" type="password"/></td><td id="t2"></td></tr>
 			<tr><td align="right">确认密码 : </td><td><input id="inp3" style="height:30px;font-size:16px;" type="password"/></td><td id="t3"></td></tr>
 			<tr><td colspan="3" align="center"><input type="button" style="width:100px;height:30px;" value="保存修改" id="updatebtn"/></td></tr>
 			</table>
  		</div>
	</div>
  	<!-- 修改密码 end -->
  
  	<!-- 显示个人信息 start -->
    <div id="content">
	<div id="posts">
		<div class="post">
			<h2 class="title">个人信息</h2>
			<input type="hidden" id="sid" value="${salesman.id}"/>
			<div class="story">
				<table cellpadding="5">
                <tr>
                <td>姓名：</td>
                <td id='nameid'>${salesman.sname}</td>
                </tr>
                <tr>
                <td>联系方式：</td>
                <td id='connid'>${salesman.phone}</td>
                </tr>
                <tr>
                <td>住址：</td>
                <td id='homeid'>${salesman.address}</td>
                </tr>
                <tr>
                <td>渠道：</td>
                <td>${salesman.channel.cname}</td>
                </tr>
                <tr>
                <td>经理：</td>
                <td>${salesman.manager.name}</td>   
                </tr>
                </table>
			</div>
			<div class="meta">				
				<p><a id="edit" href="javascript:void(0)" class="category">编辑资料</a> | 
				<a id="updatepw" href="javascript:void(0)" class="comment">修改密码&raquo;</a></p>
			</div>
		</div>
		<div class="post">
			<h2 class="title">销售渠道</h2>
			<input type="hidden" id="cid" value="${salesman.channel.id}"/>
			<div class="story">
				<table cellpadding="5">
                <tr>
                <td>邮编：</td>
                <td id='codeid'>${salesman.channel.postcode}</td>
                </tr>
                <tr>
                <td>公司主页：</td>
                <td id='comid'>${salesman.channel.website}</td>
                </tr>
                <tr>
                <td>公司地址：</td>
                <td id='comadid'>${salesman.channel.address}</td>
                </tr>
                <tr>
                <td>代理等级：</td>
                <td>${salesman.channel.level}</td>
                </tr>
                <tr>
                <td>加入时间：</td>
                <td>${salesman.channel.enjoyDate}</td>   
                </tr>
                </table>
			</div>
			<div class="meta">				
				<p><a id="edit2" href="javascript:void(0)" class="category">编辑资料</a> |
				<a id="edit3" href="javascript:void(0)" class="comment"></a></p> 
			</div>
		</div>
	</div>
    
  <div id="search" class="yellownotes">
		<h2 class="heading">渠道销售业绩</h2>
		<div class="content">
				<div>
				<table cellpadding="5">
				<tr>
                <td>销售员：</td>
                <td>${salesmannum}&nbsp;个</td>
                </tr>
                <tr>
                <td>接单数量：</td>
                <td>${ordersnum}&nbsp;单</td>
                </tr>
                <tr>
                <td>负责机会：</td>
                <td>${chancenum}&nbsp;个</td>
                </tr>
                <tr>
                <td>完成任务：</td>
                <td>${num1}&nbsp;次</td>
                </tr>
                </table>
			  </div>
		</div>
	</div>
</div>
<!-- 显示个人信息 end -->

<script>
$(function(){
	//弹出层事件 start
	$('#closebt').click(function() {
        $('#code6').hide();
        $('#goodcover').hide();
    });
	$('#goodcover').click(function() {
        $('#code6').hide();
        $('#goodcover').hide();
    });
	//弹出层事件 end
});
</script>
  </body>
</html>
