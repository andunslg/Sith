<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationBasedAnalytics" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationData" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=SithAPI.getInstance();

    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
    LocationBasedAnalytics heatMapAnalytics = new LocationBasedAnalytics();

    ArrayList<LocationData> happyData = heatMapAnalytics.getHappyCount("0","0","1000","1000");
    ArrayList<LocationData> sadData = heatMapAnalytics.getSadCount("0","0","1000","1000");
    ArrayList<LocationData> neutralData = heatMapAnalytics.getNeutralCount("0","0","1000","1000");
    ArrayList<LocationData> horribleData = heatMapAnalytics.getHorribleCount("0","0","1000","1000");
    ArrayList<LocationData> excitedData = heatMapAnalytics.getExcitingCount("0","0","1000","1000");

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
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <script src="https://maps.googleapis.com/maps/api/js?v=3.10&sensor=false&libraries=visualization"></script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 15px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong><fmt:message key="sith.dashboard.dashboard" /></h1>
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
            <a href="#"><span class="icon"><i class="fa fa-sign-in fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.events" /></a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span><fmt:message key="sith.dashboard.menu.myEvents" /></a></li>
                <li><a href="joinEvents.jsp"></span><fmt:message key="sith.dashboard.menu.joinEvents" /></a></li>
                <li><a href="addEvents.jsp"></span><fmt:message key="sith.dashboard.menu.addEvents" /></a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon"><i class="fa fa-user fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.profile" /></a>
        </li>
        <li>
            <a href="newsFeed.jsp"><span class="icon"><i class="fa fa-file-text-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.newsfeed" /></a>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-globe fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.worldAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.heatMap" /></a></li>
                <li><a href="piChartAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.piChart" /></a></li>
                <li><a href="realtimeHeatMapAnalytics.jsp"></span>Real Time Analytics</a></li>
            </ul>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-smile-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.myAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.locationBased" /></a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.timeBased" /></a></li>
            </ul>
        </li>
    </ul>
</nav>
<section class="content" style="margin-top: 10px">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Location Based Analytics</h1>
            </hgroup>
        </header>
        <div class="content">
            <div>
                <select name="options">
                    <option value="1">Excited</option>
                    <option value="2" selected="1">Happy</option>
                    <option value="3">Neutral</option>
                    <option value="4">Sad</option>
                    <option value="5">Horrible</option>
                </select>
                <br>
                <br>
            </div>

            <%--<div id="panel" style="background-color:transparent;float: right" align='left' >--%>
                <%--<ul align='left'>--%>
                    <%--<div style="margin:10px;background-color:#F87217;width:70px;height:20px;border:1px solid #000;text-align:center">Excited</div>--%>
                    <%--<div style="margin:10px;background-color:#46a546;width:70px;height:20px;border:1px solid #000;text-align:center">Happy</div>--%>
                    <%--<div style="margin:10px;background-color:#f09a2b;width:70px;height:20px;border:1px solid #000;text-align:center">Neutral</div>--%>
                    <%--<div style="margin:10px;background-color:#111680;width:70px;height:20px;border:1px solid #000;text-align:center">Sad</div>--%>
                    <%--<div style="margin:10px;background-color:#cd0a0a;width:70px;height:20px;border:1px solid #000;text-align:center">Horrible</div>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <div id="map-canvas"></div>
        </div>
    </section>
</section>

<script>
    var happy_point_array,sad_point_array,neutral_point_array,excited_point_array,horrible_point_array ;
    var map, happy_map, sad_map, neutral_map, horrible_map, excited_map;

    function getRandomArbitary (min, max) {
        return Math.random() * (max - min) + min;
    }

    var sad_points = new Array();
    var happy_points = new Array();
    var horrible_points = new Array();
    var neutral_points = new Array();
    var excited_points = new Array();
   <%
      for(int i = 0;i<happyData.size();i++){
       String lo = happyData.get(i).getLongitude();
       String lat = happyData.get(i).getLatitude();
       %>
    happy_points[<%=i%>] =  new google.maps.LatLng(<%=lo%>, <%=lat%>);
    <%
       }
    %>

    <%
      for(int i = 0;i<sadData.size();i++){
       String lo = sadData.get(i).getLongitude();
       String lat = sadData.get(i).getLatitude();
       %>
    sad_points[<%=i%>] =  new google.maps.LatLng(<%=lo%>, <%=lat%>);
    <%
       }
    %>

    <%
      for(int i = 0;i<neutralData.size();i++){
       String lo = neutralData.get(i).getLongitude();
       String lat = neutralData.get(i).getLatitude();
       %>
    neutral_points[<%=i%>] =  new google.maps.LatLng(<%=lo%>, <%=lat%>);
    <%
       }
    %>

    <%
      for(int i = 0;i<horribleData.size();i++){
       String lo = horribleData.get(i).getLongitude();
       String lat = horribleData.get(i).getLatitude();
       %>
    horrible_points[<%=i%>] =  new google.maps.LatLng(<%=lo%>, <%=lat%>);
    <%
       }
    %>

    <%
      for(int i = 0;i<excitedData.size();i++){
       String lo = excitedData.get(i).getLongitude();
       String lat = excitedData.get(i).getLatitude();
       %>
    excited_points[<%=i%>] =  new google.maps.LatLng(<%=lo%>, <%=lat%>);
    <%
       }
    %>

    var gradient_sad = [
        'rgba(0, 0, 255, 0)',
        'rgba(0, 0, 128, 1)',
        'rgba(9, 0, 255, 1)',
        'rgba(8, 0, 255, 1)',
        'rgba(25, 25, 112, 1)',
        'rgba(25, 25, 112, 1)'
    ]
    var gradient_happy = [
        'rgba(0, 100, 0, 0)',
        'rgba(11, 76, 0, 1)',
        'rgba(25, 153, 44, 1)',
        'rgba(0, 255, 0, 1)',
        'rgba(0, 255, 1, 1)',
        'rgba(45, 255, 10, 1)',
        'rgba(23, 200, 60, 1)',
        'rgba(50, 200, 45, 1)',
        'rgba(124, 255, 0, 1)'
    ]
    var gradient_horrible = [

        'rgba(255, 0, 0, 0)',
        'rgba(88, 0, 0, 0)',
        'rgba(76, 0, 2, 1)',
        'rgba(255, 0, 0, 1)'
    ]
    var gradient_neutral = [
        'rgba(255, 0, 0, 0)',
        'rgba(255, 255, 0, 1)',
        'rgba(255, 215, 0, 1)',
        'rgba(255, 255, 0, 1)',
        'rgba(255, 200, 0, 1)'
    ]
    var gradient_excited = [
        'rgba(255, 69, 0, 0)',
        'rgba(255, 140, 0, 1)',
        'rgba(255, 0, 0, 1)',
        'rgba(255, 120, 0, 1)',
        'rgba(255, 100, 0, 1)'
    ]

    happy_point_array =  new google.maps.MVCArray(happy_points);
    sad_point_array =  new google.maps.MVCArray(sad_points);
    neutral_point_array =  new google.maps.MVCArray(neutral_points);
    horrible_point_array =  new google.maps.MVCArray(horrible_points);
    excited_point_array =  new google.maps.MVCArray(excited_points);

    function drawHappyMap(map){

        happy_map.setMap(map);
        sad_map.setMap(null);
        neutral_map.setMap(null);
        horrible_map.setMap(null);
        excited_map.setMap(null);

    }
    function drawSadMap(map){

        sad_map.setMap(map);
        happy_map.setMap(null);
        neutral_map.setMap(null);
        horrible_map.setMap(null);
        excited_map.setMap(null);
    }

    function drawNeutralMap(map){

        neutral_map.setMap(map);
        happy_map.setMap(null);
        sad_map.setMap(null);
        horrible_map.setMap(null);
        excited_map.setMap(null);
    }

    function drawHorribleMap(map){

        horrible_map.setMap(map);
        happy_map.setMap(null);
        sad_map.setMap(null);
        neutral_map.setMap(null);
        excited_map.setMap(null);
    }

    function drawExcitedMap(map){

        excited_map.setMap(map);
        happy_map.setMap(null);
        sad_map.setMap(null);
        horrible_map.setMap(null);
        neutral_map.setMap(null);
    }
    function defineMaps(){
        happy_map = new google.maps.visualization.HeatmapLayer({
            data: happy_point_array,
            gradient:gradient_happy
        });
        sad_map = new google.maps.visualization.HeatmapLayer({
            data: sad_point_array,
            gradient:gradient_sad
        });
        neutral_map = new google.maps.visualization.HeatmapLayer({
            data: neutral_point_array,
            gradient:gradient_neutral
        });
        horrible_map = new google.maps.visualization.HeatmapLayer({
            data: horrible_point_array,
            gradient:gradient_horrible
        });
        excited_map = new google.maps.visualization.HeatmapLayer({
            data: excited_point_array,
            gradient:gradient_excited
        });

    }

    function initialize() {
        var mapOptions = {
            zoom: 15,
            minZoom:7,
            center: new google.maps.LatLng(6.796876999999999000, 79.901778100000000000),
            mapTypeId: google.maps.MapTypeId.SATELLITE
        };

        map = new google.maps.Map(document.getElementById('map-canvas'),
                mapOptions);
        defineMaps();
        happy_map.setMap(map)

        $( "select" )
                .change(function () {
                    $( "select option:selected" ).each(function() {
                        if($( this ).text() == 'Happy') {
                            drawHappyMap(map);
                        }else if($( this ).text() == 'Sad'){
                            drawSadMap(map)
                        }else if($( this ).text() == 'Neutral'){
                            drawNeutralMap(map);
                        }else if($( this ).text() == 'Horrible'){
                            drawHorribleMap(map);
                        }else if($( this ).text() == 'Excited'){
                            drawExcitedMap(map);
                        }
                    });
                })
    }

    function getHappyCount() {

        heatmap.setOptions({data:none})
        heatmap.setMap(none)
//            heatmap2.setOptions({data:none})
    }

    function changeGradient() {

        heatmap.setOptions({data:none})

    }

    function changeRadius() {
        heatmap1.setOptions({radius: heatmap1.get('radius') ? null : 20});
    }

    function changeOpacity() {
        heatmap1.setOptions({opacity: heatmap1.get('opacity') ? null : 0.2});
    }

    google.maps.event.addDomListener(window, 'load', initialize);

</script>


<script src="js/jquery-1.7.1.min.js"></script>
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
