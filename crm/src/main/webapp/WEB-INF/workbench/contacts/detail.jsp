<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
	<script src="/crm/jquery/layer/layer.js"></script>
<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});
		
		$(".remarkDiv").mouseover(function(){
			$(this).children("div").children("div").show();
		});
		
		$(".remarkDiv").mouseout(function(){
			$(this).children("div").children("div").hide();
		});
		
		$(".myHref").mouseover(function(){
			$(this).children("span").css("color","red");
		});
		
		$(".myHref").mouseout(function(){
			$(this).children("span").css("color","#E6E6E6");
		});
	});
	
</script>

</head>
<body id="boos">

	<!-- 解除联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="unbundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">解除关联</h4>
				</div>
				<div class="modal-body">
					<p>您确定要解除该关联关系吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">解除</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="bundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">关联市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">

						  <div class="form-group has-feedback">
						    <input type="text" id="searchContactsActivity" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>

					</div>
					<table id="activityTable2" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td><input type="checkbox" id="activityModalCheckbox"/></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="contactsActivityModalTbody">

							<%--<tr>
								<td><input type="checkbox"/></td>
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
					<button id="relationActivityBtn" type="button" class="btn btn-primary" data-dismiss="modal">关联</button>
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
					<h4 class="modal-title" id="myModalLabel">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-contactsOwner">
								  <option selected>zhangsan</option>
								  <option>lisi</option>
								  <option>wangwu</option>
								</select>
							</div>
							<label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-clueSource">
								  <option></option>
								  <option selected>广告</option>
								  <option>推销电话</option>
								  <option>员工介绍</option>
								  <option>外部介绍</option>
								  <option>在线商场</option>
								  <option>合作伙伴</option>
								  <option>公开媒介</option>
								  <option>销售邮件</option>
								  <option>合作伙伴研讨会</option>
								  <option>内部研讨会</option>
								  <option>交易会</option>
								  <option>web下载</option>
								  <option>web调研</option>
								  <option>聊天</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-surname" value="李四">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="edit-call">
								  <option></option>
								  <option selected>先生</option>
								  <option>夫人</option>
								  <option>女士</option>
								  <option>博士</option>
								  <option>教授</option>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-job" value="CTO">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-mphone" value="12345678901">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建" value="动力节点">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address1">北京大兴区大族企业湾</textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3>李四先生 <small> - 动力节点</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editContactsModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>zhangsan</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>广告</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>动力节点</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>李四先生</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>lisi@bjpowernode.com</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>12345678901</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>CTO</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-18 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-19 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					这是一条线索的描述信息 （线索转换之后会将线索的描述转换到联系人的描述中）
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 90px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b>
                    大族企业湾
                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	<!-- 备注 -->
	<div style="position: relative; top: 20px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">联系人</font> <font color="gray">-</font> <b>李四先生-北京动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>--%>

		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button onclick="saveActivityRemark('${id}')" type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable3" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>金额</td>
							<td>阶段</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>类型</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="contacts_tran">
						<%--<tr>
							<td><a href="../transaction/detail.jsp" style="text-decoration: none;">动力节点-交易01</a></td>
							<td>5,000</td>
							<td>谈判/复审</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>新业务</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a onclick="window.location.href='/crm/toView/workbench/transaction/save';" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="contactsActivityTbody">
						<%--<tr>
							<td><a href="../activity/detail.jsp" style="text-decoration: none;">发传单</a></td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
							<td>zhangsan</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a onclick="openContactsActivityModal()" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
<script>
	$(function () {
		$.ajax({
		    url: "/crm/workbench/contacts/detailAll/"+"${id}",
		    type: "get",
		    dataType: "json",
		    success: function (result) {
				refreshRemark(result)
				refreshTran(result.tranList)
				refreshTranActivity(result.activityList)
		    }
		});
	})

	//展现备注信息的函数
	function refreshRemark(result){
		let contactsRemark =  result.remarkList
		$.each(contactsRemark,function (index,obj) {
			$("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
					"\t\t\t<img title=\"zhangsan\" src="+obj.editFlag+" style=\"width: 30px; height:30px;\">\n" +
					"\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
					"\t\t\t\t<h5 id='h5"+obj.id+"'>"+obj.noteContent+"</h5>\n" +
					"\t\t\t\t<font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b>"+result.contacts.fullname+result.contacts.appellation+'-'+result.contacts.customerId+"</b> <small style=\"color: gray;\"> "+obj.createTime+" 由"+obj.createBy+"</small>\n" +
					"\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
					"\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
					"\t\t\t\t\t<a onclick=\"delContactsRemark('"+obj.id+"')\" class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t</div>\n" +
					"\t\t\t</div>\n" +
					"\t\t</div>")
		});
	};

	//展现交易
	function refreshTran(tranList){
		$("#contacts_tran").html("")
		$.each(tranList,function (index,tran) {
			$("#contacts_tran").append("<tr id='tr"+tran.id+"'>\n" +
					"\t\t\t\t\t\t\t<td><a href=\"../transaction/detail.jsp\" style=\"text-decoration: none;\">"+tran.name+"</a></td>\n" +
					"\t\t\t\t\t\t\t<td>"+tran.money+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+tran.stage+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+tran.possibility+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+tran.expectedDate+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+tran.type+"</td>\n" +
					"\t\t\t\t\t\t\t<td><a onclick=\"deleteContactsTran('"+tran.id+"')\" data-toggle=\"modal\" data-target=\"#unbundModal\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
					"\t\t\t\t\t\t</tr>")
		})
	};

	//展现市场活动
	function refreshTranActivity(activityList){
		$("#contactsActivityTbody").html("")
		$.each(activityList,function (index,activity) {
			$("#contactsActivityTbody").append("<tr id='tr"+activity.id+"'>\n" +
					"\t\t\t\t\t\t\t<td><a href=\"../activity/detail.jsp\" style=\"text-decoration: none;\">"+activity.name+"</a></td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.startDate+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.owner+"</td>\n" +
					"\t\t\t\t\t\t\t<td><a onclick=\"deleteContactsActivity('"+activity.id+"')\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>解除关联</a></td>\n" +
					"\t\t\t\t\t\t</tr>")
		})
	}

	//删除与联系人关联的交易
	function deleteContactsTran(tranId){
		$.ajax({
		    url: "/crm/workbench/contacts/deleteContactsTran/"+tranId,
		    type: "DELETE",
		    dataType: "json",
		    success: function (result) {
		        if(result.ok){
					layer.alert(result.message, {icon: 6});
					let trid = "#tr" + tranId;
					$(trid).remove();
				}else {
					layer.alert(result.message, {icon: 6});
				}

		    }
		});

	}

	//打开模态框
	function openContactsActivityModal(){
		$("#contactsActivityModalTbody").html("")
		$("#bundActivityModal").modal("show")

	}
	//关联市场活动
	$("#searchContactsActivity").keypress(function (event) {
		let keyCode = event.keyCode;
		if (keyCode == 13){
			$.ajax({
			    url: "/crm/workbench/contacts/searchContactsActivity",
			    type: "get",
			    data: {
			    	"activityName":$("#searchContactsActivity").val(),
					"contactsId":'${id}'
				},
			    dataType: "json",
			    success: function (result) {
			        console.log(result)
					$("#contactsActivityModalTbody").html("")
					$.each(result,function (index,activity) {
						$("#contactsActivityModalTbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input onclick='activityCheckedFun()' value="+activity.id+" class='activitySon' type=\"checkbox\"/></td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.name+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.startDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
								"\t\t\t\t\t\t\t\t<td>"+activity.owner+"</td>\n" +
								"\t\t\t\t\t\t\t</tr>")
					})
			    }
			});
		}
	})

	//市场活动全选与反选$
	$("#activityModalCheckbox").click(function () {
		$(".activitySon").prop("checked",$(this).prop("checked"))
	})
	function activityCheckedFun() {
		let length = $(".activitySon").length;
		let length1 = $(".activitySon:checked").length;
		if(length == length1){
			$("#activityModalCheckbox").prop("checked", true);
		}else {
			$("#activityModalCheckbox").prop("checked", false);
		}
	}

	//关联
	$("#relationActivityBtn").click(function () {
		let length = $(".activitySon").length;
		if (length < 1){
			layer.alert("请至少选择关联一个", {icon: 5});
		}else {
			let idArr = [];
			let length = $(".activitySon:checked").length;
			for (let i = 0; i < length; i++) {
				let value = $(".activitySon:checked")[i].value;
				idArr[i] = value;
			}
			relationActivityFuc(idArr.join())
		}
	})
	//关联的函数
	function relationActivityFuc(ids) {
		$.ajax({
			url: "/crm/workbench/contacts/relationActivity",
			type: "post",
			data: {
				"activityIds":ids,
				'contactsId':'${id}'
			},
			dataType: "json",
			success: function (result) {
				if(result.ok){
					//关闭模态框
					$("#bundActivityModal").modal("hide");
					layer.alert(result.message, {icon: 6});
					refreshTranActivity(result.t)
				}
			}
		});

	}

	//解除关联
	function deleteContactsActivity(activityId){
		$.ajax({
		    url: "/crm/workbench/contacts/deleteContactsActivity/"+activityId,
		    type: "DELETE",
		    dataType: "json",
		    success: function (result) {
				if(result.ok){
					layer.alert(result.message, {icon: 6});
					let trid = "#tr" + activityId;
					$(trid).remove();
				}else {
					layer.alert(result.message, {icon: 6});
				}
		    }
		});

	}

	//添加备注
	//新增备注信息
	function saveActivityRemark(id){
		$.ajax({
			url: "/crm/workbench/contacts/addRemark",
			type: "post",
			data: {
				"noteContent":$("#remark").val(),
				"contactsId":id
			},
			dataType: "json",
			success: function (result) {
				//console.log(result)
				$("#remark").val("")
				if(result.ok){
					location.reload()
					/*let activityRemarks = [];
					activityRemarks[0] = result.t
					console.log(activityRemarks)
					refreshRemarks(activityRemarks)*/
					layer.alert(result.message, {icon: 6});
				}
			}
		});
	}

	//删除备注
	//删除备注信息
	function delContactsRemark(id){
		layer.confirm('确认删除选中记录吗?', {icon: 3, title:'温馨提示'},
				function(index){
					$.ajax({
						url: "/crm/workbench/contacts/deleteRemark",
						type: "DELETE",
						data: {"remarkId":id},
						dataType: "json",
						success: function (result) {
							if(result.ok){
								layer.alert(result.message, {icon: 6});
								let delId = "#h5" + id;
								console.log(delId)
								$(delId).parent().parent().remove();
							}else {
								layer.alert(result.message, {icon: 5});
							}
						}
					});
					//index:按钮索引编号
					layer.close(index)},function () {});
	}


	$("#boos").on("mouseover",".remarkDiv",function () {
		$(this).children("div").children("div").show();
	})
	$("#boos").on("mouseout",".remarkDiv",function () {
		$(this).children("div").children("div").hide();
	})
	$("#boos").on("mouseover",".myHref",function () {
		$(this).children("span").css("color","red");
	})
	$("#boos").on("mouseout",".myHref",function () {
		$(this).children("span").css("color","#E6E6E6");
	})


</script>
</html>