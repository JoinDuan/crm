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
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		
	});

	
</script>
</head>
<body>

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="saveCustomerForm">
					
						<div class="form-group">
							<label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-customerOwner" name="owner">

								</select>
							</div>
							<label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-customerName" name="name">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-website" name="website">
                            </div>
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" name="phone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
							</div>
						</div>
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-contactSummary" name="contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="create-nextContactTime" name="nextContactTime">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address1" name="address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="saveCustomer()">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="edit-customer-form">
					
						<div class="form-group">
							<label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-customerOwner" name="owner">

								</select>
							</div>
							<label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="name" id="edit-customerName">
								<input type="hidden" name="id" id="edit-consumer-id">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="website" id="edit-website">
                            </div>
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" name="phone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe" name="description"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-contactSummary1" name="contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="create-nextContactTime2" name="nextContactTime">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="create-address" name="address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" onclick="updateCustomerFuc()" class="btn btn-primary">更新</button>
				</div>
			</div>
		</div>
	</div>

	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
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
				      <input class="form-control" type="text" id="select-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="select-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" id="select-phone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司网站</div>
				      <input class="form-control" type="text" id="select-website">
				    </div>
				  </div>
				  
				  <button onclick="toCustomerPage(1,3)" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" id="customerAddBtn" class="btn btn-primary" data-toggle="modal" data-target="#createCustomerModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" id="customerEditBtn" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" id="customerDelBtn" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="fathers"/></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="customerTbody">
                        <%--<tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点</a></td>
                            <td>zhangsan</td>
                            <td>010-84846003</td>
                            <td>http://www.bjpowernode.com</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="consumerPage">

				</div>
			</div>
			
		</div>
	</div>
</body>

<script>
	let pageMax;
	$(function () {
		toCustomerPage(1,3);
	})
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
	function toCustomerPage(page,pageSize){
		//查询列表
		$.ajax({
			url: '/crm/workbench/customer/queryAllCustomer',
			data: {
				'page':page,
				"pageSize":pageSize,
				'name': $("#select-name").val(),
				'owner': $("#select-owner").val(),
				'phone': $("#select-phone").val(),
				'website':$("#select-website").val()
			},
			type: 'get',
			dataType: 'json',
			success : function(pageInfo){
				//清空上一次拼接的数据
				$('#customerTbody').html("");
				$.each(pageInfo.list,function (index,obj) {
					//后台传递的每页的总数据
					$("#customerTbody").append("<tr class=\"active\">\n" +
							"                            <td><input type=\"checkbox\" class='sonOne' onclick='selectOnes()' value="+obj.id+"></td>\n" +
							"                            <td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='/crm/toView/workbench/customer/detail?id="+obj.id+"';\">"+obj.name+"</a></td>\n" +
							"                            <td>"+obj.owner+"</td>\n" +
							"                            <td>"+obj.phone+"</td>\n" +
							"                            <td>"+obj.website+"</td>\n" +
							"                        </tr>");
				});
				pageMax = pageInfo.pages;
				$("#consumerPage").bs_pagination({
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
						toCustomerPage(page,rowsPerPage)
					}
				});
			}
		});
	};

	//全选、反选
	$('#fathers').click(function () {
		let prop = $(this).prop('checked');
		$('.sonOne').prop('checked',prop);
	});
	function selectOnes(){
		let length3 = $('.sonOne').length;
		let length4 = $(".sonOne:checked").length;
		if(length3 == length4){
			$('#fathers').prop("checked",true)
		}else {
			$('#fathers').prop("checked",false)
		}
	}

	//创建模态窗口填充所有者信息
	//市场活动新增模态框填充所有者
	$("#customerAddBtn").click(function () {
		$.ajax({
			url: "/crm/workbench/consumer/queryAllOwner",
			type: "get",
			dataType : 'json',
			success: function (result) {
				$("#create-customerOwner").html("")
				$.each(result,function (index,obj) {
					let optionEle = $("<option></option>").text(obj.name).val(obj.id);
					$("#create-customerOwner").append(optionEle)
				})
			}
		});
	})

	//新增consumer
	function saveCustomer(){
		$.ajax({
		    url: "/crm/workbench/consumer/addCustomer",
		    type: "post",
		    data: $("#saveCustomerForm").serialize(),
		    dataType: "json",
		    success: function (result) {
		        if(result.ok){
					$("#saveCustomerForm").text("")
					layer.alert(result.message, {icon: 6});
					$("#createCustomerModal").modal("hide");
					toCustomerPage(pageMax,3)
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	}

	//修改consumer-模态框填充值
	$("#customerEditBtn").click(function () {
		let flag = false;
		let length = $(".sonOne:checked").length;
		let id = $(".sonOne:checked").val()
		if (length < 1){
			layer.alert("请至少选择一位", {icon: 5});
		}else if(length > 1){
			layer.alert("一次只能选择一位", {icon: 5});
		}else {
			$.ajax({
				url: "/crm/workbench/consumer/queryAllOwner",
				type: "get",
				dataType : 'json',
				success: function (result) {
					$("#edit-customerOwner").html("")
					$.each(result,function (index,obj) {
						let optionEle = $("<option></option>").text(obj.name).val(obj.id);
						$("#edit-customerOwner").append(optionEle)
						flag = true;
					})
				}
			});

			customerEditList(id);
		}

	})

	function customerEditList(id) {
		$.ajax({
			url: "/crm/workbench/consumer/queryCustomerById",
			type: "get",
			data: "id="+id,
			dataType: "json",
			success: function (result) {
				$("#edit-customerOwner").val(result.owner)

				$("#edit-customerName").val(result.name)
				$("#edit-consumer-id").val(result.id)
				$("#edit-website").val(result.website)
				$("#edit-phone").val(result.phone)
				$("#edit-describe").val(result.description)
				$("#create-nextContactTime2").val(result.nextContactTime)
				$("#create-address").val(result.address)
				//打开模态框
				$("#editCustomerModal").modal("show");
			}
		});
	}

	//修改consumer
	function updateCustomerFuc(){
		$.ajax({
		    url: "/crm/workbench/consumer/editCustomer",
		    type: "post",
		    data: $("#edit-customer-form").serialize(),
		    dataType: "json",
		    success: function (result) {
				if(result.ok){
					layer.alert("修改成功", {icon: 6});
					//关闭模态框
					$("#editCustomerModal").modal("hide");
					toCustomerPage(1, 3);
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	}

	//删除customer
	$("#customerDelBtn").click(function () {
		let length = $(".sonOne:checked").length;
		if (length < 1){
			layer.alert("请至少选择一位", {icon: 5});
		}else {
			layer.confirm('确认删除选中的' + length + '条记录吗？', {icon: 3, title:'温馨提示'}, function(index){

				let ids = [];
				for (let i = 0;i < length;i++){
					let value = $(".sonOne:checked")[i].value
					ids[i] = value;
				}
				$.ajax({
					url: "/crm/workbench/consumer/delCustomer",
					type: "post",
					data: {"ids":ids.join()},
					dataType: "json",
					success: function (result) {
						if(result.ok){
							layer.alert("删除成功", {icon: 6});
							toCustomerPage(1, 3);
						}else {
							layer.alert(result.message, {icon: 5});
						}
					}
				});
				//index:按钮索引编号
				layer.close(index);},function () {});
		}
	})

	//addModal日期插件
	$("#create-nextContactTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "top-left"
	});
	//editModal日期插件
	$("#create-nextContactTime2").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "top-left"
	});
</script>

</html>