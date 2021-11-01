<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

	<!-- 创建线索的模态窗口 -->
	<div class="modal fade" id="createClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">创建线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="addForm" role="form">
					
						<div class="form-group">
							<label for="create-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-clueOwner" name="owner">
									<c:forEach items="${users}" var="user">
										<option value="${user.id}">${user.name}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-company" name="company">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-call" name="appellation">
									<option></option>
									<c:forEach items="${map['appellation']}" var="appellation">
										<option value="${appellation.value}">${appellation.text}</option>
									</c:forEach>
								</select>
							</div>
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-surname" name="fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-job" name="job">
							</div>
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-email" name="email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" name="phone">
							</div>
							<label for="create-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-website" name="website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-mphone" name="mphone">
							</div>
							<label for="create-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-status" name="state">
									<option></option>
									<c:forEach items="${map['clueState']}" var="clueState">
										<option value="${clueState.value}">${clueState.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-source" name="source">
									<option></option>
									<c:forEach items="${map['source']}" var="source">
										<option value="${source.value}">${source.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						

						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">线索描述</label>
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
					<button type="button" onclick="addSaveClue()" class="btn btn-primary" >保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改线索的模态窗口 -->
	<div class="modal fade" id="editClueModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">修改线索</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form" id="edit-clue-form">
					
						<div class="form-group">
							<label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueOwner" name="owner">
									<option style='display: none'></option>
									<c:forEach items="${users}" var="user">
										<option value="${user.id}">${user.name}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-company" name="company">
								<input type="hidden" id="edit-clue-id" name="id">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call" name="appellation">
									<c:forEach items="${map['appellation']}" var="appellation">
										<option value="${appellation.value}">${appellation.text}</option>
									</c:forEach>
								</select>
							</div>
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" name="fullname">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" name="job">
							</div>
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" name="email">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" name="phone">
							</div>
							<label for="edit-website" class="col-sm-2 control-label">公司网站</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-website" name="website">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" name="mphone">
							</div>
							<label for="edit-status" class="col-sm-2 control-label">线索状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-status" name="state">
									<c:forEach items="${map['clueState']}" var="clueState">
										<option value="${clueState.value}">${clueState.text}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-source" class="col-sm-2 control-label">线索来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-source" name="source">
									<c:forEach items="${map['source']}" var="source">
										<option value="${source.value}">${source.text}</option>
									</c:forEach>
								</select>
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
								<label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="edit-contactSummary" name="contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="edit-nextContactTime" name="nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address" name="address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button onclick="updateClueFuc()" type="button" class="btn btn-primary">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>线索列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
		<%--搜索框--%>
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" id="searchFrom" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" name="fullname" id="searchfullname">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司</div>
				      <input class="form-control" type="text" name="company" id="searchcompany">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" type="text" name="phone" id="searchphone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索来源</div>
					  <select class="form-control" name="source" id="searchsource">
						  <option></option>
						  <c:forEach items="${map['source']}" var="source">
							  <option value="${source.value}">${source.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" name="owner" id="searchowner">
				    </div>
				  </div>
				  
				  
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">手机</div>
				      <input class="form-control" type="text" name="mphone" id="searchmphone">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">线索状态</div>
					  <select class="form-control" name="state" id="searchstate">
					  	<option></option>
						  <c:forEach items="${map['clueState']}" var="clueState">
							  <option value="${clueState.value}">${clueState.text}</option>
						  </c:forEach>
					  </select>
				    </div>
				  </div>

				  <button type="button" onclick="toPage(1,3)" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createClueModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button onclick="edit_clue_select()" type="button" class="btn btn-default" data-toggle="modal" ><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button id="clueDelBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<%--展示数据--%>
			<div style="position: relative;top: 50px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll" /></td>
							<td>名称</td>
							<td>公司</td>
							<td>公司座机</td>
							<td>手机</td>
							<td>线索来源</td>
							<td>所有者</td>
							<td>线索状态</td>
						</tr>
					</thead>
					<tbody id="clueListTbody">

                        <%--<tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">李四先生</a></td>
                            <td>动力节点</td>
                            <td>010-84846003</td>
                            <td>12345678901</td>
                            <td>广告</td>
                            <td>zhangsan</td>
                            <td>已联系</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>

			<%--分页条--%>
			<div style="height: 50px; position: relative;top: 60px;">
				<div id="listDiv">

				</div>
			</div>
			
		</div>
		
	</div>
</body>
<script>

	$(function () {
		toPage(1, 3);
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

	//刷新页面
	function toPage(page,pageSize) {
		$.ajax({
		    url: "/crm/workbench/clue/queryAllClue",
		    type: "POST",
		    data: {
		    	"page":page,
				"pageSize":pageSize,
				"fullname":$("#searchfullname").val(),
				"company":$("#searchcompany").val(),
				"phone":$("#searchphone").val(),
				"source":$("#searchsource").val(),
				"mphone":$("#searchmphone").val(),
				"state":$("#searchstate").val(),
				"owner":$("#searchowner").val()
			},
		    dataType: "json",
		    success: function (pageInfo) {
				let data = pageInfo.list;
				$("#clueListTbody").html("")
		        $.each(data,function (index,obj) {
					$("#clueListTbody").append("<tr class=\"active\">\n" +
							"                            <td><input type=\"checkbox\" onclick='checkOneClue()' class='son' value="+obj.id+" /></td>\n" +
							"                            <td><a href=\"javascript:void(0)\" style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='/crm/toView/workbench/clue/detail?id="+obj.id+"';\">"+obj.fullname+obj.appellation+"</a></td>\n" +
							"                            <td>"+obj.company+"</td>\n" +
							"                            <td>"+obj.phone+"</td>\n" +
							"                            <td>"+obj.mphone+"</td>\n" +
							"                            <td>"+obj.source+"</td>\n" +
							"                            <td>"+obj.owner+"</td>\n" +
							"                            <td>"+obj.state+"</td>\n" +
							"                        </tr>")
				});

				$("#listDiv").bs_pagination({
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
	}

	//新增页面
	function addSaveClue() {
		//非空判断

		$.ajax({
			url: "/crm/workbench/clue/addClue",
			type: "POST",
			data: $("#addForm").serialize(),
			dataType: "json",
			success: function (result) {
				//console.log(result)
				if(result.ok){
					//关闭模态框
					$("#createClueModal").modal("hide");
					layer.alert(result.message, {icon: 6});
					//重置表单
					reset_form("#addForm")
					//刷新页面
					toPage(1,3)
				}else {
					layer.alert(result.message, {icon: 5});
				}
			}
		});
	};
	
	//全选与反选
	$("#checkAll").click(function () {
		$(".son").prop("checked",$("#checkAll").prop("checked"))
	})
	function checkOneClue(){
		let eleLength = $(".son").length;
		let length = $(".son:checked").length;
		if (eleLength == length){
			$("#checkAll").prop("checked",true)
		}else {
			$("#checkAll").prop("checked",false)
		}
	}

	//修改页面-填充数据
	function edit_clue_select(){
		let length = $(".son:checked").length;
		$("#edit-clueOwner").find("option").each(function(){
			$(this).attr("selected",false);
		});

		$("#addForm")[0].reset()

		if(length == 1){
			$.ajax({
				url: "/crm/workbench/clue/queryCustomerById/"+$(".son:checked").val(),
				type: "get",
				dataType: "json",
				success: function (result) {

					fillingEditModal(result)
				}
			});
		}else if(length > 1) {
			layer.alert("亲，只能选择一个哦", {icon: 5});
		}else {
			layer.alert("亲，请选择一个哦", {icon: 5});
		}
	};
	//修改模态框填充值
	function fillingEditModal(result){
		let selected = result.owner;
		$("#edit-clueOwner").find("option").each(function(){
			if($(this).text() == selected)	{
				$(this).attr("selected",true);
			}
		});

		//$("#edit-clueOwner").val(result.owner)
		$("#edit-customerName").val(result.name)
		$("#edit-company").val(result.company)
		$("#edit-call").val(result.appellation)
		$("#edit-surname").val(result.fullname)
		$("#edit-job").val(result.job)
		$("#edit-email").val(result.email)
		$("#edit-phone").val(result.phone)
		$("#edit-website").val(result.website)
		$("#edit-mphone").val(result.mphone)
		$("#edit-status").val(result.state)
		$("#edit-source").val(result.source)
		$("#edit-describe").text(result.description)
		$("#edit-contactSummary").text(result.contactSummary)
		$("#edit-nextContactTime").val(result.nextContactTime)
		$("#edit-address").text(result.address)
		$("#edit-clue-id").val(result.id)

		//打开模态框
		$("#editClueModal").modal("show");
	}

	//修改-提交
	function updateClueFuc(){
		$.ajax({
			url: "/crm/workbench/clue/editClue",
			type: "post",
			data: $("#edit-clue-form").serialize(),
			dataType: "json",
			success: function (result) {
				if(result.ok){
					layer.alert("修改成功", {icon: 6});
					//关闭模态框
					$("#editClueModal").modal("hide");
					toPage(1, 3);
				}else {
					layer.alert(result.message, {icon: 5});
				}
			}
		});

	}

	//删除-多与单
	$("#clueDelBtn").click(function () {
		let length = $(".son:checked").length;
		if (length < 1){
			layer.alert("请至少选择一位", {icon: 5});
		}else {
			layer.confirm('确认删除选中的' + length + '条记录吗？', {icon: 3, title:'温馨提示'}, function(index){

				let ids = [];
				for (let i = 0;i < length;i++){
					let value = $(".son:checked")[i].value
					ids[i] = value;
				}
				$.ajax({
					url: "/crm/workbench/clue/deleteClue/"+ids.join(),
					type: "DELETE",
					dataType: "json",
					success: function (result) {
						if(result.ok){
							layer.alert("删除成功", {icon: 6});
							toPage(1, 3);
						}else {
							layer.alert(result.message, {icon: 5});
						}
					}
				});
				//index:按钮索引编号
				layer.close(index);},function () {});
		}
	})

	//新增模态框时间控件edit-nextContactTime
	$("#create-nextContactTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});
	$("#edit-nextContactTime").datetimepicker({
		language:  "zh-CN",
		format: "yyyy-mm-dd",//显示格式
		minView: "month",//设置只显示到月份
		initialDate: new Date(),//初始化当前日期
		autoclose: true,//选中自动关闭
		todayBtn: true, //显示今日按钮
		clearBtn : true,
		pickerPosition: "bottom-left"
	});

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