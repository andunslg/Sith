<!DOCTYPE HTML>
<html>
<head>
    <%
        String subcriptionID=request.getParameter("subcriptionID");
        String subcriptionName=request.getParameter("subcriptionName");
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><%=subcriptionName%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css">
    <script src="http://code.jquery.com/jquery-2.0.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="../mobile/js/percepCountMob.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            var perceptions;
            $.get('http://192.248.8.246:3000/countPerceptionsMapReduce?eventID=<%=subcriptionID%>', function (data) {
                if(typeof data=='string' || data instanceof String){
                    var dataparsed = JSON.parse(data);

                }else{
                    var dataparsed = data;
                }
                var perceptions = new Array();
                var values  = new Array();
                var valueArray = new Array();
                for(percep in dataparsed){
                    perceptions.push(percep);
                    values.push(dataparsed[percep])
                    var val = new Array();
                    val.push(percep);
                    val.push(dataparsed[percep]);
                    valueArray.push(val);
                }
                barChart(perceptions, values);
                $("#chartType").change(function () {
                    if ($('#chartType').val() == 'bar') {
                        barChart(perceptions,values);
                    } else {
                        pieChart(valueArray);
                    }
                });
            });
        })
    </script>
</head>
<body>
<div data-role="page">
    <div data-role="content">
        Chart Type
        <select id='chartType' data-mini="true">
            <option value="bar">Bar Chart</option>
            <option value="pie">Pie Chart</option>
        </select>
        <div id="CountChart" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
    </div>
</div>



</body>
</html>
