<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
    <!-- 引入 ECharts 文件 -->
    <script src="/crm/jquery/ECharts/echarts.min.js"></script>
</head>
<body>
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <div id="bar" style="width: 1000px;height:400px;"></div>
    <%--饼图--%>
    <div id="pie" style="width: 600px;height:600px;"></div>
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var mybar = echarts.init(document.getElementById('bar'));
        var mypie = echarts.init(document.getElementById('pie'));

        $.ajax({
            url: "/crm/workbench/chart/transaction/bar",
            type: "get",
            dataType: "json",
            success: function (result) {

                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '交易详情'
                    },
                    tooltip: {},
                    legend: {
                        data:['交易']
                    },
                    xAxis: {
                        data: result.titles
                    },
                    yAxis: {},
                    series: [{
                        name: '销量',
                        type: 'bar',
                        data: result.data
                    }]
                };
                // 使用刚指定的配置项和数据显示图表。
                mybar.setOption(option);
            }
        });

        $.ajax({
            url: "/crm/workbench/chart/transaction/pie",
            type: "get",
            dataType: "json",
            success: function (result) {
                var option = {
                    title: {
                        text: '交易统计',
                        subtext: '交易统计',
                        left: 'center'
                    },
                    tooltip: {
                        trigger: 'item'
                    },
                    legend: {
                        orient: 'vertical',
                        left: 'left',
                    },
                    series: [
                        {
                            name: '交易详情',
                            type: 'pie',
                            radius: '50%',
                            data: result,
                            emphasis: {
                                itemStyle: {
                                    shadowBlur: 10,
                                    shadowOffsetX: 0,
                                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                                }
                            }
                        }
                    ]
                };
                // 使用刚指定的配置项和数据显示图表。
                mypie.setOption(option);
            }
        });

    </script>
</body>
</html>