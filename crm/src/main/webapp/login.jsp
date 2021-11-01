<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/crm/jquery/jquery-3.6.0.js"></script>
    <script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script src="/crm/jquery/layer/layer.js"></script>
</head>
<body id="body">
<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
    <img src="image/IMG_7114.JPG" style="width: 100%; position: relative; top: 50px;">
</div>
<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
    <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">
        CRM &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;动力节点</span></div>
</div>

<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
    <div style="position: absolute; top: 0px; right: 60px;">
        <div class="page-header">
            <h1>登录</h1>
        </div>
        <form action="workbench/index.html" class="form-horizontal" role="form">
            <div class="form-group form-group-lg">
                <div style="width: 350px;">
                    <input class="form-control" id="loginAct" type="text" placeholder="用户名">
                </div>
                <div style="width: 350px; position: relative;top: 20px;">
                    <input class="form-control" id="loginPwd" type="password" placeholder="密码">
                </div>
                <div class="checkbox" style="position: relative;top: 30px; left: 10px;">

                    <span id="msg"></span>

                </div>
                <button type="button" onclick="loginBtn()" id="login" class="btn btn-primary btn-lg btn-block"
                        style="width: 350px; position: relative;top: 45px;">登录
                </button>
            </div>
        </form>
    </div>
</div>
</body>
<script>
    //点击登陆触发
    function loginBtn() {
        if (MyInitialize() == true) {
            $.ajax({
                url: "/crm/settings/user/login",
                type: "post",
                dataType:"json",
                data: {
                    "loginPwd":$("#loginPwd").val(),
                    "loginAct":$("#loginAct").val(),
                },
                success: function (result) {
                    if(!result.ok){
                        layer.alert(result.message, {icon: 5});
                    }else {
                        location.href = ("/crm/toView/workbench/index");
                    }
                }
            });
        }
    }

    //键盘按下触发
    $("#body").keypress(function (event) {
        //alert(event.keyCode)
        if (event.keyCode == 13) {
            if (MyInitialize() == true) {
                $.ajax({
                    url:"/crm/settings/user/login",
                    type:"post",
                    dataType:"json",
                    data: {
                        "loginPwd":$("#loginPwd").val(),
                        "loginAct":$("#loginAct").val(),
                    },
                    success: function (result) {
                        if(!result.ok){
                            layer.alert(result.message, {icon: 5});
                        }else {
                            location.href = ("/crm/toView/workbench/index");
                        }

                    }
                });
            }
        }
    });

    //判断是否输入
    function MyInitialize() {
        let loginPwd = $("#loginPwd").val();
        let loginAct = $("#loginAct").val();
        //console.log(loginAct)
        //console.log(loginPwd)
        if (loginAct == "" || loginAct == null) {
            alert("用户名不可以为空")
            return false;
        }
        if (loginPwd == "" || loginPwd == null) {
            alert("密码不可以为空")
            return false;
        }
        return true;
    }

</script>
</html>