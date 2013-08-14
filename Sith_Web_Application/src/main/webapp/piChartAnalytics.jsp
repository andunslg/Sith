<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationBasedAnalytics" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.PerceptionsOnLocation" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=SithAPI.getInstance();

    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
    LocationBasedAnalytics pieChartAnalytics = new LocationBasedAnalytics();
    HashMap<String,PerceptionsOnLocation> pieChartData = pieChartAnalytics.getPerceptionsOnLocation();
    int length = pieChartData.size();

%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">

    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all"/>
    <%--<link href="http://code.google.com//apis/maps/documentation/javascript/examples/default.css" rel="stylesheet" type="text/css">--%>

    <script src="https://maps.googleapis.com/maps/api/js?v=3.10&sensor=false&.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi?.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> Welcome
                back <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
            <%--<span class="button dropdown">--%>
            <%--<a href="#">Notifications <span class="pip"></span></a>--%>
            <%--<ul class="notice">--%>
            <%--<li>--%>
            <%--<hgroup>--%>
            <%--<h1>You have no notifications</h1>--%>
            <%--</hgroup>--%>
            <%--</li>--%>
            <%--</ul>--%>
            <%--</span>--%>
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span>My Events</a></li>
                <li><a href="joinEvents.jsp"></span>Join Events</a></li>
                <li><a href="addEvents.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>How World Feels</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Heat Map</a></li>
                <li><a href="piChartAnalytics.jsp"></span>Pi Chart</a></li>
            </ul>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>How I Feel</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Location Based</a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span>Time Based</a></li>
            </ul>
        </li>
    </ul>
</nav>


<section class="content" style="margin-top: 10px">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Pie Chart Analytics</h1>
            </hgroup>
        </header>
        <div class="content">

            <div id="map_canvas" style="width: 900px; height: 500px;"></div>

        </div>
    </section>
</section>

<script>
    google.load( 'visualization', '1', { packages:['corechart'] });

    function drawChart(marker, data) {


        var options = {'title':'Perception Analysis ',
            'width':400,
            'height':150,
            slices: {0: {color: 'orange'}, 1:{color: 'green'}, 2:{color: 'yellow'}, 3: {color: 'blue'}, 4:{color: 'red'}}};

        var node        = document.createElement('div'),
                infoWindow  = new google.maps.InfoWindow(),
                chart       = new google.visualization.PieChart(node);

        chart.draw(data, options);
        infoWindow.setContent(node);
        infoWindow.open(marker.getMap(),marker);
    }

    function ChartMarker( options ) {
        this.setValues( options );

        this.$inner = $('<div>').css({
            position: 'relative',
            left: '-50%', top: '-50%',
            width: options.width,
            height: options.height,
            fontSize: '1px',
            lineHeight: '1px',
            padding: '2px',
            backgroundColor: 'transparent',
            cursor: 'default'
        });

        this.$div = $('<div>')
                .append( this.$inner )
                .css({
                    position: 'absolute',
                    display: 'none'
                });
    };

    ChartMarker.prototype = new google.maps.OverlayView;

    ChartMarker.prototype.onAdd = function() {
        $( this.getPanes().overlayMouseTarget ).append( this.$div );
    };

    ChartMarker.prototype.onRemove = function() {
        this.$div.remove();
    };

    ChartMarker.prototype.draw = function() {
        var marker = this;
        var projection = this.getProjection();
        var position = projection.fromLatLngToDivPixel( this.get('position') );

        this.$div.css({
            left: position.x,
            top: position.y,
            display: 'block'
        })

        this.$inner
                .html( '<img src="' + this.get('image') + '"/>' )
                .click( function( event ) {
                    var events = marker.get('events');
                    events && events.click( event );
                });

        this.chart = new google.visualization.PieChart( this.$inner[0] );
        this.chart.draw( this.get('chartData'), this.get('chartOptions') );
    };

    var markers = new Array();
    var latLng = new google.maps.LatLng(6.999, 80.101749)

    var mapOptions = {
        center: latLng,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);

    function drawPieChartsOnMap(lat1,lat2,long1,long2){

        <%
        for(String key:pieChartData.keySet()){
        PerceptionsOnLocation p = pieChartData.get(key);
        String[] locationData = key.split("/");
        %>
        if(lat1<=<%=locationData[0]%> && lat2>=<%=locationData[0]%> && long1<=<%=locationData[1]%> && long2>=<%=locationData[1]%>){
        var pie_chart_latlng = new google.maps.LatLng(<%=locationData[0]%>,<%=locationData[1]%>)

        var data = google.visualization.arrayToDataTable([
            [ 'Perception', '%' ],
            [ 'Excited',<%=p.getExcitedCount()%>],
            [ 'Happy',<%=p.getHappyCount()%>],
            [ 'Neutral',<%=p.getNeutralCount()%>],
            [ 'Sad',<%=p.getSadCount()%>],
            [ 'Horrible',<%=p.getHappyCount()%>]
        ]);

        var options = {

            fontSize: 8,
            backgroundColor: 'transparent',
            legend: {position: 'none'},
            slices: {0: {color: 'orange'}, 1:{color: 'green'}, 2:{color: 'yellow'}, 3: {color: 'blue'}, 4:{color: 'red'}}
        };

        var marker = new ChartMarker({
            map: map,
            position: pie_chart_latlng,
            width: '250px',
            height: '100px',
            chartData: data,
            chartOptions: options,
            events: {
                click: function( event ) {
                    drawChart(marker,data)
                }
            }
        });

        }
        <%
        }
        %>
    }
    function initialize() {
        google.maps.event.addListener(map, 'bounds_changed', function() {
            var bounds = map.getBounds();
            var ne = bounds.getNorthEast(); // LatLng of the north-east corner
            var sw = bounds.getSouthWest(); // LatLng of the south-west corder

            drawPieChartsOnMap(sw.lat(),ne.lat(),sw.lng(),ne.lng());
        });
    };
    google.maps.event.addDomListener(window, 'load', initialize);


</script>

<script src="js/jquery.wysiwyg.js"></script>
<script src="js/custom.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.checkbox.min.js"></script>
<script src="js/flot.js"></script>
<script src="js/flot.resize.js"></script>
<script src="js/flot-graphs.js"></script>
<script src="js/flot-time.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.tablesorter.min.js"></script>


</body>
</html>
