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
		<h3>修改字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="updateDicValue" type="button" class="btn btn-primary">更新</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" id="valueUpdateForm">
					
		<div class="form-group">
			<label for="edit-dicTypeCode" class="col-sm-2 control-label">字典类型编码</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="typeCode" id="edit-dicTypeCode" style="width: 200%;" readonly>
				<input type="hidden" name="id" id="edit-dicValue-id">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="value" id="edit-dicValue" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="text" id="edit-text" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="orderNo" id="edit-orderNo" style="width: 200%;">
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
			url: "/crm/settings/dictionary/selectValueById/"+'${id}',
			type: "GET",
			dataType: 'json',
			success: function (result) {
				let dicValue = result.t;
				if(result.ok){
					$("#edit-dicTypeCode").val(dicValue.typeCode)
					$("#edit-dicValue").val(dicValue.value)
					$("#edit-text").val(dicValue.text)
					$("#edit-orderNo").val(dicValue.orderNo)
					$("#edit-dicValue-id").val(dicValue.id)
				}
			}
		});
	})

	//更新的函数
	$("#updateDicValue").click(function () {
		if($("#edit-dicValue").val() != ''){
			$.ajax({
				url: "/crm/settings/dictionary/updateValue",
				type: "PUT",
				data: $("#valueUpdateForm").serialize(),
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
			layer.alert("字典值不可以为空", {icon: 5});
		}
	})
</script>
</html>