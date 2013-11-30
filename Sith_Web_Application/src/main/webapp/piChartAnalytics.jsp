<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.LocationBasedAnalytics" %>
<%@ page import="com.sith.analytics.locationBasedAnalytics.PerceptionsOnLocation" %>
<%@ page import="java.util.HashMap" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
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
    LocationBasedAnalytics pieChartAnalytics = new LocationBasedAnalytics();

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
    <script src="https://maps.googleapis.com/maps/api/js?v=3.10&sensor=false&.js"></script>
    <script type="text/javascript" src="https://www.google.com/jsapi?.js"></script>
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

</head>
<body>

<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong> <fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> <fmt:message key="sith.dashboard.home.loggedAs" /> <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
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
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://sithplatform.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
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
                <li><a href="realtimeHeatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.realTimeAnalitics" /></a></li>
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
                <h1><fmt:message key="sith.dashboard.world.piChart.topic" /></h1>
            </hgroup>
        </header>
        <div class="content">

            <div id="map-canvas"></div>

        </div>
    </section>
</section>

<script>

google.maps.visualRefresh=true;

zIndex=100;//used to bring the last infowindow into front
google.load( 'visualization', '1', { packages:['corechart'] });


ChartMarker.prototype = new google.maps.OverlayView;
ChartMarker.prototype.onAdd = function() {
    $( this.getPanes().overlayMouseTarget ).append( this.$div );
};

ChartMarker.prototype.onRemove = function() {
    this.$div.remove();
};

ChartMarker.prototype.draw = function() {
    var marker = this,
            projection = this.getProjection(),
            position = projection.fromLatLngToDivPixel( this.get('position') );

    this.$div.css({
        left: position.x,
        top: position.y,
        display: 'block'
    })
    this.$inner
            .click( function( event ) {
                var events = marker.get('events');
                events && events.click( event );
            });

    this.chart = new google.visualization.PieChart( this.$inner[0] );
    this.chart.draw( this.get('chartData'), this.get('chartOptions') );
};

function drawChart(marker, event) {
    if(!marker.get('infowindow')){          //create only 1 infowindow per marker
        var node        = document.createElement('div'),
                chart       = new google.visualization.PieChart(node),
                options = { title:'Event : '+event.type+'  Location : '+marker.position,
                    width:400,
                    height:150,
                    slices: {0: {color: 'orange'},
                        1:{color: 'green'},
                        2:{color: 'yellow'},
                        3: {color: 'blue'},
                        4:{color: 'red'}}
                };
        chart.draw(marker.chartData, options);
        marker.set('infowindow',new google.maps.InfoWindow({content:node,
            position:marker.position,
            map:marker.getMap()}));
        $(node).click(function(){marker.infowindow.setZIndex(zIndex++);})

    }

    marker.infowindow.setZIndex(zIndex++);
    marker.infowindow.open(marker.getMap());
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


var master_perception = new Array("happy","excited","neutral","sad","horrible");
/**
 *
 * @param emotion
 * @param timelevel
 * @param latmin  minimum latitude
 * @param lngmin  mimimum longitude
 * @param latmax
 * @param lngmx
 * @return {*}
 *      the response from the 'getAllCurrentEventMapData'
 */
function getFromAPI(emotion, timelevel, latmin,lngmin,latmax,lngmx) {


    return JSON.parse($.ajax({
        url: '<%=SithAPI.GET_ALL_CURRENT_EVENT_MAP_DATA%>',
        dataType:'json',
        data: 'emotion=' + emotion + '&timelevel=' + timelevel + '&latmin=' + latmin+'&lngmin='+lngmin+"&latmax="+latmax+"&lngmx="+lngmx,
        type: 'GET',
        async:false,
        success: function (result) {
            return result;

        },
        error: function (xhr, status, error) {
            console.log('Error: ' + error.message);
            return null;
        }
    }).responseText);

}

var map = new Object();

function getDataMap(){

    for( var i=0;i<master_perception.length;i++){
        var perception_on_event= getFromAPI(master_perception[i],"0","0","0","1000","1000");
        var value = master_perception[i];
        if(perception_on_event != null){

            for(var j=0;j<perception_on_event.length;j++){
                var key = perception_on_event[j].subid;
                if(map[key] != null){
                    var event = map[key];
                    event[value] = perception_on_event[j].count;
                    map[key] = event;
                }
                else{
                    var new_event = {
                        event_name: perception_on_event[j].subid,
                        lat: perception_on_event[j].lat,
                        lo: perception_on_event[j].lo,
                        location: perception_on_event[j].location
                    };
                    new_event[value] = perception_on_event[j].count;
                    map[perception_on_event[j].subid]= new_event;
                }
            }
        }

    }
    return map;
}
function drawPieCharts(map){

    var mp = getDataMap();

    for (var key in mp) {
        var obj = mp[key];
        var pie_chart_latlng = new google.maps.LatLng(obj.lat, obj.lo)

        var data_table = new Array();
        data_table[0] =  [ 'Perception', '%' ];
        for(var k=0;k<master_perception.length;k++){
            data_table[k+1]=[ master_perception[k],obj[master_perception[k]]];
        }
        var data = google.visualization.arrayToDataTable(data_table);
        var options = {

            fontSize: 8,
            backgroundColor: 'transparent',
            legend: {position: 'none'},
            slices: {0: {color: 'orange'}, 1:{color: 'green'}, 2:{color: 'yellow'}, 3: {color: 'blue'}, 4:{color: 'red'}}
        };

        (function(location,data){
            var marker = new ChartMarker({
                map: map,
                position: location,
                width: '250px',
                height: '100px',
                chartData: data,
                chartOptions: options,
                events: {
                    click: function( event ) {
                        drawChart(marker,event)
                    }
                }
            });
        })(pie_chart_latlng,data,options);

    }
}

function initialize() {

    var latLng = new google.maps.LatLng(6.656, 79.942017)

    var mapOptions = {
        center: latLng,
        zoom: 15,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map-canvas"),
            mapOptions);
    drawPieCharts(map)

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