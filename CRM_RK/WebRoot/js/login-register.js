$(function(){
	$('#switch_qlogin').click(function(){
		$('#switch_login').removeClass("switch_btn_focus").addClass('switch_btn');
		$('#switch_qlogin').removeClass("switch_btn").addClass('switch_btn_focus');
		$('#switch_bottom').animate({left:'0px',width:'70px'});
		$('#qlogin').css('display','none');
		$('#web_qr_login').css('display','block');
		
		});
	$('#switch_login').click(function(){
		
		$('#switch_login').removeClass("switch_btn").addClass('switch_btn_focus');
		$('#switch_qlogin').removeClass("switch_btn_focus").addClass('switch_btn');
		$('#switch_bottom').animate({left:'154px',width:'70px'});
		
		$('#qlogin').css('display','block');
		$('#web_qr_login').css('display','none');
		});
if(getParam("a")=='0'){
	$('#switch_login').trigger('click');
}

	});
	
function logintab(){
	scrollTo(0);
	$('#switch_qlogin').removeClass("switch_btn_focus").addClass('switch_btn');
	$('#switch_login').removeClass("switch_btn").addClass('switch_btn_focus');
	$('#switch_bottom').animate({left:'154px',width:'96px'});
	$('#qlogin').css('display','none');
	$('#web_qr_login').css('display','block');
	
}

//根据参数名获得该参数 pname等于想要的参数名 
function getParam(pname) { 
    var params = location.search.substr(1); // 获取参数 平且去掉？ 
    var ArrParam = params.split('&'); 
    if (ArrParam.length == 1) { 
        //只有一个参数的情况 
        return params.split('=')[1]; 
    } 
    else { 
         //多个参数参数的情况 
        for (var i = 0; i < ArrParam.length; i++) { 
            if (ArrParam[i].split('=')[0] == pname) { 
                return ArrParam[i].split('=')[1]; 
            } 
        } 
    } 
}  

$(document).ready(function() {
	//登录验证
	$('#denglu').click(function(){
		$.ajax({
			type: "POST",
			url: "crm/loginRegisterAction_validateLogin.action",
			data: {un:$('#u').val(),pw:$('#p').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="账号不存在") {
					$('#p').css({
						border: "1px solid #D7D7D7",boxShadow: "none"
					});
					$('#u').focus().css({
						border: "1px solid red",boxShadow: "0 0 2px red"
					});
					$("#loginuserCue").html("<font color='red'><b>×"+result+"</b></font>");
				}else if(result=="账号和密码不一致") {
					$('#u').css({
						border: "1px solid #D7D7D7",boxShadow: "none"
					});
					$('#p').focus().css({
						border: "1px solid red",boxShadow: "0 0 2px red"
					});
					$("#loginuserCue").html("<font color='red'><b>×"+result+"</b></font>");
				}else{
					var fl=document.getElementById('login_form');
					fl.submit();
				}
			}
		});
	});
	
	//注册验证
	var emailfilter=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	var passwordfilter=/^(\w){6,20}$/;
	$('#email').blur(function(){
		var email=$('#email').val();
		if(emailfilter.test(email)){
			$.ajax({
				type: "POST",
				url: "crm/loginRegisterAction_validateRegister1.action",
				data: {un:$('#email').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$('#email').focus().css({
							border: "1px solid red",boxShadow: "0 0 2px red"
						});
						$("#registeruserCue").html("<font color='red'><b>×邮箱已被注册</b></font>");
					}else{
						$('#email').css({
							border: "1px solid #D7D7D7",boxShadow: "none"
						});
						$('#registeruserCue').html("欢迎注册");
					}
				}
			});
		}else{
			$('#email').focus().css({
				border: "1px solid red",boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×邮箱格式不正确</b></font>");
		}
	});
	
	$('#passwd').blur(function(){
		var p1=$('#passwd').val();
		if(passwordfilter.test(p1)){
			$('#passwd').css({
				border: "1px solid #D7D7D7",boxShadow: "none"
			});
			$("#registeruserCue").html("欢迎注册");
		}else{
			$('#passwd').focus().css({
				border: "1px solid red",boxShadow: "0 0 2px red"
			});
			$("#registeruserCue").html("<font color='red'><b>×密码由6-20个字母、数字、下划线组成</b></font>");
		}
	});
	
	$('#passwd2').blur(function(){
		var p1=$('#passwd').val();
		var p2=$('#passwd2').val();
		if(p1!=p2){
			$('#passwd2').css({
				border: "1px solid red",boxShadow: "0 0 2px red"
			});
			$("#registeruserCue").html("<font color='red'><b>×两次输入密码不一致</b></font>");
		}else{
			$('#passwd2').css({
				border: "1px solid #D7D7D7",boxShadow: "none"
			});
			$("#registeruserCue").html("欢迎注册");
		}
	});

	$('#reg').click(function() {
		if ($('#email').val() == ""||$('#email').val()==null) {
			$('#email').css({
				border: "1px solid red",
				boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×邮箱地址不能为空</b></font>");
			return false;
		}
		if($('#passwd').val()==""||$('#passwd').val()==null){
			$('#passwd').css({
				border: "1px solid red",
				boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×密码不能为空</b></font>");
			return false;
		}
		
		if(!passwordfilter.test($('#passwd').val())){
			$('#passwd').css({
				border: "1px solid red",boxShadow: "0 0 2px red"
			});
			$("#registeruserCue").html("<font color='red'><b>×密码由6-20个字母、数字、下划线组成</b></font>");
			return false;
		}
		
		if($('#passwd2').val()==""||$('#passwd2').val()==null){
			$('#passwd2').css({
				border: "1px solid red",
				boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×请再次输入密码</b></font>");
			return false;
		}
		if($('#passwd2').val()!=$('#passwd').val()){
			$('#passwd2').css({
				border: "1px solid red",
				boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×两次输入密码不一致</b></font>");
			return false;
		}
		
		if(emailfilter.test($('#email').val())){
			$.ajax({
				type: "POST",
				url: "crm/loginRegisterAction_validateRegister1.action",
				data: {un:$('#email').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$('#email').css({
							border: "1px solid red",boxShadow: "0 0 2px red"
						});
						$("#registeruserCue").html("<font color='red'><b>×邮箱已被注册</b></font>");
						return false;
					}else{
						$('#email').css({
							border: "1px solid #D7D7D7",boxShadow: "none"
						});
						$('#registeruserCue').html("欢迎注册");
						alert("注册成功");
						$('#regUser').submit();
					}
				}
			});
		}else{
			$('#email').css({
				border: "1px solid red",boxShadow: "0 0 2px red"
			});
			$('#registeruserCue').html("<font color='red'><b>×邮箱格式不正确</b></font>");
			return false;
		}
		
	});
	
});