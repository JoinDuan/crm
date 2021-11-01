<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		<h3>新增字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button id="saveBtn" type="button" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
			<button type="button" class="btn btn-default" onclick="window.location.href='/crm/toView/settings/dictionary/value/index'">返回</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" id="create-dicValue-form">
					
		<div class="form-group">
			<label for="create-dicTypeCode" class="col-sm-2 control-label">字典类型编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-dicTypeCode" name="typeCode" style="width: 200%;">
				  <option></option>
				  <c:forEach var="dictypeele" items="${dictype}">
					  <option value="${dictypeele.code}">${dictypeele.code}</option>
				  </c:forEach>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="value" id="create-dicValue" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="text" id="create-text" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="orderNo" id="create-orderNo" style="width: 200%;">
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
<script>
	//新增函数
	$("#saveBtn").click(function () {
		if($("#create-dicTypeCode").val() != ""){
			$.ajax({
				url: "/crm/settings/dictionary/saveValue",
				type: "post",
				data: $("#create-dicValue-form").serialize(),
				dataType: "json",
				success: function (result) {
					console.log(result)
					if(result.ok){
						layer.alert(result.message, {icon: 6});
						//重置表单
						reset_form("#create-dicValue-form")
					}else {
						layer.alert(result.message, {icon: 5});
					}
				}
			});
		}else if($("#create-dicValue").val() == ""){
			layer.alert("亲，请输入字典值", {icon: 5});
		}else if($("#create-dicTypeCode").val() == '') {
			layer.alert("亲，字典类型编码", {icon: 5});
		}
	})
	//表单数据以及样式完整重置
	function reset_form(ele){
		//重置内容
		$(ele)[0].reset();
		//重置样式
		//$(ele).find("*").removeClass("has-error has-success");
		//辅助提示框的文本内容清空
		//$(ele).find(".help-block").text("");
	};
</script>

</html>