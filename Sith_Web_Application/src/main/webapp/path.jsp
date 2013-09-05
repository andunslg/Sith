<%@ page import="com.sith.SithAPI" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Sith</title>

    <script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>

    <script src="http://codeorigin.jquery.com/jquery-2.0.3.min.js"></script>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
    <style>
        body {
            padding-top: 40px; /* 60px to make the container go all the way to the bottom of the topbar */
        }
    </style>

    <script type="text/javascript">
        var directionsDisplay;
        var directionsService = new google.maps.DirectionsService();
        var map;
        var oldDirections = [];
        var currentDirections = null;

        function initialize() {
            var myOptions = {
                zoom: 11,
                center: new google.maps.LatLng(6.796876999999999000, 79.901778100000000000),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            }
            map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

            directionsDisplay = new google.maps.DirectionsRenderer({
                'map': map,
                'preserveViewport': true,
                'draggable': true
            });
            directionsDisplay.setPanel(document.getElementById("directions_panel"));

            initListners();

            setUndoDisabled(true);

            calcRoute();
        }

        function initListners() {
            google.maps.event.addListener(directionsDisplay, 'directions_changed',
                    function () {
                        if (currentDirections) {
                            oldDirections.push(currentDirections);
                            setUndoDisabled(false);
                        }
                        currentDirections = directionsDisplay.getDirections();

                        var response = directionsDisplay.getDirections();
                        calCost(response.routes);
                        directionsDisplay.setMap(null);
                        directionsDisplay.setPanel(null);
                        directionsDisplay = new google.maps.DirectionsRenderer({
                            'map': map,
                            'preserveViewport': true,
                            'draggable': true
                        });
                        directionsDisplay.setPanel(document.getElementById("directions_panel"));
                        directionsDisplay.setDirections(response);

                        initListners()
                    });

        }

        function calcRoute() {
            var start = 'University of Moratuwa';
            var end = 'Fort, Colombo, Western Province';
            var request = {
                origin: start,
                destination: end,
                travelMode: google.maps.DirectionsTravelMode.DRIVING,
                provideRouteAlternatives: true
            };
            directionsService.route(request, function (response, status) {
                if (status == google.maps.DirectionsStatus.OK) {
//                    calCost(response.routes);
                    directionsDisplay.setDirections(response);
                }
            });
        }

        function undo() {
            currentDirections = null;
            directionsDisplay.setDirections(oldDirections.pop());
            if (!oldDirections.length) {
                setUndoDisabled(true);
            }
        }

        function setUndoDisabled(value) {
            document.getElementById("undo").disabled = value;
        }

        function calCost(routes) {

            var points;
            for (var i = 0; i < routes.length; i++) {
                points = routes[i].legs[0].steps;
                var cost = 0;
                for (var j = 0; j < points.length; j++) {
                    cost += getCost(points[j].start_location.lat, points[j].start_location.lng);
                }
                cost=cost/j;
                routes[i].summary += ", Perception rating=" + cost + ",";
                routes[i].rating=cost;
            }

            routes.sort(compare);
//            return routes;
        }

        function compare(a,b) {
            if (a.rating < b.rating)
                return -1;
            if (a.rating > b.rating)
                return 1;
            return 0;
        }

        function getCost(lat, lng) {
           var temp;
            $.ajax({
                url: '<%=SithAPI.GET_LOCATION_RATING%>?lat='+lat+'&lng='+lng,
                type: 'GET',
                async: false,
                success: function (data) {
                    if(typeof data=='string' || data instanceof String){
                        temp = JSON.parse(data);
                    }else{
                        temp= data;
                    }

                },
                error: function (xhr, status, error) {
                    apprise("Error : " + error.message);
                }
            });
            return temp.rating;
        }

    </script>
</head>

<body onload="initialize()">

<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="navbar-inner">
        <div class="container">
            <button type="button" class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="brand" href="#">Sith Pathfinder</a>
            <div class="nav-collapse collapse">
                <ul class="nav">
                    <li><a href="http://proj16.cse.mrt.ac.lk">About</a></li>
                    <li><a href="http://proj16.cse.mrt.ac.lk/Sith">Got to Sith</a></li>
                </ul>
            </div><!--/.nav-collapse -->
        </div>
    </div>
</div>



    <div id="map_canvas" style="float:left;width:70%;height:100%"></div>
    <div style="float:right;width:30%;height:100%;overflow:auto">
        <button id="undo" style="display:none;margin:auto" onclick="undo()">Undo
        </button>
        <div id="directions_panel" style="width:100%"></div>
    </div>





</body>
</html>