/**
 * 各种表格的输入验证
 */
$(function(){
	var numfilter=/^[0-9]*$/; //纯数字
	var pricefilter=/^\d{0,8}\.{0,1}(\d{1,2})?$/;//价钱
	var postcodefilter=/^[a-zA-Z0-9 ]{3,12}$/;//邮编
	var emailfilter=/^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;//电子邮箱
	
	//添加订单
	$('#addordersb').on("click",function(){
		if($('#cname').val()==""||$('#cname').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if($('#salesmanid').val()==""||$('#salesmanid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择负责销售员</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if($('#pname').val()==""||$('#pname').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择商品名称</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if(!numfilter.test($('#num').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入成交数量</b></font>");
			return false;
		}else{$('#tip2').html("");}
		if(!pricefilter.test($('#price').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入价格</b></font>");
			return false;
		}else{$('#tip2').html("");}
		if($('#otitle').val()==""||$('#otitle').val()==null){
			$('#tip1').html("<font color='red'><b>×标题不能为空</b></font>");
			return false;
		}else{
			$.ajax({
				type: "POST",
				url: "crm/orderAction_validateTitle.action",
				data: {title:$('#otitle').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×订单标题已存在</b></font>");
						return 
					}else{
						$('#tip2').text("");
						$('#tip1').text("");
						$('#addordersform').submit();
					}
				}
			});
		}
	});
	
	//编辑订单
	$('#updateordersb').on("click",function(){
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if($('#salesmanid').val()==""||$('#salesmanid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择负责销售员</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if($('#sel2').val()==""||$('#sel2').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择商品名称</b></font>");
			return false;
		}else{$('#tip1').html("");}
		if(!numfilter.test($('#num2').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入成交数量</b></font>");
			return false;
		}else{$('#tip2').html("");}
		if(!pricefilter.test($('#price2').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入价格</b></font>");
			return false;
		}else{$('#tip2').html("");}
		if($('#otitle').val()==""||$('#otitle').val()==null){
			$('#tip1').html("<font color='red'><b>×标题不能为空</b></font>");
			return false;
		}else{
			$.ajax({
				type: "POST",
				url: "crm/orderAction_validateTitle2.action",
				data: {ordersid:$('#ordersid').val(),title:$('#otitle').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×订单标题已存在</b></font>");
						return 
					}else{
						$('#tip2').text("");
						$('#tip1').text("");
						$('#updateordersform').submit();
					}
				}
			});
		}
	});
	
	//添加渠道商
	$('#addchannelb').on("click",function(){
		if($('#cname').val()==null||$('#cname').val()==""){
			$('#tip1').html("<font color='red'><b>×渠道商名称不能为空</b></font>");
			return false;
		}else{
			if($('#cname').val().length>30){
				$('#tip1').html("<font color='red'><b>×渠道商名称长度不能大于30个字节</b></font>");
				return false;
			}else{
				$('#tip1').html("");
			}
		}
		
		if(!postcodefilter.test($('#postcode').val())){
			$('#tip1').html("<font color='red'><b>×邮编格式不正确</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		
		if($('#citys').val()==""||$('#citys').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择所在城市</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		
		if($('#levels').val()==""||$('#levels').val()==null){
			$('#tip1').html("<font color='red'><b>×渠道等级</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		$.ajax({
			type: "POST",
			url: "crm/channelAction_validateInput1.action",
			data: {cname:$('#cname').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×渠道名称已存在</b></font>");
					return 
				}else{
					$('#tip1').html("");
					$('#addchannelform').submit();
				}
			}
		});
	});
	
	//编辑渠道商
	$('#updatechannelb').on("click",function(){
		if($('#cname').val()==null||$('#cname').val()==""){
			$('#tip1').html("<font color='red'><b>×渠道商名称不能为空</b></font>");
			return false;
		}else{
			if($('#cname').val().length>30){
				$('#tip1').html("<font color='red'><b>×渠道商名称长度不能大于30个字节</b></font>");
				return false;
			}else{
				$('#tip1').html("");
			}
		}
		
		if(!postcodefilter.test($('#postcode').val())){
			$('#tip1').html("<font color='red'><b>×邮编格式不正确</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		
		if($('#citys').val()==""||$('#citys').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择所在城市</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		
		if($('#level').val()==""||$('#level').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择渠道等级</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		$.ajax({
			type: "POST",
			url: "crm/channelAction_validateInput2.action",
			data: {channelid:$('#channelid').val(),cname:$('#cname').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×渠道名称已存在</b></font>");
					return 
				}else{
					$('#tip1').html("");
					$('#updatechannelform').submit();
				}
			}
		});
	});
	
	//添加销售员
	$('#addsalesmanb').on("click",function(){
		if($('#cname').val().length<=0||$('#cname').val().length>30){
			$('#tip1').html("<font color='red'><b>×姓名不能为空(1~30个字节)</b></font>");
			return false;
		}
		if($('#channels').val()==""||$('#channels').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择所属渠道</b></font>");
			return false;
		}
		if(emailfilter.test($('#email').val())){
			$.ajax({
				type: "POST",
				url: "crm/loginRegisterAction_validateRegister3.action",
				data: {un:$('#email').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×邮箱已被注册</b></font>");
					}else{
						$.ajax({
							type: "POST",
							url: "crm/salesmanAction_validateInput1.action",
							data: {sname:$('#cname').val()},
							dataType: 'text',
							success: function(result) {
								if (result=="1") {
									$("#tip1").html("<font color='red'><b>×该姓名已存在</b></font>");
								}else{
									$('#tip1').html("");
									$('#addsalesmanform').submit();
								}
							}
						});
					}
				}
			});
		}else{
			$('#tip1').html("<font color='red'><b>×电子邮箱格式不对</b></font>");
			return false;
		}
	});
	
	//编辑销售员信息
	$('#updatesalesmanb').on("click",function(){
		if($('#cname').val().length<=0||$('#cname').val().length>30){
			$('#tip1').html("<font color='red'><b>×姓名不能为空(1~30个字节)</b></font>");
			return false;
		}
		if($('#schannel').val()==""||$('#schannel').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择所属渠道</b></font>");
			return false;
		}
		if(emailfilter.test($('#email').val())){
			$.ajax({
				type: "POST",
				url: "crm/loginRegisterAction_validateRegister4.action",
				data: {upid:$('#upid').val(),un:$('#email').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×邮箱已被注册</b></font>");
					}else{
						$.ajax({
							type: "POST",
							url: "crm/salesmanAction_validateInput2.action",
							data: {sname:$('#cname').val(),salesmanid:$('#salesmanid').val()},
							dataType: 'text',
							success: function(result) {
								if (result=="1") {
									$("#tip1").html("<font color='red'><b>×该姓名已存在</b></font>");
								}else{
									$('#tip1').html("");
									$('#updatesalesmanform').submit();
								}
							}
						});
					}
				}
			});
		}else{
			$('#tip1').html("<font color='red'><b>×电子邮箱格式不对</b></font>");
			return false;
		}
	});
	
	//新增任务
	$('#addmissionb').on("click",function(){
		if($('#title1').val().length<=0||$('#title1').val().length>100){
			$('#tip1').html("<font color='red'><b>×主题不能为空(1~100个字节)</b></font>");
			return false;
		}
		if($('#cname').val()==""||$('#cname').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择负责渠道</b></font>");
			return false;
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择任务类型</b></font>");
			return false;
		}
		if($('#context').val().length<=0||$('#context').val().length>200){
			$('#tip1').html("<font color='red'><b>×任务内容不能为空(1~200个字节)</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#addmissionform').submit();
	});
	
	//编辑任务
	$('#updatemissionb').on("click",function(){
		if($('#title1').val().length<=0||$('#title1').val().length>100){
			$('#tip2').html("<font color='red'><b>×主题不能为空(1~100个字节)</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip2').html("<font color='red'><b>×请选择负责渠道</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#sel3').val()==""||$('#sel3').val()==null){
			$('#tip2').html("<font color='red'><b>×请选择任务类型</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#tt1').val().length<=0||$('#tt1').val().length>200){
			$('#tip2').html("<font color='red'><b>×任务内容不能为空(1~200个字节)</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#tt2').val().length<=0||$('#tt2').val().length>200){
			$('#tip1').html("<font color='red'><b>×任务日志长度不符(1~200个字节)</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		$('#tip2').html("");
		$('#tip1').html("");
		$('#updatemissionform').submit();
	});
	
	//添加销售机会
	$('#addchanceb').on('click',function(){
		if($('#chancename').val().length<=0||$('#chancename').val()>50){
			$('#tip1').html("<font color='red'><b>×机会名称不能为空(1~50个字节)</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#cpname').val()==""||$('#cpname').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户名称</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#channelid').val()==""||$('#channelid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择渠道名称</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#salesmanid').val()==""||$('#salesmanid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择销售员</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#cdes').val().length>100){
			$('#tip1').html("<font color='red'><b>×描述内容长度不符(1~100字节)</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#pname').val()==""||$('#pname').val()==null){
			$('#tip2').html("<font color='red'><b>×请选意向商品</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if(!numfilter.test($('#cnum').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入需求数量</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#remark').val().length>100){
			$('#tip2').html("<font color='red'><b>×备注长度不符(1~100字节)</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#chancename').val()==""||$('#chancename').val()==null){
			$("#tip1").html("<font color='red'><b>×机会名称不能为空</b></font>");
			return false;
		}else{
			$.ajax({
				type: "POST",
				url: "crm/chanceAction_validateInput1.action",
				data: {chancename:$('#chancename').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×机会名称已存在</b></font>");
					}else{
						$('#tip1').html("");
						$('#tip2').html("");
						$('#addchanceform').submit();
					}
				}
			});
		}
	});
	
	//编辑销售机会信息
	$('#updatechanceb').on('click',function(){
		if($('#chancename').val().length<=0||$('#chancename').val()>50){
			$('#tip1').html("<font color='red'><b>×机会名称不能为空(1~50个字节)</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户名称</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#channelid').val()==""||$('#channelid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择渠道名称</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#salesmanid').val()==""||$('#salesmanid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择销售员</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#tt1').val().length>100){
			$('#tip1').html("<font color='red'><b>×描述内容长度不符(1~100字节)</b></font>");
			return false;
		}else{
			$('#tip1').html("");
		}
		if($('#sel3').val()==""||$('#sel3').val()==null){
			$('#tip2').html("<font color='red'><b>×请选意向商品</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if(!numfilter.test($('#cnum').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入需求数量</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#tt2').val().length>100){
			$('#tip2').html("<font color='red'><b>×备注长度不符(1~100字节)</b></font>");
			return false;
		}else{
			$('#tip2').html("");
		}
		if($('#chancename').val()==""||$('#chancename').val()==null){
			$("#tip1").html("<font color='red'><b>×机会名称不能为空</b></font>");
			return false;
		}else{
			$.ajax({
				type: "POST",
				url: "crm/chanceAction_validateInput2.action",
				data: {chancename:$('#chancename').val(),chanceid:$('#chanceid').val()},
				dataType: 'text',
				success: function(result) {
					if (result=="1") {
						$("#tip1").html("<font color='red'><b>×机会名称已存在</b></font>");
					}else{
						$('#tip1').html("");
						$('#tip2').html("");
						$('#updatechanceform').submit();
					}
				}
			});
		}
	});
	
	//邮件内容
	$('#updatemessageb').on('click',function(){
		if($('#title').val().length<=0||$('#title').val().length>50){
			$('#tip1').html("<font color='red'><b>×标题长度不符要求(1~50字节)</b></font>");
			return false;
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择类型</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#updatemessageform').submit();
	});
	
	//客户服务，管理员
	$('#addserviceb').on('click',function(){
		if($('#title').val().length<=0||$('#title').val().length>100){
			$('#tip1').html("<font color='red'><b>×标题长度不符要求(1~100字节)</b></font>");
			return false;
		}
		if($('#customerPid').val()==""||$('#customerPid').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择服务对象</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#addserviceform').submit();
	});
	
	//编辑服务信息，管理员
	$('#updateserviceb').on('click',function(){
		if($('#tt1').val().length<=0||$('#tt1').val().length>100){
			$('#tip1').html("<font color='red'><b>×标题长度不符要求(1~100字节)</b></font>");
			return false;
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择服务对象</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#updateserviceform').submit();
	});
	
	//客户服务，客户
	$('#addserviceb2').on('click',function(){
		if($('#title2').val().length<=0||$('#title2').val().length>100){
			$('#tip1').html("<font color='red'><b>×标题长度不符要求(1~100字节)</b></font>");
			return false;
		}
		if($('#sel2').val()==""||$('#sel2').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择服务类型</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#addserviceform2').submit();
	});
	
	//编辑服务信息，客户
	$('#updateserviceb2').on('click',function(){
		if($('#sel3').val()==""||$('#sel3').val()==null){
			$('#tip1').html("<font color='red'><b>×请对本次服务进行评价</b></font>");
			return false;
		}
		$('#tip1').html("");
		$('#updateserviceform2').submit();
	});
	
	//添加客户
	$('#addcustomerb').on('click',function(){
		if($('#cname').val().length<=0||$('#cname').val().length>20){
			$('#tip1').html("<font color='red'><b>×客户名称长度不符要求(1~20字节)</b></font>");
			return false;
		}
		if($('#d1').val()==""||$('#d1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择获取时间</b></font>");
			return false;
		}
		if($('#d2').val()==""||$('#d2').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择生日时间</b></font>");
			return false;
		}
		if($('#cpc').val()==""||$('#cpc').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户所在城市</b></font>");
			return false;
		}
		if(!numfilter.test($('#phonenum').val())){
			$('#tip1').html("<font color='red'><b>×联系方式输入格式不正确</b></font>");
			return false;
		}
		if(!emailfilter.test($('#email').val())){
			$('#tip1').html("<font color='red'><b>×邮箱地址格式不正确</b></font>");
			return false;
		}
		$('#tip1').html("");
		
		if(!numfilter.test($('#company_num').val())){
			$('#tip2').html("<font color='red'><b>×公司座机输入格式不正确</b></font>");
			return false;
		}
		$('#tip2').html("");
		
		$.ajax({
			type: "POST",
			url: "crm/customerPAction_validateInput.action",
			data: {em:$('#email').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×邮箱地址已存在</b></font>");
				}else{
					$.ajax({
						type: "POST",
						url: "crm/customerPAction_validateInput3.action",
						data: {cname:$('#cname').val()},
						dataType: 'text',
						success: function(result) {
							if(result=="1"){
								$("#tip1").html("<font color='red'><b>×客户姓名已存在</b></font>");
							}else{
								$("#tip1").html("");
								$('#addcustomerform').submit();
							}
						}
					});
				}
			}
		});
	});
	
	//编辑客户信息
	$('#updatecustomerb').on('click',function(){
		if($('#cname').val().length<=0||$('#cname').val().length>20){
			$('#tip1').html("<font color='red'><b>×客户名称长度不符要求(1~20字节)</b></font>");
			return false;
		}
		if($('#d1').val()==""||$('#d1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择获取时间</b></font>");
			return false;
		}
		if($('#d2').val()==""||$('#d2').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择生日时间</b></font>");
			return false;
		}
		if($('#cpc').val()==""||$('#cpc').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择客户所在城市</b></font>");
			return false;
		}
		if(!numfilter.test($('#phonenum').val())){
			$('#tip1').html("<font color='red'><b>×联系方式输入格式不正确</b></font>");
			return false;
		}
		if(!emailfilter.test($('#email').val())){
			$('#tip1').html("<font color='red'><b>×邮箱地址格式不正确</b></font>");
			return false;
		}
		$('#tip1').html("");
		
		if(!numfilter.test($('#company_num').val())){
			$('#tip2').html("<font color='red'><b>×公司座机输入格式不正确</b></font>");
			return false;
		}
		$('#tip2').html("");
		
		$.ajax({
			type: "POST",
			url: "crm/customerPAction_validateInput2.action",
			data: {em:$('#email').val(),uid:$('#uid').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×邮箱地址已存在</b></font>");
				}else{
					$.ajax({
						type: "POST",
						url: "crm/customerPAction_validateInput4.action",
						data: {cname:$('#cname').val(),cid:$('#cid').val()},
						dataType: 'text',
						success: function(result) {
							if(result=="1"){
								$("#tip1").html("<font color='red'><b>×客户姓名已存在</b></font>");
							}else{
								$("#tip1").html("");
								$('#updatecustomerform').submit();
							}
						}
					});
				}
			}
		});
	});
	
	//添加商品
	$('#addproductb').on('click',function(){
		if($('#pname').val().length<=0||$('#pname').val().length>50){
			$('#tip1').html("<font color='red'><b>×商品名称不能为空(1~50)</b></font>");
			return false;
		}
		if($('#sel1').val()==""||$('#sel1').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择商品类型</b></font>");
			return false;
		}
		$('#tip1').html("");
		
		if(!pricefilter.test($('#tprice').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入销售单价</b></font>");
			return false;
		}
		if(!pricefilter.test($('#tcost').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入制造成本</b></font>");
			return false;
		}
		if($('#tt1').val().length>100){
			$('#tip2').html("<font color='red'><b>×商品简介长度不符要求(1~100字节)</b></font>");
			return false;
		}
		$('#tip2').html("");
		
		$.ajax({
			type: "POST",
			url: "crm/productAction_validateInput.action",
			data: {pn:$('#pname').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×商品名称已存在</b></font>");
				}else{
					$("#tip1").html("");
					$('#addproductform').submit();
				}
			}
		});
	});
	
	//编辑商品信息
	$('#updateproductb').on('click',function(){
		if($('#pname2').val().length<=0||$('#pname2').val().length>50){
			$('#tip1').html("<font color='red'><b>×商品名称长度不符要求(1~50)</b></font>");
			return false;
		}
		if($('#ptype2').val()==""||$('#ptype2').val()==null){
			$('#tip1').html("<font color='red'><b>×请选择商品类型</b></font>");
			return false;
		}
		$('#tip1').html("");
		
		if(!pricefilter.test($('#pprice2').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入销售单价</b></font>");
			return false;
		}
		if(!pricefilter.test($('#pcosting2').val())){
			$('#tip2').html("<font color='red'><b>×请正确输入制造成本</b></font>");
			return false;
		}
		if($('#pde').val().length>100){
			$('#tip2').html("<font color='red'><b>×商品简介长度不符要求(1~100字节)</b></font>");
			return false;
		}
		$('#tip2').html("");
		
		$.ajax({
			type: "POST",
			url: "crm/productAction_validateInput2.action",
			data: {pn:$('#pname2').val(),pid:$('#pid2').val()},
			dataType: 'text',
			success: function(result) {
				if (result=="1") {
					$("#tip1").html("<font color='red'><b>×商品名称已存在</b></font>");
				}else{
					$("#tip1").html("");
					$('#updateproductform').submit();
				}
			}
		});
	});
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
});