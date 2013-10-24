<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationBasedAnalytics" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationData" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=SithAPI.getInstance();

    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.10&sensor=false&libraries=visualization"></script>
    <script src="js/jquery-1.7.1.min.js"></script>
    <script src='<%=SithAPI.SOCKET_API%>/socket.io/socket.io.js'></script>
    <script type="text/javascript">
        var map;
        var master_perception = new Array("happy","excited","neutral","sad","horrible");
        var perception_marker_map = new Object();
        perception_marker_map["Happy"]= 'images/markers/green.ico';
        perception_marker_map["Excited"]= 'images/markers/orange.ico';
        perception_marker_map["Neutral"]= 'images/markers/yellow.ico';
        perception_marker_map["Sad"]= 'images/markers/blue.ico';
        perception_marker_map["Horrible"]= 'images/markers/red.ico';

        function initialize() {
            var srilanka = new google.maps.LatLng(7.87305,79.8612);

            map = new google.maps.Map(document.getElementById('map-canvas'), {
                center: srilanka,
                zoom: 7,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            });

        }
        function drawRealTimePerception(perception, longitude, latitude){
            var location = new google.maps.LatLng(latitude, longitude);
            var markerImage = perception_marker_map[perception];
            var marker = new google.maps.Marker({
                position: location,
                map: map,
                icon: markerImage,
                title: 'Hello World!',
                animation:google.maps.Animation.DROP
            });
        }
        google.maps.event.addDomListener(window, 'load', initialize);
        $(document).ready(function(){
            var socket = io.connect('<%=SithAPI.SOCKET_API%>');
            socket.on('connect', function(){
                socket.emit('realtimeMap', '<%=session.getAttribute("user").toString()%>');
            });
            socket.on('cepMapNotification', function(data){
                drawRealTimePerception(data.perception,data.long,data.lat);
            });
        });
     </script>
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
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#128711;&thinsp;</span>How World Feels</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Heat Map</a></li>
                <li><a href="piChartAnalytics.jsp"></span>Pi Chart</a></li>
            </ul>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>How I Feel</a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span>Location Based</a></li>
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
                <h1>Location Based Real-time Analytics</h1>
            </hgroup>
        </header>
        <div class="content">

            <div id="panel" style="background-color:transparent;float: right" align='left' >
                <ul align='left'>
                    <div style="margin:10px;background-color:#F87217;width:70px;height:20px;border:1px solid #000;text-align:center">Excited</div>
                    <div style="margin:10px;background-color:#46a546;width:70px;height:20px;border:1px solid #000;text-align:center">Happy</div>
                    <div style="margin:10px;background-color:#f09a2b;width:70px;height:20px;border:1px solid #000;text-align:center">Neutral</div>
                    <div style="margin:10px;background-color:#111680;width:70px;height:20px;border:1px solid #000;text-align:center">Sad</div>
                    <div style="margin:10px;background-color:#cd0a0a;width:70px;height:20px;border:1px solid #000;text-align:center">Horrible</div>
                </ul>
            </div>
            <%--<div id="panel1">--%>
                <%--<button onclick="drawRealTimePerception('happy',41.850033,-87.6500523)">Draw</button>--%>
                <%--<button onclick="drawRealTimePerception('sad',41.860133,-87.6402523)">Draw</button>--%>
                <%--<button onclick="drawRealTimePerception('neutral',41.872033,-87.6600623)">Draw</button>--%>
                <%--<button onclick="drawRealTimePerception('horrible',41.870133,-87.6302523)">Draw</button>--%>
                <%--<button onclick="drawRealTimePerception('excited',41.842033,-87.6400623)">Draw</button>--%>

            <%--</div>--%>
            <div id="map-canvas"></div>
        </div>
    </section>
</section>

<script src="js/jquery-ui.js"></script>
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
