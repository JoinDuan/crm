<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
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
</head>
<body>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典值列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='/crm/toView/settings/dictionary/value/save'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button id="editDictionaryValueBtn" type="button" class="btn btn-default" ><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button onclick="deleteDictionaryValue()" type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="father" /></td>
					<td>字典值</td>
					<td>文本</td>
					<td>排序号</td>
					<td>字典类型编码</td>
				</tr>
			</thead>
			<tbody id="dictionaryValueTbody" >
				<%--<tr class="active">
					<td><input type="checkbox" class="son"/></td>
					<td>m</td>
					<td>男</td>
					<td>1</td>
					<td>sex</td>
				</tr>--%>

			</tbody>
		</table>
	</div>
	<div style="height: 50px; position: relative;top: 30px;">
		<div id="dictionaryValuePage">

		</div>
	</div>
	
</body>
<script>
	$(function () {
		refreshDictionaryValue(1,5)
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
	function refreshDictionaryValue(page,pageSize) {
		$.ajax({
			url: "/crm/settings/dictionary/queryValue",
			type: "get",
			data:{
				'page':page,
				'pageSize':pageSize
			},
			dataType: "json",
			success: function (pageInfo) {
				let list = pageInfo.list;
				$("#dictionaryValueTbody").html("")
				$.each(list,function (index,obj) {
					$("#dictionaryValueTbody").append("<tr class=\"active\">\n" +
							"\t\t\t\t\t<td><input onclick='selectOne()' value="+obj.id+" type=\"checkbox\" class=\"son\"/></td>\n" +
							"\t\t\t\t\t<td>"+obj.value+"</td>\n" +
							"\t\t\t\t\t<td>"+obj.text+"</td>\n" +
							"\t\t\t\t\t<td>"+obj.orderNo+"</td>\n" +
							"\t\t\t\t\t<td>"+obj.typeCode+"</td>\n" +
							"\t\t\t\t</tr>");
				})
				$("#dictionaryValuePage").bs_pagination({
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
						refreshDictionaryValue(page,rowsPerPage)
					}
				});
			}
		});

	}

	//全选与反选
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

	//删除
	function deleteDictionaryValue(){
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
						deleteDictionary(id);
						//index:按钮索引编号
						layer.close(index);
					},function () {});

		}
	}

	//删除函数
	function deleteDictionary(id) {
		$.ajax({
			url: "/crm/settings/dictionary/deleteValue",
			type: "DELETE",
			data: {"id":id},
			dataType: "json",
			success: function (result) {
				if(result.ok){
					layer.alert(result.message, {icon: 6});
				}else {
					layer.alert(result.message, {icon: 5});
				}
				refreshDictionaryValue(1,5)
			}
		});
	}


	//更新的函数
	$("#editDictionaryValueBtn").click(function () {
		//判断选择的数量
		let length = $(".son:checked").length;
		if(length == 1){
			window.location.href='/crm/toView/settings/dictionary/value/edit?id='+$(".son:checked").val();
		}else if(length == 0){
			layer.alert("亲，请至少选择一个修改", {icon: 5});
		}if(length > 1){
			layer.alert("亲，只能选择一个修改", {icon: 5});
		}

	});

</script>
</html>