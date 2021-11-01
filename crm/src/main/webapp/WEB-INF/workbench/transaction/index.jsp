<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<link href="/crm/jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm//jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
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

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" type="text" id="owner">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" type="text" id="name">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" type="text" id="customerId">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="stage">
					  	<option></option>
					  	<s:forEach items="${map['stage']}" var="stage">
							<option value="${stage.value}">${stage.text}</option>
						</s:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="type">
					  	<option></option>
						  <s:forEach items="${map['transactionType']}" var="transactionType">
							  <option value="${transactionType.value}">${transactionType.text}</option>
						  </s:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="create-clueSource">
						  <option></option>
						  <s:forEach items="${map['source']}" var="source">
							  <option value="${source.value}">${source.text}</option>
						  </s:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" type="text" id="contactsId">
				    </div>
				  </div>
				  
				  <button onclick="refreshTransaction(1,3)" type="button" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='/crm/toView/workbench/transaction/save';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick='redirectEdit()'><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button id="tranDelBtn" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="checkAll"/></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="transactionTbody">

                        <%--<tr class="active">
                            <td><input type="checkbox" /></td>
                            <td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">动力节点-交易01</a></td>
                            <td>动力节点</td>
                            <td>谈判/复审</td>
                            <td>新业务</td>
                            <td>zhangsan</td>
                            <td>广告</td>
                            <td>李四</td>
                        </tr>--%>
					</tbody>
				</table>
			</div>

			<%--分页--%>
			<div style="height: 50px; position: relative;top: 20px;">
				<div id="listDiv">

				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$(function () {
		refreshTransaction(1,3)
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

	//查询数据
	function refreshTransaction(page,pageSize) {
		$.ajax({
			url: "/crm/workbench/transaction/queryAllTransaction",
			type: "POST",
			data: {
				"page":page,
				"pageSize":pageSize,
				"contactsId":$("#contactsId").val(),
				"source":$("#create-clueSource").val(),
				"type":$("#type").val(),
				"stage":$("#stage").val(),
				"customerId":$("#customerId").val(),
				"name":$("#name").val(),
				"owner":$("#owner").val()
			},
			dataType: "json",
			success: function (pageInfo) {
				let data = pageInfo.list;
				$("#transactionTbody").html("")
				$.each(data,function (index,obj) {
					$("#transactionTbody").append("<tr class=\"active\">\n" +
							"                            <td><input onclick='checkOneClue()' value="+obj.id+" class='son' type=\"checkbox\" /></td>\n" +
							"                            <td><a style=\"text-decoration: none; cursor: pointer;\" " +
							"onclick=\"window.location.href='/crm/toView/workbench/transaction/detail?id="+obj.id+"';\">"+obj.customerId+"-"+obj.name+"</a></td>\n" +
							"                            <td>"+obj.customerId+"</td>\n" +
							"                            <td>"+obj.stage+"</td>\n" +
							"                            <td>"+obj.type+"</td>\n" +
							"                            <td>"+obj.owner+"</td>\n" +
							"                            <td>"+obj.source+"</td>\n" +
							"                            <td>"+obj.contactsId+"</td>")
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
						refreshTransaction(page,rowsPerPage)
					}
				});

			}
		});
	}

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
	//删除
	//删除-多与单
	$("#tranDelBtn").click(function () {
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
					url: "/crm/workbench/tran/deleteTran/"+ids.join(),
					type: "DELETE",
					dataType: "json",
					success: function (result) {
						if(result.ok){
							layer.alert("删除成功", {icon: 6});
							refreshTransaction(1, 3);
						}else {
							layer.alert(result.message, {icon: 5});
						}
					}
				});
				//index:按钮索引编号
				layer.close(index);},function () {});
		}
	})

	//跳转修改页
	function redirectEdit(){
		let length = $(".son:checked").length;
		if (length == 1){
			window.location.href='/crm/toView/workbench/transaction/edit?id='+$(".son:checked").val()
		}else if (length < 1){
			layer.alert("请选择一个进行修改", {icon: 5});
		}else {
			layer.alert("只能选择一个进行修改", {icon: 5});
		}
	}

</script>
</html>