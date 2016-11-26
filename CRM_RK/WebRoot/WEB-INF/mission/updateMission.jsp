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
	<script src="<%=path%>/js/TableValidate.js"></script>
	<script src="<%=path%>/js/myjq.js"></script>
	
	<script>
		//确认是否删除
		function confirm_delete(){
			if (!confirm("确认删除？")) {
		        window.event.returnValue = false;
		    }else{
				var idid=$('#mid').text();
				window.location.href="<%=path %>/crm/missionAction_deleteTheMission.action?mission.id="+idid;
				alert("删除成功");
			}				
		}
		//权限等级为3,channel不能修改
		$(function(){
			if("${applicationScope.level}"==3){
				$('#channelid').attr("disabled","desabled");
			}
		});
	</script>
  </head>
  
  <body>
    <div id="content">
		<div id="content-body">
		<!-- 导航条  -->
		<div class="demo">
			<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li style="background-color:#317eb4"><a href="javascript:void(0)">任务详情</a></li>
        		</ul>
    		</div>
    		<div class="horizontal-nav full-width horizontalNav-notprocessed">
        		<ul>
           		  <li><a href="<%=path %>/crm/missionAction_findAllmission.action">返回列表</a></li>
           		  <li onclick="confirm_delete()"><a href="javascript:void(0)">删除</a></li>
           		  <li id="updatemission"><a href="javascript:void(0)">更新进度</a></li>
        		</ul>
    		</div>
		</div>
		<!-- 数据表格  start-->
			<div id="tableDiv">
				<table width="100%" cellpadding="10" id="table">
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">任务基本信息</td>
					</tr>
					<tr>
						<td align="right" width="25%">任务编号:&nbsp;</td><td id="mid" width="25%">${mission.id}</td>
						<td align="right" width="25%">任务标题:&nbsp;</td><td width="25%">${mission.title}</td>
					</tr>
					<tr>
						<td align="right">负责渠道:&nbsp;</td><td id="t1">${mission.channel.cname}</td>
						<td align="right">任务等级:&nbsp;</td><td id="t2">${mission.level}</td>
					</tr>
					<tr>
						<td align="right">开始时间:&nbsp;</td><td>${mission.startDate}</td>
						<td align="right">截止日期:&nbsp;</td><td>${mission.endDate}</td>
					</tr>
					<tr>
						<td align="right">任务类型:&nbsp;</td><td id="t3">${mission.type}</td>
						<td align="right">执行时间:&nbsp;</td><td id="time1">${mission.repeatType},${mission.repeatTime}</td>
					</tr>
					<tr>
						<td align="right">内容:&nbsp;</td>
						<td colspan="3" id="t4">${mission.context}</td>
					</tr>
					<tr bgcolor="#40E0D0">
						<td colspan="4" width="100%">任务进度</td>
					</tr>
					<tr>
						<td align="right">负责销售员:&nbsp;</td><td id="t5">${mission.salesman.sname}</td>
						<td align="right">任务状态:&nbsp;</td><td id="t6">${mission.ststus}</td>
					</tr>
					<tr>
						<td align="right">最后更新时间:&nbsp;</td><td>${mission.updatetime}</td>
						<td align="right">&nbsp;</td><td></td>
					</tr>
					<tr>
						<td align="right">任务日志:&nbsp;</td>
						<td colspan="3" id="t7">${mission.result}</td>
					</tr>
				</table>
			</div>
			<!-- 数据表格  end-->
		</div>
	</div>
	
	<!--弹出窗口、 修改任务界面  start-->
	<div id="goodcover"></div>
	<div id="code">
  		<div class="close1"><a href="javascript:void(0)" id="closebt"><img src="images/close.gif"></a></div>
 		<div class="goodtxt">
 		<s:form theme="simple" id="updatemissionform" action="missionAction_updateMission" method="post" namespace="/crm">
 			<input type="hidden" name="mission.id" value="${mission.id}"/>
    		<div id="tabs" class="tabs">
				<nav>
					<ul>
						<li><a href="#section-1" ><span>任务信息</span></a></li>
						<li><a href="#section-2" ><span>跟进信息</span></a></li>
					</ul>
				</nav>
				<div class="content">
					<section id="section-1">
						<table width=100% align="center" cellpadding="5">
						<tr>
						<td width="40%" align="right">*主题:</td>
						<td width="60%"><input type="text" style="width:200px;height:30px;" value="${mission.title}" id="title1" name="mission.title"/></td>
						</tr>
						<tr>
						<td align="right">*负责渠道:</td>
						<td><select style="width:200px;height:30px;" id="sel1" name="channel.cname">
							<s:iterator value="channels" id="cls">
							<option value='<s:property value="#cls.cname"/>'><s:property value="#cls.cname"/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">任务等级:</td>
						<td><select style="width:200px;height:30px;" id="sel2" name="mission.level">
							<option value="">--请选择--</option>
							<option value="最高">最高</option>
							<option value="高">高</option>
							<option value="中">中</option>
							<option value="低">低</option>
							<option value="最低">最低</option>
  						</select></td>
						</tr>
						<tr>
						<td align='right'>开始时间</td>
						<td><input type='date' style='width:200px;height:30px;' value='${mission.startDate}' id="de1" name='mission.startDate'/></td>
						</tr>
						<tr>
						<td align='right'>结束时间</td>
						<td><input type='date' style='width:200px;height:30px;' value='${mission.endDate}' id="de2" name='mission.endDate'/></td>
						</tr>
						<tr id="tr1">
						<td align="right">*任务类型:</td>
						<td><select style="width:200px;height:30px;" id="sel3" name="mission.type">
							<option value="">--请选择--</option>
							<option value="单次任务">单次任务</option>
							<option value="重复任务">重复任务</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">*任务内容</td>
						<td><textarea name="mission.context" id="tt1" style="width:300px;height:100px;resize:none;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip2" colspan="2"></td></tr>
						</table>
					</section>
					<section id="section-2">
						<table width=100% align="center" cellpadding="5">
						<tr>
						<td width="40%" align="right">负责销售员:</td>
						<td width="60%"><select style="width:200px;height:30px;" id="sel4" name="salesman.sname">
							<option value="">--请选择--</option>
							<s:iterator value="salesmans" id="sm1">
							<option value='<s:property value="#sm1.sname"/>'><s:property value="#sm1.sname"/></option>
							</s:iterator>
  						</select></td>
						</tr>
						<tr>
						<td align="right">任务状态:</td>
						<td><select style="width:200px;height:30px;" id="sel5" name="mission.ststus">
							<option value="">--请选择--</option>
							<option value="等待分配">等待分配</option>
							<option value="进行中">进行中</option>
							<option value="任务失败">任务失败</option>
							<option value="已完成">已完成</option>
  						</select></td>
						</tr>
						<tr>
						<td align="right">任务日志:</td>
						<td><textarea id="tt2" name="mission.result" style="resize:none;width:300px;height:150px;"></textarea></td>
						</tr>
						<tr><td align="center" id="tip1" colspan="2"></td></tr>
						</table>
					</section>
				</div><!-- /content -->
			</div><!-- /tabs -->
			<h4>*为必填内容</h4>
			<input id="updatemissionb" type="button" value="保存修改"/>
			</s:form>
  		</div>
	</div>
	<!--弹出窗口、 修改任务界面  end-->
	
<script>
new CBPFWTabs( document.getElementById( 'tabs' ) );
$(function() {
	//如果权限等级3，渠道商不能设置
	if("${applicationScope.level}"==3){
		$('#sel1').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
	}
	//如果权限等级2，任务信息不能修改
	if("${applicationScope.level}"==2){
		$('#title1').attr("readonly","readonly");
		$('#de1').attr("readonly","readonly");
		$('#de2').attr("readonly","readonly");
		$('#tt1').attr("readonly","readonly");
		//$('#check1').empty();
		
		$('#sel1').attr("disabled","desabled");
		$('#sel2').attr("disabled","desabled");
		$('#sel3').attr("disabled","desabled");
		$('#sel4').attr("disabled","desabled");
		$('#tabs').append("<input type='hidden' id='hid1' name='channel.cname'/>");
		$('#hid1').val("${applicationScope.user.channel.cname}");
		$('#tabs').append("<input type='hidden' id='hid2' name='salesman.sname'/>");
		$('#hid2').val("${applicationScope.user.sname}");
		$('#tabs').append("<input type='hidden' id='hid3' name='mission.level'/>");
		$('#hid3').val($('#t2').text());
		$('#tabs').append("<input type='hidden' id='hid4' name='mission.type'/>");
		$('#hid4').val($('#t3').text());
	}
	
    $('#updatemission').click(function() {
    	$('#sel1').val($('#t1').text());
    	$('#sel2').val($('#t2').text());
    	$('#sel3').val($('#t3').text());
    	$('#tt1').val($('#t4').text());
    	$('#sel4').val($('#t5').text());
    	$('#sel5').val($('#t6').text());
    	$('#tt2').val($('#t7').text());
    	
    	if($('#t3').text()=="重复任务"){
    		$('#tr2').remove();
    		$('#tr3').remove();
    		$('#tr4').remove();
    		var time2=$('#time1').text();
    		time2=time2.replace(/\s+/g,"");
    		var strs= new Array();
    		strs=time2.split(",");
    		if(strs[0]=="每周"){
    			$('#tr1').after("<tr id='tr2'><td align='right'>重复方式</td><td><select style='width:200px;height:30px;' id='sel6' name='mission.repeatType'>"+
    					"<option value=''>--请选择--</option><option value='每周'>每周</option><option value='每月'>每月</option></select></td></tr>"+
    					"<tr id='tr3'><td id='check1' colspan='2' align='center'><input type='checkbox' id='cb1' name='mission.repeatTime' value='星期一'/>星期一"+
    					"<input type='checkbox' id='cb2' name='mission.repeatTime' value='星期二'/>星期二"+
    					"<input type='checkbox' id='cb3' name='mission.repeatTime' value='星期三'/>星期三"+
    					"<input type='checkbox' id='cb4' name='mission.repeatTime' value='星期四'/>星期四"+
    					"<input type='checkbox' id='cb5' name='mission.repeatTime' value='星期五'/>星期五"+
    					"<input type='checkbox' id='cb6' name='mission.repeatTime' value='星期六'/>星期六"+
    					"<input type='checkbox' id='cb7' name='mission.repeatTime' value='星期日'/>星期日</td></tr>");
    			$('#sel6').val(strs[0]);
    			for (var i=1;i<strs.length ;i++ ){
    				if(strs[i]==$('#cb1').val()){
    					$('#cb1').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb2').val()){
    					$('#cb2').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb3').val()){
    					$('#cb3').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb4').val()){
    					$('#cb4').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb5').val()){
    					$('#cb5').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb6').val()){
    					$('#cb6').attr("checked","checked");
    				}
    				if(strs[i]==$('#cb7').val()){
    					$('#cb7').attr("checked","checked");
    				}
    			}
    		
    		}
    		if(strs[0]=="每月"){
    			$('#tr1').after("<tr id='tr2'><td align='right'>重复方式</td><td><select style='width:200px;height:30px;' id='sel6' name='mission.repeatType'>"+
						"<option value=''>--请选择--</option><option value='每周'>每周</option><option value='每月'>每月</option></select></td></tr>"+
    					"<tr id='tr4'><td colspan='2' align='center'><input type='checkbox' id='c1' name='mission.repeatTime' value='一月'/>一月"+
    					"<input type='checkbox' id='c2' name='mission.repeatTime' value='二月'/>二月"+
    					"<input type='checkbox' id='c3' name='mission.repeatTime' value='三月'/>三月"+
    					"<input type='checkbox' id='c4' name='mission.repeatTime' value='四月'/>四月"+
    					"<input type='checkbox' id='c5' name='mission.repeatTime' value='五月'/>五月"+
    					"<input type='checkbox' id='c6' name='mission.repeatTime' value='六月'/>六月"+
    					"<input type='checkbox' id='c7' name='mission.repeatTime' value='七月'/>七月"+
    					"<input type='checkbox' id='c8' name='mission.repeatTime' value='八月'/>八月"+
    					"<input type='checkbox' id='c9' name='mission.repeatTime' value='九月'/>九月"+
    					"<input type='checkbox' id='c10' name='mission.repeatTime' value='十月'/>十月"+
    					"<input type='checkbox' id='c11' name='mission.repeatTime' value='十一月'/>十一月"+
    					"<input type='checkbox' id='c12' name='mission.repeatTime' value='十二月'/>十二月</td></tr>");
    			$('#sel6').val(strs[0]);
    			for (var i=1;i<strs.length ;i++ ){
    				//alert(strs[i]);
    				if(strs[i]==$('#c1').val()){
    					$('#c1').attr("checked","checked");
    				}
    				if(strs[i]==$('#c2').val()){
    					$('#c2').attr("checked","checked");
    				}
    				if(strs[i]==$('#c3').val()){
    					$('#c3').attr("checked","checked");
    				}
    				if(strs[i]==$('#c4').val()){
    					$('#c4').attr("checked","checked");
    				}
    				if(strs[i]==$('#c5').val()){
    					$('#c5').attr("checked","checked");
    				}
    				if(strs[i]==$('#c6').val()){
    					$('#c6').attr("checked","checked");
    				}
    				if(strs[i]==$('#c7').val()){
    					$('#c7').attr("checked","checked");
    				}
    				if(strs[i]==$('#c8').val()){
    					$('#c8').attr("checked","checked");
    				}
    				if(strs[i]==$('#c9').val()){
    					$('#c9').attr("checked","checked");
    				}
    				if(strs[i]==$('#c10').val()){
    					$('#c10').attr("checked","checked");
    				}
    				if(strs[i]==$('#c11').val()){
    					$('#c11').attr("checked","checked");
    				}
    				if(strs[i]==$('#c12').val()){
    					$('#c12').attr("checked","checked");
    				}
    			}
    		
    		}
    	}
    	
        $('#code').center();
        $('#goodcover').show();
        $('#code').fadeIn();
    });
    
    $('#sel1').change(function(){
    	$("#sel4").empty();//清空  
	    var ccid = document.getElementById("sel1").value;  
	    var url = "crm/chanceAction_findSalesman.action?channel.cname=" + ccid;  
	    $.ajax( {  
	        type : "POST",  
	        url : url,  
	        data : {},  
	        dataType : "JSON",  
	        success : function(jsonStr) {
	        	$("#sel4").append("<option value=''>--请选择--</option>");
	        	$.each(jsonStr,function(i,date){  
                    var _tr = $("<option value='"+date.sname+"'>"+date.sname+"</option>");  
                    $("#sel4").append(_tr);  
                }); 
	        }  
	    });  
    });
    
    $('#sel3').change(function(){
		var type=$('#sel3').val();
		if(type=="单次任务"){
			$('#tr2').remove();
			$('#tr3').remove();
			$('#tr4').remove();
		}
		if(type=="重复任务"){
			$('#tr1').after(
					"<tr id='tr2'><td align='right'>重复方式</td><td><select style='width:200px;height:30px;' id='sel6' name='mission.repeatType'>"+
					"<option value=''>--请选择--</option><option value='每周'>每周</option><option value='每月'>每月</option></select></td></tr>"
			);
		}
	});
	
	$(document).on("change", "#sel6", function(){ 
		var type=$('#sel6').val();
		if(type=="每周"){
			$('#tr4').remove();
			$('#tr2').after(
				"<tr id='tr3'><td colspan='2' align='center'><input type='checkbox' name='mission.repeatTime' value='星期一'/>星期一"+
				"<input type='checkbox' name='mission.repeatTime' value='星期二'/>星期二"+
				"<input type='checkbox' name='mission.repeatTime' value='星期三'/>星期三"+
				"<input type='checkbox' name='mission.repeatTime' value='星期四'/>星期四"+
				"<input type='checkbox' name='mission.repeatTime' value='星期五'/>星期五"+
				"<input type='checkbox' name='mission.repeatTime' value='星期六'/>星期六"+
				"<input type='checkbox' name='mission.repeatTime' value='星期日'/>星期日</td></tr>"
			);
		}
		if(type=="每月"){
			$('#tr3').remove();
			$('#tr2').after(
					"<tr id='tr4'><td colspan='2' align='center'><input type='checkbox' name='mission.repeatTime' value='一月'/>一月"+
					"<input type='checkbox' name='mission.repeatTime' value='二月'/>二月"+
					"<input type='checkbox' name='mission.repeatTime' value='三月'/>三月"+
					"<input type='checkbox' name='mission.repeatTime' value='四月'/>四月"+
					"<input type='checkbox' name='mission.repeatTime' value='五月'/>五月"+
					"<input type='checkbox' name='mission.repeatTime' value='六月'/>六月"+
					"<input type='checkbox' name='mission.repeatTime' value='七月'/>七月"+
					"<input type='checkbox' name='mission.repeatTime' value='八月'/>八月"+
					"<input type='checkbox' name='mission.repeatTime' value='九月'/>九月"+
					"<input type='checkbox' name='mission.repeatTime' value='十月'/>十月"+
					"<input type='checkbox' name='mission.repeatTime' value='十一月'/>十一月"+
					"<input type='checkbox' name='mission.repeatTime' value='十二月'/>十二月</td></tr>"
			);
		}
	}); 
   
    $('#closebt').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
	$('#goodcover').click(function() {
        $('#code').hide();
        $('#goodcover').hide();
    });
	
});
</script>
	
  </body>
</html>
