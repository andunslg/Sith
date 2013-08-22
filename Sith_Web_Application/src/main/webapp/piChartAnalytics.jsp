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


function drawChart(marker, data, event, location) {


    var options = {'title':'Event : '+event+'  Location : '+location,
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
        url: 'http://192.248.8.246:3000/getAllCurrentEventMapData',
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

        var data = google.visualization.arrayToDataTable([
            [ 'Perception', '%' ],
            [ master_perception[0],obj[master_perception[0]]],
            [ master_perception[1],obj[master_perception[1]]],
            [ master_perception[2],obj[master_perception[3]]],
            [ master_perception[3],obj[master_perception[3]]],
            [ master_perception[4],obj[master_perception[4]]]
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
                click: function(mk,dt,name,location) {
                    return function(){
                        drawChart(mk,dt,name,location)
                    };
                }(marker,data,obj.event_name,obj.location)
            }
        });
    }
}

function initialize() {

    var latLng = new google.maps.LatLng(6.656, 79.942017)

    var mapOptions = {
        center: latLng,
        zoom: 12,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map_canvas"),
            mapOptions);
    drawPieCharts(map)

};
google.maps.event.addDomListener(window, 'load', initialize);
//google.maps.event.addListener(map, 'bounds_changed', function() {
//    var bounds = map.getBounds();
//    var ne = bounds.getNorthEast(); // LatLng of the north-east corner
//    var sw = bounds.getSouthWest(); // LatLng of the south-west corder
//
//    drawPieChartsOnMap(sw.lat(),ne.lat(),sw.lng(),ne.lng());
//});
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