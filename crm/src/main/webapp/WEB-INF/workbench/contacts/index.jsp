<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<script type="text/javascript" src="/crm/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
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

	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="addContactsForm" role="form">
					
						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-contactsOwner" name="owner">
									<c:forEach items="${users}" var="user">
										<option value="user.id">user.name</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueSource" name="source">
								  <option></option>
								  <c:forEach items="${map['source']}" var="source">
									  <option value="${source.value}">${source.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname" name="fullname">
							</div>
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-call" name="appellation">
								  <option></option>
								  <c:forEach items="${map['appellation']}" var="appellation">
									  <option value="${appellation.value}">${appellation.text}</option>
								  </c:forEach>
								</select>
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job" name="job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone" name="mphone">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email" name="email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="create-birth" name="birth">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="customerId" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary1"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" name="nextContactTime" id="create-nextContactTime1">
								</div>
							</div>
						</div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address1" name="address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button onclick="addSaveContacts()" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit-contacts-form" role="form">
					
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-contactsOwner" name="owner">
								 <c:forEach items="${users}" var="user">
									 <option value="${user.id}">${user.name}</option>
								 </c:forEach>
								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource1" name="source">
								  <c:forEach items="${map['source']}" var="source">
									  <option value="${source.value}">${source.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" name="fullname">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call" name="appellation">
								  <c:forEach items="${map['appellation']}" var="appellation">
									  <option value="${appellation.value}">${appellation.text}</option>
								  </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" name="job">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" name="mphone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" name="email">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control time" id="edit-birth" name="birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="customerId" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
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
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime-contacts" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control time" name="nextContactTime" id="create-nextContactTime-contacts">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address2" name="address"></textarea>
									<input type="hidden" id="id" name="id">
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button onclick="updateContactsFuc()" type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

			<%--模糊查询框--%>
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="select-owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" type="text" id="select-name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="select-customerId">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="select-clueSource">
						  <option></option>
						  <c:forEach items="${map['source']}" var="source">
							  <option value="${source.value}">${source.text}</option>
						  </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control" type="text" id="select-birth">
				    </div>
				  </div>
				  
				  <button onclick="toContactsPage(1,3)" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" id="create-contacts-btn" class="btn btn-primary" data-toggle="modal" data-target="#createContactsModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button id="contactsEditBtn" type="button" class="btn btn-default" data-toggle="modal"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button onclick="deleteContacts()" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="contactsFatcher"/></td>
							<td>姓名</td>
							<td>客户名称</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="contactsTbody">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四</a></td>
							<td>动力节点</td>
							<td>zhangsan</td>
							<td>广告</td>
							<td>2000-10-10</td>
						</tr>--%>

					</tbody>
				</table>
			</div>

				<%--分页条1--%>
			<div style="height: 50px; position: relative;top: 10px;">
				<div id="contactsPage">

				</div>
			</div>
			
		</div>
		
	</div>
</body>
<script>
	$(function () {
		toContactsPage(1,3)
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

	function toContactsPage(page,pageSize) {
		//查询列表
		$.ajax({
			url: '/crm/workbench/contacts/queryAllContacts',
			data: {
				'page':page,
				"pageSize":pageSize,
				'fullname': $("#select-name").val(),
				'owner': $("#select-owner").val(),
				'customerId': $("#select-customerId").val(),
				'source':$("#select-clueSource").val(),
				'birth':$("#select-birth").val()
			},
			type: 'get',
			dataType: 'json',
			success : function(pageInfo){
				//清空上一次拼接的数据
				$('#contactsTbody').html("");
				$.each(pageInfo.list,function (index,obj) {
					//后台传递的每页的总数据
					$("#contactsTbody").append("<tr>\n" +
							"\t\t\t\t\t\t\t<td><input type=\"checkbox\" class='son2' onclick='checkOne2()' value="+obj.id+" /></td>\n" +
							"\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='/crm/toView/workbench/contacts/detail?id="+obj.id+"';\">"+obj.fullname+"</a></td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.customerId+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.owner+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.source+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.birth+"</td>\n" +
							"\t\t\t\t\t\t</tr>");
				});
				$("#contactsPage").bs_pagination({
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
						toContactsPage(page,rowsPerPage)
					}
				});
			}
		});
	}

	//新增·contacts模态框-所有者
	$("#create-contacts-btn").click(function () {
		$.ajax({
			url: "/crm/workbench/consumer/queryAllOwner",
			type: "get",
			dataType : 'json',
			success: function (result) {
				$("#create-contactsOwner").html("")
				$.each(result,function (index,obj) {
					let optionEle = $("<option></option>").text(obj.name).val(obj.id);
					$("#create-contactsOwner").append(optionEle)
				})
			}
		});
	})
	//新增.contacts模态框-客户名称

	//选中所有
	$("#contactsFatcher").click(function () {
		let prop = $(this).prop('checked');
		$('.son2').prop('checked',prop);
	})
	function checkOne2(){
		let length1 = $(".son2").length;
		let length2 = $(".son2:checked").length;
		if(length1 == length2){
			$("#contactsFatcher").prop("checked", true);
		}else{
			$("#contactsFatcher").prop("checked", false);
		}
	}

	//修改contacts-模态框填充值
	$("#contactsEditBtn").click(function () {
		let flag = false;
		let length = $(".son2:checked").length;
		let id = $(".son2:checked").val()
		if (length < 1){
			layer.alert("请至少选择一位", {icon: 5});
		}else if(length > 1){
			layer.alert("一次只能选择一位", {icon: 5});
		}else {
			$.ajax({
				url: "/crm/workbench/contacts/queryContactsById",
				type: "get",
				data: "id="+id,
				dataType: "json",
				success: function (result) {
					let selected = result.owner;
					$("#edit-contactsOwner").find("option").each(function(){
						if($(this).text() == selected)	{
							$(this).attr("selected",true);
						}
					});
					$("#id").val(result.id)
					$("#edit-clueSource1").val(result.source)
					$("#edit-surname").val(result.fullname)
					$("#edit-call").val(result.appellation)
					$("#edit-job").val(result.job)
					$("#edit-mphone").val(result.mphone)
					$("#edit-email").val(result.email)
					$("#edit-birth").val(result.birth)
					$("#edit-customerName").val(result.customerId)
					$("#edit-describe").text(result.description)
					$("#create-contactSummary").val(result.contactSummary)
					$("#create-nextContactTime-contacts").val(result.nextContactTime)
					$("#edit-address2").val(result.address)
					//打开模态框
					$("#editContactsModal").modal("show");
				}
			});
		}

	})

	//修改contacts
	function updateContactsFuc(){
		$.ajax({
			url: "/crm/workbench/contacts/editContacts",
			type: "post",
			data: $("#edit-contacts-form").serialize(),
			dataType: "json",
			success: function (result) {
				if(result.ok){
					layer.alert("修改成功", {icon: 6});
					//关闭模态框
					$("#editCustomerModal").modal("hide");
					toContactsPage(1, 3);
				}else {
					layer.alert(result.message, {icon: 5});
				}
			}
		});

	}

	//创建contacts
	function addSaveContacts() {
		$.ajax({
		    url: "/crm/workbench/contacts/addContacts",
		    type: "post",
		    data: $("#addContactsForm").serialize(),
		    dataType: "json",
		    success: function (result) {
				if(result.ok){
					layer.alert(result.message, {icon: 6});
					toContactsPage(1, 3);
				}else {
					layer.alert(result.message, {icon: 5});
				}

		    }
		});

	}

	//删除，单个与批量
	function deleteContacts(){
		let length = $(".son2:checked").length;
		if(length < 1){
			layer.alert("请至少选择一个", {icon: 5});
		}else {
			layer.confirm('确认删除选中的' + length + '条记录吗？', {icon: 3, title:'温馨提示'}, function(index){
				let ids = [];
				for (let i = 0;i < length;i++){
					let value = $(".son2:checked")[i].value
					ids[i] = value;
				}
				$.ajax({
				    url: "/crm/workbench/contacts/delContacts",
				    type: "post",
				    data: {"ids":ids.join()},
				    dataType: "json",
				    success: function (result) {
				    	if(result.ok){
							layer.alert(result.message, {icon: 6});
							toContactsPage(1,3)
						}else {
							layer.alert(result.message, {icon: 5});
						}
				    }
				});


				//index:按钮索引编号
				layer.close(index);},function () {});
		}

	}

	//自动补全功能
	$("#create-customerName").typeahead({
		source: function (customerName, process) {
			$.post(
					"/crm/workbench/contacts/queryContactsName",
					{ "customerName" : customerName },
					function (data) {
						//List<String>
						//alert(data);
						process(data);
					},
					"json"
			);
		},
		//输入内容后延迟多长时间弹出提示内容
		delay: 200
	});


	//addModal日期插件
	$(".time").datetimepicker({
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