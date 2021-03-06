<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
<link href="/crm/jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="/crm/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="/crm/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
	<script src="/crm/jquery/layer/layer.js"></script>
<script type="text/javascript">

	$(function(){

	});

</script>
</head>
<body>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form" id="addActivityForm">

						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-marketActivityOwner" name="owner">
								  <%--<option>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>--%>
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-marketActivityName" name="name">
                            </div>
						</div>

						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-startTime" name="startDate">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-endTime"  name="endDate">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-cost" name="cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addAndEdit($(this).text())" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form" id="editActivityForm">

						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-marketActivityOwner" name="owner">

								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" name="name">
								<input type="hidden" name="id" id="id">
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-startTime" name="startDate">
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-endTime" name="endDate">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-cost" name="cost">
							</div>
						</div>

						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe" name="description"></textarea>
							</div>
						</div>

					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addAndEdit($(this).text())" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>



<%--市场活动列表--%>
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
			</div>
		</div>
	</div>
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" name="name" id="name">
				    </div>
				  </div>

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" name="owner" id="owner">
				    </div>
				  </div>


				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="startTime" name="startDate"/>
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="endTime" name="endDate">
				    </div>
				  </div>

				  <button type="button" onclick="toPage(1,3)" class="btn btn-default">查询</button>

				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button id="createActivityBtn" type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button id="editActivityBtn" type="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button id="delActivityBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				  <button onclick="exportActivityExcel()" id="excelActivityBtn" type="button" class="btn btn-info"><span class="glyphicon glyphicon-download-alt"></span> 导出</button>
				</div>

			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="father" /></td>
							<td>名称</td>
                            <td>所有者</td>
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityBody">


					</tbody>
				</table>
			</div>

            <div style="height: 50px; position: relative;top: 30px;">
                <div id="activityPage">

				</div>
            </div>

		</div>
	</div>

</body>
<script>

	toPage(1,3)
	//分页插件js dom
	var rsc_bs_pag = {
		go_to_page_title: 'Go to page',
		rows_per_page_title: 'Rows per page',
		current_page_label: 'Page',
		current_page_abbr_label: 'p.',
		total_pages_label: 'of',
		total_pages_abbr_label: '/',
		total_rows_label: 'of',
		rows_info_records: 'records',
		go_top_text: '首页',
		go_prev_text: '上一页',
		go_next_text: '下一页',
		go_last_text: '末页'
	};

	//查询函数+分页
    function toPage(page,pageSize){
		//查询列表
		$.ajax({
			url: '/crm/workbench/activity/queryAllActivity',
			data: {
				'page':page,
				"pageSize":pageSize,
				'name': $("#name").val(),
				'owner': $("#owner").val(),
				'startDate': $("#startTime").val(),
				'endDate':$("#endTime").val()
			},
			type: 'get',
			dataType: 'json',
			success : function(pageInfo){
				//清空上一次拼接的数据
				$('#activityBody').html("");
				$.each(pageInfo.list,function (index,obj) {
					//后台传递的每页的总数据
					$("#activityBody").append("<tr class=\"active\">\n" +
							"<td><input type=\"checkbox\" onclick='selectOne()' class='son' value="+obj.id+" /></td>\n" +
							"<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='/crm/toView/workbench/activity/detail?id="+obj.id+"';\">"+obj.name+"</a></td>\n" +
							"<td>"+obj.owner+"</td>\n" +
							"<td>"+obj.startDate+"</td>\n" +
							"<td>"+obj.endDate+"</td>\n" +
							"</tr> ");
				});
				$("#activityPage").bs_pagination({
					currentPage: pageInfo.pageNum, // 页码
					rowsPerPage: pageInfo.pageSize, // 每页显示的记录条数
					maxRowsPerPage: 20, // 每页最多显示的记录条数
					totalPages: pageInfo.pages, // 总页数
					totalRows: pageInfo.total, // 总记录条数
					visiblePageLinks: 3, // 显示几个卡片
					showGoToPage: true,
					showRowsPerPage: true,
					showRowsInfo: true,
					showRowsDefaultInfo: true,
					//回调函数，用户每次点击分页插件进行翻页的时候就会触发该函数
					onChangePage : function(event, obj){
						//刷新页面，obj.currentPage:当前点击的页码
						let page = obj.currentPage
						let rowsPerPage = obj.rowsPerPage
						//分页刷新
						toPage(page,rowsPerPage)
					}
				});
			}
		});
	};

	//全选、反选
	$('#father').click(function () {
		$('.son').prop('checked',$(this).prop('checked'));
	});
	function selectOne(){
		let length = $('.son').length;
		let length1 = $(".son:checked").length;
		if(length1 == length){
			$('#father').prop("checked",true)
		}else {
			$('#father').prop("checked",false)
		}
	}

	//市场活动新增模态框填充所有者
	$("#createActivityBtn").click(function () {
		$.ajax({
		    url: "/crm/workbench/activity/queryAllOwner",
		    type: "get",
			dataType : 'json',
		    success: function (result) {
				$("#create-marketActivityOwner").html("")
				$.each(result,function (index,obj) {
					let optionEle = $("<option></option>").text(obj.name).val(obj.id);
					$("#create-marketActivityOwner").append(optionEle)
				})
			}
		});
	})

	//市场活动修改模态框填充信息 edit-marketActivityOwner
	$("#editActivityBtn").click(function () {

		//判断选择的数量
		let length = $(".son:checked").length;
		if(length > 1){
			layer.alert("亲，一次只能修改一个", {icon: 5});
		}
		if(length == 0){
			layer.alert("亲，请选择修改一个", {icon: 5});
		}
		if(length == 1){
			//打开模态框
			$("#editActivityModal").modal({backdrop: "static"})

			//市场活动修改模态框填充所有者
			$.ajax({
				url: "/crm/workbench/activity/queryAllOwner",
				type: "get",
				dataType : 'json',
				success: function (result) {
					$("#edit-marketActivityOwner").html("")
					$.each(result,function (index,obj) {
						let optionEle = $("<option></option>").text(obj.name).val(obj.id);
						$("#edit-marketActivityOwner").append(optionEle)
					})
				}
			});
			//普通信息
			$.ajax({
				url: "/crm/workbench/activity/getActivityById",
				type: "get",
				data: {"id": $(".son:checked").val()},
				dataType : 'json',
				success: function (result) {

					$("#edit-marketActivityOwner").val(result.owner)
					$("#edit-marketActivityName").val(result.name)
					$("#edit-startTime").val(result.startDate)
					$("#edit-endTime").val(result.endDate)
					$("#edit-describe").val(result.description)
					$("#edit-cost").val(result.cost)
					//设置市场活动主键，放在隐藏域中
					$('#id').val(result.id);
					//让所有者显示当前市场活动对应的所有者
				}
			});
		}

	})

	//删除
	$("#delActivityBtn").click(function () {
		//判断选择的数量
		let length = $(".son:checked").length;
		if(length == 0){
			layer.alert("亲，请至少选择一个修改", {icon: 5});
		}else{
			layer.confirm('确认删除选中的' + length + '条记录吗？', {icon: 3, title:'温馨提示'},
			function(index){
				let ids = [];
				for(let i = 0;i < length;i++){
					ids.push($(".son:checked")[i].value)
				}
				let id = ids.join()
				$.ajax({
					url: "/crm/workbench/activity/delActivity",
					type: "get",
					data: {"id":id},
					dataType: "json",
					success: function (result) {
						if(result.ok){
							layer.alert(result.message, {icon: 6});
						}else {
							layer.alert(result.message, {icon: 5});
						}
						console.log(result)
						toPage(1,3)
					}
				});
				//index:按钮索引编号
				layer.close(index);
			},function () {});

		}
	});

	//新建和修改两个模态框进一个函数，一个控制器
	function addAndEdit(ele){
		if(ele == "保存"){
			$.ajax({
			    url: "/crm/workbench/activity/addAndEditActivity",
			    type: "post",
			    data: $("#addActivityForm").serialize(),
				dataType: 'json',
			    success: function (result) {
			        if(result.ok){
						layer.alert(result.message, {icon: 6});
					}else {
						layer.alert(result.message, {icon: 5});
					}
			        toPage(1,3)
			    }
			});
		}else {
			//更新
			$.ajax({
				url: "/crm/workbench/activity/addAndEditActivity",
				type: "post",
				data: $("#editActivityForm").serialize(),
				dataType: 'json',
				success: function (result) {
					if(result.ok){
						layer.alert(result.message, {icon: 6});
					}else {
						layer.alert(result.message, {icon: 5});
					}
					toPage(1,3)
				}
			});

		}
	}

	//导出Excel表格
	function exportActivityExcel() {
		location.href = '/crm/workbench/activity/exportExcel';
	}

	//日期组件
	(function($){
		$.fn.datetimepicker.dates['zh-CN'] = {
			days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
			daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
			daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
			months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
			today: "今天",
			suffix: [],
			meridiem: ["上午", "下午"]
		};
	}(jQuery));
	//查询日期插件
	$("#startTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});
	//查询日期插件
	$("#endTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});

	//查询日期插件
	$("#create-startTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});
	//查询日期插件
	$("#create-endTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});

	//修改日期插件
	$("#edit-startTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});
	//修改日期插件
	$("#edit-endTime").datetimepicker({
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