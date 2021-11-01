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
<body>

<!-- 修改备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
	<%-- 备注的id --%>
	<input type="hidden" id="remarkId">
	<div class="modal-dialog" role="document" style="width: 40%;">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span>
				</button>
				<h4 class="modal-title" id="myModalLabel2">修改备注</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="edit-describe" class="col-sm-2 control-label">内容</label>
						<div class="col-sm-10" style="width: 81%;">
							<textarea class="form-control" rows="3" id="noteContent"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
			</div>
		</div>
	</div>
</div>

	<!-- 关联市场活动的模态窗口 -->
	<div class="modal fade" id="bundModal" role="dialog">
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
						    <input type="text" id="searchActivity" class="form-control" style="width: 300px;" placeholder="请输入市场活动名称，支持模糊查询">
						    <span class="glyphicon glyphicon-search form-control-feedback"></span>
						  </div>
					</div>
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
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
						<tbody id="activity_clue_tbody">
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
					<button id="relationActivityBtn" type="button" class="btn btn-primary">关联</button>
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
                    <h4 class="modal-title" id="myModalLabel">修改线索</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-clueOwner">
                                    <option>zhangsan</option>
                                    <option>lisi</option>
                                    <option>wangwu</option>
                                </select>
                            </div>
                            <label for="edit-company" class="col-sm-2 control-label">公司<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-company" value="动力节点">
                            </div>
                        </div>

                        <div class="form-group">
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
                            <label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-surname" value="李四">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-job" class="col-sm-2 control-label">职位</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-job" value="CTO">
                            </div>
                            <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-email" value="lisi@bjpowernode.com">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-phone" value="010-84846003">
                            </div>
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-mphone" value="12345678901">
                            </div>
                            <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-status">
                                    <option></option>
                                    <option>试图联系</option>
                                    <option>将来联系</option>
                                    <option selected>已联系</option>
                                    <option>虚假线索</option>
                                    <option>丢失线索</option>
                                    <option>未联系</option>
                                    <option>需要条件</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-source">
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
                            <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-describe">这是一条线索的描述信息</textarea>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="edit-contactSummary">这个线索即将被转换</textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="edit-nextContactTime" value="2017-05-01">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address">北京大兴区大族企业湾</textarea>
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
			<h3>李四先生 <small>动力节点</small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" onclick="window.location.href='/crm/toView/workbench/clue/convert?id=${id}';"><span class="glyphicon glyphicon-retweet"></span> 转换</button>
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editClueModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>李四先生</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>zhangsan</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">公司</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>动力节点</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>CTO</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>lisi@bjpowernode.com</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>010-84846003</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">公司网站</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>http://www.bjpowernode.com</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>12345678901</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">线索状态</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>已联系</b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>广告</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-18 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>zhangsan&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;">2017-01-19 10:10:10</small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					这是一条线索的描述信息
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b>
					这条线索即将被转换
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>2017-05-01</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 100px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b>
                    北京大兴大族企业湾
                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 40px; left: 40px;" id="boos">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">线索</font> <font color="gray">-</font> <b>李四先生-动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>--%>

		<div id="clueRemarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button onclick="saveClueRemark('${id}')" type="button" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="clueActivityBody">

						<%--<tr>
							<td>发传单</td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
							<td>zhangsan</td>
							<td><a href="javascript:void(0);"  style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a onclick="openActivityModal()" data-toggle="modal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>

<script>

	//加载详细信息与备注信息
	$(function () {
		$.ajax({
			url: "/crm/workbench/clue/queryCustomerAndRemarkAndActivity/"+"${id}",
			type: "get",
			dataType: "json",
			success: function (result) {
				let clue = result.clue;
				let clueRemark = result.clueRemark;
				let activity = result.activity;
				refresh(result)
			}
		});

	})

	//展现备注信息的函数
	function refresh(result){
		$.each(result.clueRemark,function (index,obj) {
			$("#clueRemarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
					"\t\t\t<img src="+obj.clueId+" style=\"width: 30px; height:30px;\">\n" +
					"\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
					"\t\t\t\t<h5 id='h5"+obj.id+"'>"+obj.noteContent+"</h5>\n" +
					"\t\t\t\t<font color=\"gray\">线索</font> <font color=\"gray\">-</font> <b>"+result.clue.fullname+result.clue.appellation+"__"+result.clue.company+"</b> <small style=\"color: gray;\"> "+obj.createTime+" 由"+obj.createBy+"</small>\n" +
					"\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
					"\t\t\t\t\t<a onclick=\"editClueRemark('"+obj.id+"','"+obj.noteContent+"')\" class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
					"\t\t\t\t\t<a onclick=\"delClueRemark('"+obj.id+"')\" class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t</div>\n" +
					"\t\t\t</div>\n" +
					"\t\t</div>")
		});
		//展现市场活动函数
		refreshActivity(result.activity)
	};

	//展示市场活动
	function refreshActivity(activitys) {
		$("#clueActivityBody").html("")
		$.each(activitys,function (index,activity) {
			$("#clueActivityBody").append("<tr id='tr"+activity.id+"'>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.name+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.startDate+"0</td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
					"\t\t\t\t\t\t\t<td>"+activity.owner+"</td>\n" +
					"\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"clueActivityNoRelation('"+activity.id+"')\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>解除关联</a></td>\n" +
					"\t\t\t\t\t\t</tr>")
		})
	};

	function openActivityModal(){
		$("#bundModal").modal("show")
		$("#activity_clue_tbody").html("")
	}

	//关联市场活动搜索
	$("#searchActivity").keypress(function (event) {
		let keyCode = event.keyCode;
		if(keyCode == 13){
			$.ajax({
			    url: "/crm/workbench/clue/queryActivityLike",
			    type: "GET",
				data:{
					'id':'${id}',
					'name':$("#searchActivity").val()
				},
			    dataType: "json",
			    success: function (result) {
					$("#activity_clue_tbody").html("")
					$.each(result,function (index,obj) {
						$("#activity_clue_tbody").append("<tr>\n" +
								"\t\t\t\t\t\t\t\t<td><input class='activitySon' onclick='activityCheckedFun()' value="+obj.id+" type=\"checkbox\"/></td>\n" +
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

	//市场活动全选与反选$
	$("#activityModalCheckbox").click(function () {
		$(".activitySon").prop("checked",$(this).prop("checked"))
	})
	function activityCheckedFun(){
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
		    url: "/crm/workbench/clue/relationActivity",
		    type: "post",
		    data: {
		    	"activityIds":ids,
				'clueId':'${id}'
			},
		    dataType: "json",
		    success: function (result) {
		        if(result.ok){
		        	//关闭模态框
					$("#bundModal").modal("hide");
					layer.alert(result.message, {icon: 6});
					refreshActivity(result.t)
				}
		    }
		});

	}

	//解除关联
	function clueActivityNoRelation(activityId) {
		let trId = "#tr" + activityId;
		layer.confirm('确认删除选中记录吗?', {icon: 3, title:'温馨提示'},
		function(index){
			$.ajax({
			    url: "/crm/workbench/clue/relationActivityDelete",
			    type: "DELETE",
			    data: {
			    	"activityId":activityId,
					"clueId":'${id}'
				},
			    dataType: "json",
			    success: function (result) {
					if(result.ok){
						layer.alert(result.message, {icon: 6});
						$(trId).remove();
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

	//修改备注信息-填充信息
	function editClueRemark(id,noteContent){
		//打开修改模态窗口
		$("#editRemarkModal").modal("show")
		$("#noteContent").val(noteContent)
		$("#remarkId").val(id)
	}
	//修改备注信息
	$("#updateRemarkBtn").click(function () {
		$.ajax({
			url: "/crm/workbench/clue/updateRemark",
			type: "PUT",
			data: {
				"id":$("#remarkId").val(),
				"noteContent":$("#noteContent").val()
			},
			dataType: "json",
			success: function (result) {
				//console.log(result)
				if(result.ok){
					let id = "#h5" + $("#remarkId").val();
					$(id).text($("#noteContent").val())
					//关闭模态框
					$("#editRemarkModal").modal("hide")
					//清空模态框文本内容
					$("#noteContent").text("")
					$("#remarkId").text("")
					layer.alert(result.message, {icon: 6});
				}else {
					layer.alert(result.message, {icon: 5});
				}

			}
		});

	})

	//新增备注信息
	function saveClueRemark(id){
		let noteContent = $("#remark").val();
		$.ajax({
			url: "/crm/workbench/clue/addRemark",
			type: "POST",
			data: {
				'clueId':id,
				'noteContent':noteContent
			},
			dataType: "json",
			success: function (result) {
				if (result.ok){
					layer.alert(result.message, {icon: 6});
					$("#remark").val("")
					let resultEle = result.t
					let obj = resultEle.clueRemark
					let clueEle = resultEle.clue

					$("#clueRemarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
							"\t\t\t<img src="+obj.clueId+" style=\"width: 30px; height:30px;\">\n" +
							"\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
							"\t\t\t\t<h5 id='h5"+obj.id+"'>"+obj.noteContent+"</h5>\n" +
							"\t\t\t\t<font color=\"gray\">线索</font> <font color=\"gray\">-</font> <b>"+clueEle.fullname+clueEle.appellation+"__"+clueEle.company+"</b> <small style=\"color: gray;\"> "+obj.createTime+" 由"+obj.createBy+"</small>\n" +
							"\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
							"\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
							"\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
							"\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
							"\t\t\t\t</div>\n" +
							"\t\t\t</div>\n" +
							"\t\t</div>")
				}else {
					layer.alert(result.message, {icon: 5});
				}
			}
		});

	}

	//删除备注信息
	function delClueRemark(id){
		layer.confirm('确认删除选中记录吗?', {icon: 3, title:'温馨提示'},
				function(index){
					$.ajax({
						url: "/crm/workbench/clue/deleteRemark",
						type: "DELETE",
						data: {"id":id},
						dataType: "json",
						success: function (result) {
							if(result.ok){
								layer.alert(result.message, {icon: 6});
								let delId = "#h5" + id;
								$(delId).parent().parent().remove();
							}
						}
					});
					//index:按钮索引编号
					layer.close(index)},function () {});
	}

</script>

</html>