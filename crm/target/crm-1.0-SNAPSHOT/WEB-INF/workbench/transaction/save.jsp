<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />

<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

	<script type="text/javascript" src="/crm/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
	<script src="/crm/jquery/layer/layer.js"></script>
</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="findMarketActivity" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">

						  <div class="form-group has-feedback">
						    <input id="searchActivity" type="text" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>

					</div>
					<table id="activityTable3" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
						<tbody id="transactionActivityTbody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button onclick="bind()" type="button" class="btn btn-primary">关联</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 查找联系人 -->	
	<div class="modal fade" id="findContacts" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找联系人</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">

						  <div class="form-group has-feedback">
						    <input id="searchContacts" type="text" class="form-control" style="width: 300px;" placeholder="请输入联系人名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>

					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>邮箱</td>
								<td>手机</td>
							</tr>
						</thead>
						<tbody id="searchContactsTbody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>李四</td>
								<td>lisi@bjpowernode.com</td>
								<td>12345678901</td>
							</tr>--%>

						</tbody>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button onclick="bindContacts()" type="button" class="btn btn-primary">关联</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div style="position:  relative; left: 30px;">
		<h3>创建交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button onclick="saveTranBtn()" type="button" class="btn btn-primary">保存</button>
			<button type="button" onclick="window.history.back();" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" id="saveTranForm" role="form" style="position: relative; top: -30px;">
		<div class="form-group">
			<label for="create-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionOwner" name="owner">
				  <c:forEach items="${users}" var="user">
					  <option value="${user.id}">${user.name}</option>
				  </c:forEach>
				</select>
			</div>
			<label for="create-amountOfMoney" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-amountOfMoney" name="money">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-transactionName" name="name">
			</div>
			<label for="create-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-expectedClosingDate" name="expectedDate">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-accountName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" name="customerId" class="form-control" id="create-accountName" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="create-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" id="create-transactionStage" name="stage">
			  	<option></option>
				  <c:forEach items="${map['stage']}" var="stage">
					  <option value="${stage.value}">${stage.text}</option>
				  </c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-transactionType" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-transactionType" name="type">
				  <option></option>
					<c:forEach items="${map['transactionType']}" var="transactionType">
						<option value="${transactionType.value}">${transactionType.text}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-possibility" name="possibility">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-clueSource" name="source">
					<option></option>
					<c:forEach items="${map['source']}" var="source">
						<option value="${source.value}">${source.text}</option>
					</c:forEach>
				</select>
			</div>
			<label for="create-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findMarketActivity"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-activitySrc">
				<input type="hidden" class="form-control" id="activityId" name="activityId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-contactsName">
				<input type="hidden" id="contactsId" name="contactsId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-nextContactTime" name="nextContactTime">
			</div>
		</div>
		
	</form>
</body>

<script>

	//保存交易
	function saveTranBtn(){
		$.ajax({
		    url: "/crm/workbench/transaction/saveTran",
		    type: "post",
		    data: $("#saveTranForm").serialize(),
		    dataType: "json",
		    success: function (result) {
		        //console.log(result)
				if(result.ok){
					layer.alert(result.message, {icon: 6});
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	}

	//阶段对应可能性
	$("#create-transactionStage").change(function () {
		$.ajax({
		    url: "/crm/workbench/transaction/stagePossibility",
		    type: "post",
		    data: {"stage":$("#create-transactionStage").val()},
		    dataType: "json",
		    success: function (result) {
				$("#create-possibility").val(result)
			}
		});

	})

	//自动补全功能
	$("#create-accountName").typeahead({
		source: function (customerName, process) {
			$.post(
					"/crm/workbench/transaction/queryCustomerName",
					{ "customerName" : customerName },
					function (data) {
						//List<String>
						//alert(data);
						process(data.nameList);
					},
					"json"
			);
		},
		//输入内容后延迟多长时间弹出提示内容
		delay: 200
	});

	//查找市场活动
	$("#searchActivity").keypress(function (event) {
		let keyCode = event.keyCode;
		if(keyCode == 13){
			$.ajax({
			    url: "/crm/workbench/transaction/queryAllActivity",
			    type: "get",
			    data: {'name':$("#searchActivity").val()},
			    dataType: "json",
			    success: function (result) {
			        //console.log(result)
					$("#transactionActivityTbody").html("")
					$.each(result,function (index,activity) {
						$("#transactionActivityTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input class='son' value="+activity.id+" type=\"radio\" name=\"activity\"/></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.name+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.startDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.owner+"</td>")
					})
			    }
			});
		}
	})

	//查找联系人
	$("#searchContacts").keypress(function (event) {
		let keyCode = event.keyCode;
		if(keyCode == 13){
			$.ajax({
				url: "/crm/workbench/transaction/queryContacts",
				type: "get",
				data: {'name':$("#searchContacts").val()},
				dataType: "json",
				success: function (result) {
					//console.log(result)
					$("#searchContactsTbody").html("")
					$.each(result,function (index,contacts) {
						$("#searchContactsTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input class='contactsSon' value="+contacts.id+" type=\"radio\" name=\"activity\"/></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+contacts.fullname+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+contacts.email+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+contacts.mphone+"</td>")
					})
				}
			});
		}
	})

	//选择市场活动源，文本框对应改变
	function bind(){
		let length = $(".son:checked").length;
		if (length > 1){
			layer.alert("亲，只能选择一个哦", {icon: 5});
		}else {
			let value = $(".son:checked")[0].value;
			$("#activityId").val(value)
			let text = $($(".son:checked")[0]).parent().next().text()
			$("#create-activitySrc").val(text)
			$("#findMarketActivity").modal("hide")

		}
	}
	//选择联系人，文本框对应改变
	function bindContacts() {
		let length = $(".contactsSon:checked").length;
		if (length > 1){
			layer.alert("亲，只能选择一个哦", {icon: 5});
		}else {
			let value = $(".contactsSon:checked")[0].value;
			$("#contactsId").val(value)
			let text = $($(".contactsSon:checked")[0]).parent().next().text()
			$("#create-contactsName").val(text)
			$("#findContacts").modal("hide")

		}
	}

	//表单数据以及样式完整重置
	function reset_form(ele){
		//重置内容
		$(ele)[0].reset();
		//重置样式
		//$(ele).find("*").removeClass("has-error has-success");
		//辅助提示框的文本内容清空
		//$(ele).find(".help-block").text("");
	};
	//新增模态框时间控件edit-nextContactTime
	$("#create-nextContactTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "top-right"
	});
	//新增模态框时间控件edit-nextContactTime
	$("#create-expectedClosingDate").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});
</script>
</html>