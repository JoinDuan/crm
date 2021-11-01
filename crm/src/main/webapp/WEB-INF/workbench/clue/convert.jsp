<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script src="/crm/jquery/layer/layer.js"></script>
<script type="text/javascript">
	$(function(){
		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});
	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
						  <div class="form-group has-feedback">
						    <input type="text" id="activitySearchName" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="searchActivityTbody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>
							<tr>--%>
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

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small id="smallNameCompany"></small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">

	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">

	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
	

		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control" id="expectedClosingDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage" class="form-control">
		    	<c:forEach items="${map['stage']}" var="stage">
					<option value="${stage.value}">${stage.text}</option>
				</c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
		    <input type="text" class="form-control" id="activityName" placeholder="点击上面搜索" readonly>
			  <input type="hidden" id="activityId">
		  </div>

	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b id="bowner"></b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input id="transFormBtn" class="btn btn-primary" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input onclick="window.location='/crm/toView/workbench/clue/index';" class="btn btn-default" type="button" value="取消">
	</div>
</body>

<script>
	//加载线索详细信息
	$(function () {
		$.ajax({
			url: "/crm/workbench/clue/queryClueById/"+"${id}",
			type: "get",
			dataType: "json",
			success: function (result) {
				$("#bowner").html(result.owner)
				$("#smallNameCompany").text(result.fullname+result.appellation+"-"+result.company)
				$("#create-customer").text("新建客户："+result.company)
				$("#create-contact").text("新建联系人："+result.fullname+result.appellation)

			}
		});
	})

	$("#transFormBtn").click(function () {
		$.ajax({
		    url: "/crm/workbench/clue/clueTransForm",
		    type: "post",
		    data: {
		    	"id":'${id}',
				"isTran":$('#isCreateTransaction').val(),
				"activityId":$("#activityId").val(),
				"money":$("#amountOfMoney").val(),
				"name":$("#tradeName").val(),
				"expectedDate":$("#expectedClosingDate").val(),
				"stage":$("#stage").val(),
				"source":$("#activityName").val()
			},
		    dataType: "json",
		    success: function (result) {
		        console.log(result)
				if(result.ok){
					layer.alert(result.message, {icon: 6});
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	})

	//查询当前线索已经关联的市场活动
	$("#activitySearchName").keypress(function (event) {
		let name = $("#activitySearchName").val();
		if(event.keyCode == 13){
			$.ajax({
				url: "/crm/workbench/clue/queryClueRelationActivity",
				type: "get",
				data:{
					'id':'${id}',
					'name':name
				},
				dataType: "json",
				success: function (result) {
					$("#searchActivityTbody").html("")
					$.each(result,function (index,obj) {
						$("#searchActivityTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input value='"+obj.id+"' class='son' type=\"radio\" name=\"activity\"/></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+obj.name+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+obj.startDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+obj.endDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+obj.owner+"</td>\n" +
								"\t\t\t\t\t\t\t</tr>")
					})
				}
			});

		}
	})

	//是否发生交易
	$('#isCreateTransaction').change(function () {
		if($(this).prop('checked')){
			$(this).val("1");
		}else {
			$(this).val("");
		}
	});

	//点击关联按钮，为当前交易创建关联的市场活动
	function bind(){
		let length = $(".son:checked").length;
		if(length = 1){
			let id = $(".son")[0].value;
			let name = $($(".son:checked")[0]).parent().next().text();
			$("#activityName").val(name)
			$("#activityId").val(id)
			$("#searchActivityModal").modal("hide")
		}else {
			layer.alert("亲，只能关联一个哦", {icon: 6});
		}
	}
	//日期组件
	$("#expectedClosingDate").datetimepicker({
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