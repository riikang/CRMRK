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
    <title>注册/登录</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="description" content="This is my page">
	<script src="js/jquery-3.0.0.min.js" type="text/javascript" ></script>
	<script src="js/login-register.js" type="text/javascript"></script>
	<link href="css/login-register.css" rel="stylesheet" type="text/css" />
	
  </head>
  
  <body>
	<h1>客户关系管理系统<sup>RK</sup></h1>
	<div class="login" style="margin-top:50px;">
    <div class="header">
        <div class="switch" id="switch">
        	<a class="switch_btn_focus" id="switch_qlogin" href="javascript:void(0);" tabindex="7">&nbsp;&nbsp;&nbsp;登录</a>
			<a class="switch_btn" id="switch_login" href="javascript:void(0);" tabindex="8">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;注册</a>
			<div class="switch_bottom" id="switch_bottom" style="position: absolute; width: 64px; left: 0px;"></div>
        </div>
    </div>  
      
  <!--登录-->
    <div class="web_qr_login" id="web_qr_login" style="display: block; height: 300px;">    
        <div class="web_login" id="web_login">
        	<div class="login-box">
				<div class="login_form">
					<s:form action="loginRegisterAction_loginSet" namespace="/crm" name="loginform" accept-charset="utf-8" id="login_form" class="loginForm" method="post">
               			<div id="loginuserCue" class="cue">欢迎登录</div>
                		<div class="uinArea" id="uinArea">
                			<label class="input-tips" for="u">账号：</label>
                			<div class="inputOuter" id="uArea">
                    			<input type="text" id="u" name="userPower.username" class="inputstyle"/>
               				</div>
                		</div>
                		<div class="pwdArea" id="pwdArea">
               				<label class="input-tips" for="p">密码：</label> 
               				<div class="inputOuter" id="pArea">
                    			<input type="password" id="p" name="userPower.password" class="inputstyle"/>
                			</div>
                		</div>
                		<div style="padding-left:50px;margin-top:20px;"><input type="button" value="登 录" style="width:150px;" id="denglu" class="button_blue"/></div>
             		</s:form>
           		</div>
            </div>
        </div>
  	</div>
   <!--登录end-->

  	<!--注册-->
    <div class="qlogin" id="qlogin" style="display: none; ">
    	<div class="web_login">
    		<s:form action="loginRegisterAction_setRegister" namespace="/crm" name="form2" id="regUser" accept-charset="utf-8" method="post">
        	<ul class="reg_form" id="reg-ul">
        		<div id="registeruserCue" class="cue">欢迎注册</div>
                <li>
                	<label for="user"  class="input-tips2">邮箱：</label>
                    <div class="inputOuter2">
                        <input type="text" id="email" name="manager.email" class="inputstyle2"/>
                    </div>
                </li>
                <li>
                <label for="passwd" class="input-tips2">密码：</label>
                    <div class="inputOuter2">
                        <input type="password" id="passwd"  name="userPower.password" maxlength="16" class="inputstyle2"/>
                    </div>
                </li>
                <li>
                <label for="passwd2" class="input-tips2">确认密码：</label>
                <div class="inputOuter2">
                	<input type="password" id="passwd2" name="passwd2" maxlength="16" class="inputstyle2" />
                </div>
                </li>
                <li>
                <label class="input-tips2"></label>
                <div class="inputOuter2">
                	<label>*邮箱将作为登录的用户名</label>
                </div>
                </li>
                <li>
                  <div class="inputArea">
                     <input type="button" id="reg"  style="width:150px;margin-top:10px;margin-left:85px;" class="button_blue" value="注册"/>
                  </div>
                </li>
                <div class="cl"></div>
            </ul></s:form>
    	</div>
    </div>
    <!--注册end-->
	</div>
</body>
</html>
