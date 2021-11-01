<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="/crm/jquery/jquery-3.6.0.js"></script>
<script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script src="/crm/jquery/layer/layer.js"></script>
	<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
	<script type="text/javascript" src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
	<link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript" src="/crm/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
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

	<!-- 修改用户备注的模态窗口 -->
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

	<!-- 删除联系人的模态窗口 -->
	<div class="modal fade" id="removeContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">删除联系人</h4>
				</div>
				<div class="modal-body">
					<p>您确定要删除该联系人吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">删除</button>
				</div>
			</div>
		</div>
	</div>

    <!-- 删除交易的模态窗口 -->
    <div class="modal fade" id="removeTransactionModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">删除交易</h4>
                </div>
                <div class="modal-body">
                    <p>您确定要删除该交易吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger" data-dismiss="modal">删除</button>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="create-customer-contacts" role="form">
					
						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" id="create-contactsOwner" name="owner">
								  <c:forEach items="${users}" var="user">
									  <option value="${user.id}">${user.name}</option>
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
                                <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" name="contactSummary" id="edit-contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control time" name="nextContactTime" id="edit-nextContactTime">
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
					<button onclick="createConsumerContacts()" type="button" class="btn btn-primary" data-dismiss="modal">保存</button>
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
                    <form class="form-horizontal" role="form">

                        <div class="form-group">
                            <label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-customerOwner">
                                    <option>zhangsan</option>
                                    <option>lisi</option>
                                    <option>wangwu</option>
                                </select>
                            </div>
                            <label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-customerName" value="动力节点">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-website" value="http://www.bjpowernode.com">
                            </div>
                            <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-phone" value="010-84846003">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-describe"></textarea>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" id="create-contactSummary1"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" id="create-nextContactTime2">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" id="edit-address">北京大兴大族企业湾</textarea>
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
			<h3 id="bigTitleName"><small><a href="http://www.bjpowernode.com" target="_blank" id="bigTitleWebsite"></a></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editCustomerModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="owner"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="name"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">公司网站</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="website"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="phone"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy">&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="createTime"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy">&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="editTime"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 40px;">
            <div style="width: 300px; color: gray;">联系纪要</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="contactSummary"></b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
        <div style="position: relative; left: 40px; height: 30px; top: 50px;">
            <div style="width: 300px; color: gray;">下次联系时间</div>
            <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="nextContactTime"></b></div>
            <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
        </div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="description"></b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 70px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="address"></b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 10px; left: 40px;" id="boos">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="" style="width: 30px; height:30px;">
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
					<button type="button" class="btn btn-primary" onclick="saveCustomerRemark('${id}')" >保存</button>
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
				<table id="activityTable2" class="table table-hover" style="width: 900px;">
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
					<tbody id="customerTranTbody">
						<%--<tr>
							<td><a href="../transaction/detail.jsp" style="text-decoration: none;">动力节点-交易01</a></td>
							<td>5,000</td>
							<td>谈判/复审</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>新业务</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeTransactionModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="/crm/toView/workbench/transaction/save" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	<!-- 联系人 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>联系人</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>邮箱</td>
							<td>手机</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="contactsTbody">
						<%--<tr>
							<td><a href="../contacts/detail.jsp" style="text-decoration: none;">李四</a></td>
							<td>lisi@bjpowernode.com</td>
							<td>13543645364</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" data-toggle="modal" data-target="#createContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建联系人</a>
			</div>
		</div>
	</div>
	
	<div style="height: 200px;"></div>
</body>

<script>

	//加载详细信息与备注信息
	$(function () {
		$.ajax({
		    url: "/crm/workbench/customer/queryAllRemark/"+"${id}",
		    type: "get",
		    dataType: "json",
		    success: function (result) {
				let customer = result.customer;
				let customerRemark = result.customerRemark;
				$("#owner").text(customer.owner)
				$("#name").text(customer.name)
				$("#website").text(customer.website)
				$("#phone").text(customer.phone)
				$("#createBy").text(customer.createBy+" ")
				$("#createTime").text(customer.createTime)
				$("#editBy").text(customer.editBy+" ")
				$("#editTime").text(customer.editTime)
				$("#contactSummary").text(customer.contactSummary)
				$("#nextContactTime").text(customer.nextContactTime)
				$("#description").text(customer.description)
				$("#address").text(customer.address)
				$("#bigTitleWebsite").text(customer.website)
				$("#bigTitleName").text(customer.name)
				refresh(result.customerRemark)
		    }
		});
		//联系人
		contactsList();
		//交易
		refreshCustomerTran();
	})

	//展现备注信息的函数
	function refresh(customerRemark){
		$.each(customerRemark,function (index,obj) {
			$("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
					"\t\t\t<img title=\"zhangsan\" src="+obj.imag+" style=\"width: 30px; height:30px;\">\n" +
					"\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
					"\t\t\t\t<h5 id='h5"+obj.id+"'>"+obj.noteContent+"</h5>\n" +
					"\t\t\t\t<font color=\"gray\">客户</font> <font color=\"gray\">-</font> <b>"+obj.customerId+"</b> <small style=\"color: gray;\"> "+obj.createTime+" 由"+obj.createBy+"</small>\n" +
					"\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
					"\t\t\t\t\t<a class=\"myHref\" onclick=\"editCustomerRemark('"+obj.noteContent+"','"+obj.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
					"\t\t\t\t\t<a class=\"myHref\" onclick=\"delCustomerRemark('"+obj.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
					"\t\t\t\t</div>\n" +
					"\t\t\t</div>\n" +
					"\t\t</div>")
		});
	};

	//展现交易信息
	function refreshCustomerTran(){
		$.ajax({
		    url: "/crm/workbench/customer/queryAllTran/"+"${id}",
		    type: "GET",
		    dataType: "json",
		    success: function (result) {
		        //console.log(result)
				let tranList = result.tran
				let customer = result.customer
				$("#customerTranTbody").empty()
				$.each(tranList,function (index,tran) {
					$("#customerTranTbody").append("<tr>\n" +
							"\t\t\t\t\t\t\t<td>" +
							"<a href=\"../transaction/detail.jsp\" style=\"text-decoration: none;\">"+customer.name+"-"+tran.name+"</a></td>\n" +
							"\t\t\t\t\t\t\t<td>"+tran.money+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+tran.stage+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+tran.possibility+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+tran.expectedDate+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+tran.type+"</td>\n" +
							"\t\t\t\t\t\t\t<td><a onclick=\"deleteTran('"+tran.id+"')\"" +
							"data-toggle=\"modal\"" +
							"style=\"text-decoration: none;\">" +
							"<span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
							"\t\t\t\t\t\t</tr>")
				})

		    }
		});

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
	function editCustomerRemark(noteContent,id){
		//打开修改模态窗口
		$("#editRemarkModal").modal("show")
		$("#noteContent").val(noteContent)
		$("#remarkId").val(id)
	}
	//修改备注信息
	$("#updateRemarkBtn").click(function () {
		$.ajax({
		    url: "/crm/workbench/customer/editRemark",
		    type: "post",
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
				}
				//关闭模态框
				$("#editRemarkModal").modal("hide")
				//清空模态框文本内容
				$("#noteContent").text("")
				$("#remarkId").text("")
		    }
		});

	})

	//新增备注信息
	function saveCustomerRemark(id){
		let noteContent = $("#remark").val();
		$.ajax({
		    url: "/crm/workbench/customer/addRemark",
		    type: "POST",
		    data: {
		    	'id':id,
				'noteContent':noteContent
			},
		    dataType: "json",
		    success: function (result) {
				if (result.ok){
					layer.alert(result.message, {icon: 6});
					$("#remark").val("")
					let remarkObj = result.t
					let remarkArr = []
					remarkArr[0] = remarkObj;
					refresh(remarkArr)
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	}

	//删除备注信息
	function delCustomerRemark(id){
		layer.confirm('确认删除选中记录吗?', {icon: 3, title:'温馨提示'},
			function(index){
			$.ajax({
			    url: "/crm/workbench/customer/delRemark",
			    type: "post",
			    data: {"id":id},
			    dataType: "json",
			    success: function (result) {
			    	if(result.ok){
						layer.alert(result.message, {icon: 6});
						let delId = "#h5" + id;
						console.log(delId)
						$(delId).parent().parent().remove();
					}
			    }
			});
			//index:按钮索引编号
			layer.close(index)},function () {});
	}

	//联系人-信息展示
	function contactsList(){
		$.ajax({
			url: '/crm/workbench/contacts/getContactsByCustomerId/'+'${id}',
			type: 'get',
			dataType: 'json',
			success : function(result){
				//清空上一次拼接的数据
				$('#contactsTbody').html("");
				$.each(result,function (index,obj) {
					//后台传递的每页的总数据
					$("#contactsTbody").append("<tr id='tr"+obj.id+"'>\n" +
							"\t\t\t\t\t\t\t<td><a href=\"../contacts/detail.jsp\" style=\"text-decoration: none;\">"+obj.fullname+"</a></td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.email+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+obj.mphone+"</td>\n" +
							"\t\t\t\t\t\t\t<td><a onclick=\"deleteContactById('"+obj.id+"')\" data-toggle=\"modal\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
							"\t\t\t\t\t\t</tr>");
				});

			}
		})};

	//删除单个；联系人
	function deleteContactById(id){
		$.ajax({
		    url: "/crm/workbench/contacts/delContacts",
		    type: "post",
		    data: {"ids":id},
		    dataType: "json",
		    success: function (result) {
		        console.log(result)
		        if(result.ok){
					layer.alert(result.message, {icon: 6});
					let trId = "#tr" + id;
					$(trId).remove();
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});

	}

	//新建联系人
	function createConsumerContacts(){
		$.ajax({
		    url: "/crm/workbench/consumer/addContacts",
		    type: "post",
		    data: $("#create-customer-contacts").serialize(),
		    dataType: "json",
		    success: function (result) {
		    	if(result.ok){
					layer.alert(result.message, {icon: 6});
					$("#create-customer-contacts")[0].reset()
					//刷新联系人
					contactsList();
				}else {
					layer.alert(result.message, {icon: 5});
				}
		    }
		});
	}

	//删除交易
	function deleteTran(tranId){

		layer.confirm('确认删除选中的记录吗？', {icon: 3, title:'温馨提示'}, function(index){

			$.ajax({
				url: "/crm/workbench/customer/deleteTran/"+tranId,
				type: "DELETE",
				dataType: "json",
				success: function (result) {
					if(result.ok){
						layer.alert("删除成功", {icon: 6});
						refreshCustomerTran()
					}else {
						layer.alert(result.message, {icon: 5});
					}
				}
			});
			//index:按钮索引编号
			layer.close(index);},function () {});

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

	//日期插件
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