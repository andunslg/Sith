<!DOCTYPE HTML>
<html>
<head>
    <%
        String subcriptionID=request.getParameter("subcriptionID");
        String subcriptionName=request.getParameter("subcriptionName");
        String subsciberID = request.getParameter("subscriberID");
    %>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title><%=subcriptionName%></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.css">
    <script src="http://code.jquery.com/jquery-2.0.1.min.js"></script>
    <script src="http://code.jquery.com/mobile/1.3.1/jquery.mobile-1.3.1.min.js"></script>
    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="../mobile/js/percepTimeAnalysisMob.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            countTimeChartMob('http://192.248.8.246:3000/getSelfAnalytics?userID=<%=subsciberID%>');
        });
    </script>
</head>
<body>
<div data-role="page">
    <div data-role="content">
        <label for="perceptions" class="select">Graph Type:</label>
        <select name='perceptions' id="perceptions" data-mini="true"></select><br>
        <div id="TimeAnalysis" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
    </div>
</div>

</body>
</html>
