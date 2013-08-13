<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
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

    ArrayList<String> perceptionList=sithAPI.getMasterPerceptions();
    EventHandler eventHandler=new EventHandler();
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
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
    <link rel="stylesheet" href="css/button_style.css" media="all"/>
    <link rel="stylesheet" href="css/jquery-ui.css" media="all"/>
    <link rel="stylesheet" href="css/apprise.min.css" type="text/css" />
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/jquery-ui-timepicker-addon.css" />

    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="js/jquery-ui-timepicker-addon.js"></script>
    <script src="js/apprise-1.5.min.js"></script>
    <script src="js/jquery-migrate-1.0.0.js"></script>
    <script src="js/jscolor.js"></script>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
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
    </ul>
</nav>


<section class="content" style="margin-top: 10px">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Add new event</h1>

                <h2>Enter Event Details</h2>
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td style="width: 160px">
                            <div>Event ID</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventID" id="eventID" value="Unique event ID" type="text"
                                       style="width: 400px">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Event Name</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventName" id="eventName" value="Event Name" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Start</div>
                        </td>
                        <td>
                            <div>
                                <input name="start" id="start" value="06/12/2013 00:00" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>End</div>
                        </td>
                        <td>
                            <div>
                                <input name="end" id="end" value="06/12/2013 01:00" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top">
                           Location
                        </td>
                        <td>
                            <div>
                                <div id="map-canvas"></div>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <div id="Maplocation">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <p style="margin-bottom: 0px">Location Address</p>
                            <p>(change Accordingly)</p>
                        </td>
                        <td>
                            <div>
                                <input name="location" id="location" value="Event Location" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Description</div>
                        </td>
                        <td>
                            <div>
                                <input name="description" id="description" value="Description" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>

                    <tr>

                        <td>
                            <div  >Perception Schema &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                        </td>
                        <td>
                            <select multiple="multiple" name="perceptionSchema" id="perceptionSchema"
                                    style="width: 400px;height: 120px;vertical-align: middle" >
                                <%
                                    for(String perception : perceptionList){
                                        if(perception.equals("Happy")){
                                %>
                                <option name="<%=perception%>" value="<%=perception%>" selected="selected"><%=perception%></option>
                                <%
                                }else{
                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </td>
                        <td style="vertical-align: middle">
                            <div class="m-btn-group" style="display: inline-table">
                                <a title=">" class="m-btn icn-only"  onclick="FirstListBox();"><i class="icon-chevron-right" ></i></a>
                                <a class="m-btn icn-only" onclick="SecondListBox();"><i class="icon-chevron-left"></i></a>
                            </div>
                        </td>
                        <td style="vertical-align: middle">
                            <select name="selectedPerceptionSchema"  id="selectedPerceptionSchema" multiple="multiple"
                                    style="width:300px;height: 120px">

                            </select>

                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <input id="addColors" value="Add Color Schema" type="button" class="button" style="text-align: center;width: 150px">
                            <div style="padding-top: 10px">
                             If you do not set the color schema, random colors will be set
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <table id="colors">
                                <tbody>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Enable User Comments</div>
                        </td>
                        <td >
                            <input align="left"  name="commentEnabled" id="commentEnabled" type="checkbox" style="width: 10%">
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div>Time Variant Parameters</div>
                        </td>
                        <td>
                            <div>
                                <input name="timeVariantParams" id="timeVariantParams" value="" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <div style="display: inline-block">
                                <input id="addEvent" value="Add" type="button" class="button" style="text-align: center;width: 100px">
                            </div>
                        </td>
                    </tr>
                </table>

            </form>
        </div>
    </section>
</section>

<script>
    $(document).ready(function(){
        $(function() {
            $( "#datepicker" ).datepicker();
        });
        google.maps.visualRefresh = true;
        var myMarker = null;
        var map;
        var latLng = {};
        function initialize() {
            geocoder = new google.maps.Geocoder();
            var mapOptions = {
                zoom: 7,
                center: new google.maps.LatLng(7.815, 80.65),
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            map = new google.maps.Map(document.getElementById('map-canvas'),
                    mapOptions);
            google.maps.event.addListener(map, 'click', function(e) {
                map.clearOverlays();
                geocoder.geocode({'latLng': e.latLng}, function(results, status) {
                    if(status == google.maps.GeocoderStatus.OK) {
                        $("#Maplocation").html("<p>"+ e.latLng+"</p>");
                        latLng.lat = e.latLng.lat();
                        latLng.lng = e.latLng.lng();
                        $("#location").val(results[0]['formatted_address']);
                    }else{
                        $("#Maplocation").html("<p>No Address Found!</p>");
                    }
                });
                placeMarker(e.latLng,map)
            });
        }

        // Enable the visual refresh
        function placeMarker(position, map) {
            var marker = new google.maps.Marker({
                position: position,
                map: map
            });
            myMarker = marker;
            map.panTo(position);
        }
        google.maps.Map.prototype.clearOverlays = function() {
            if(myMarker){
                myMarker.setMap(null);
            }
        }
        google.maps.event.addDomListener(window, 'load', initialize);

        $("#addEvent").click(function () {
            var eventID = $('input[id=eventID]').val();
            var eventName = $('input[id=eventName]').val();
            var start = $('input[id=start]').val();
            var end = $('input[id=end]').val();
            var location = $('input[id=location]').val();
            var description = $('input[id=description]').val();
            var timeVariantParams = $('input[id=timeVariantParams]').val();

            var c=document.getElementById('commentEnabled');
            var commentEnabled = false;
            if(c.checked){
                commentEnabled=true;
            }

            var perceptionSchema = "";


            $("#selectedPerceptionSchema>option").each(function () {
                if(perceptionSchema!=""){
                    perceptionSchema += ":"+$(this).text();
                }else{
                    perceptionSchema+= $(this).text();
                }
            });
            var colors = ""
            $("#colors").find("td:nth-child(2)").each(function () {
                if(colors!=""){
                    colors += ":"+$(this)[0].firstChild.style.backgroundColor;
                }else{
                    colors+= $(this)[0].firstChild.style.backgroundColor;
                }
            });
            if(colors == ""){
                colors = null;
            }
            console.log(colors);
            if(start.length!=16  ||end.length!=16){
                apprise("Please select correct Start and End values")
            }
            else if(perceptionSchema==""){
                apprise("Please select perception schema")
            }
            else{

                var datObj = {};

                datObj['eventID'] = eventID;
                datObj['eventName'] = eventName;
                datObj['eventAdmin'] = '<%=participant.getUserID()%>';
                datObj['start'] = start;
                datObj['end'] = end;
                datObj['location'] = location;
                datObj['latLng'] = JSON.stringify(latLng);
                datObj['description'] = description;
                datObj['perceptionSchema'] = perceptionSchema;
                datObj['commentEnabled'] = commentEnabled;
                datObj['colors'] = colors;
                datObj['timeVariantParams'] = timeVariantParams;

                $.ajax({
                    url: 'event/addEventHandler.jsp',
                    data: datObj,
                    type: 'POST',
                    success: function (data) {
                        apprise(data)
                        if ((data.indexOf("The Event is successfully added.") != -1) || (data.indexOf("Please fill the ")!= -1)) {
                            window.location.href = 'myEvents.jsp';
                        }
                    },
                    error: function (xhr, status, error) {
                        apprise("Error adding event - " + error.message);
                    }
                });
            }
        });
    })


    function SecListBox(ListBox,text,value)
    {
        try
        {
            var option=document.createElement("OPTION");
            option.value=value;
            option.text=text;
            ListBox.options.add(option)
        }
        catch(er)
        {
            apprise(er)
        }
    }
    function FirstListBox()
    {
        try
        {
            var count=document.getElementById("perceptionSchema").options.length;
            for(i=0;i<count;i++)
            {
                if(document.getElementById("perceptionSchema").options[i].selected)
                {
                    SecListBox(document.getElementById("selectedPerceptionSchema"),document.getElementById("perceptionSchema").options[i].value,document.getElementById("perceptionSchema").options[i].value);document.getElementById("perceptionSchema").remove(i);
                    break;
                }
            }
        }
        catch(er)
        {
            apprise(er)
        }
    }
    function SecondListBox()
    {
        try
        {
            var count=document.getElementById("selectedPerceptionSchema").options.length;
            for(i=0;i<count;i++)
            {
                if(document.getElementById("selectedPerceptionSchema").options[i].selected){SecListBox(document.getElementById("perceptionSchema"),document.getElementById("selectedPerceptionSchema").options[i].value,document.getElementById("selectedPerceptionSchema").options[i].value);document.getElementById("selectedPerceptionSchema").remove(i);
                    break
                }
            }

        }
        catch(er)
        {
            apprise(er)
        }
    }

    $(function() {
        $('#start').datetimepicker();
        $('#end').datetimepicker();
    });

    $("#addColors").click(function(){
        $("#colors tbody").empty();
        $("#selectedPerceptionSchema>option").each(function () {
            $("#colors tbody").append("<tr><td style='padding: 25px 10px 0px 0px'>"+$(this).text()+"</td>" +
                                         "<td><input class='color' name='"+$(this).text()+"'id='"+$(this).text()+"'type='text'></td></tr>").fadeIn("slow");
            var myPicker = new jscolor.color(document.getElementById($(this).text()), {})

        });
    });
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