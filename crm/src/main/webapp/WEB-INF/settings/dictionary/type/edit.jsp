<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script src="/crm/jquery/layer/layer.js"></script>
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>修改字典类型</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="updateDicType" type="button" class="btn btn-primary">更新</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" id="typeUpdateForm">
					
		<div class="form-group">
			<label for="create-code" class="col-sm-2 control-label">编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" readonly="readonly" id="code" name="code" style="width: 200%;" placeholder="编码作为主键，不能是中文">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-name" class="col-sm-2 control-label">名称</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="name" name="name" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label"></label>
			<div class="col-sm-10" style="width: 300px;">
				<textarea class="form-control" rows="3" id="describe" name="description" style="width: 200%;"></textarea>
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
<script>
	//查询单个字典类型信息
	$(function () {
		//更新-查询
		$.ajax({
			url: "/crm/settings/dictionary/selectTypeById/"+'${id}',
			type: "GET",
			dataType: 'json',
			success: function (result) {
				let dicType = result.t;
				if(result.ok){
					$("#code").val(dicType.code)
					$("#name").val(dicType.name)
					$("#describe").text(dicType.description)
				}
			}
		});
	})

	//更新的函数
	$("#updateDicType").click(function () {
		if($("#code").val() != ''){
			$.ajax({
			    url: "/crm/settings/dictionary/updateType",
			    type: "PUT",
			    data: $("#typeUpdateForm").serialize(),
			    dataType: "json",
			    success: function (result) {
			       if(result.ok){
					   //window.location.href='/crm/toView/settings/dictionary/type/index';
					   layer.alert(result.message, {icon: 6});
				   }else {
					   layer.alert(result.message, {icon: 5});
				   }
			    }
			});
		}else {
			layer.alert("编码不可以为空", {icon: 5});
		}
	})

</script>
</html>