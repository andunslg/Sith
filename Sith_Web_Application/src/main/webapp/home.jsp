<%@ page import="com.sith.user.NotificationHandler" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="com.sith.SithAPI" %>
<!DOCTYPE html>
<html lang="">

<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
    NotificationHandler notifHandler = new NotificationHandler();
    //ArrayList<String> notifs = null;
    JSONArray notifs = notifHandler.getAllNotifications(session.getAttribute("user").toString());
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
    <link href="css/toastr.css" rel="stylesheet" />
    <!-- Include this file if you are using Pines Icons. -->
    <script src="http://localhost:3000/socket.io/socket.io.js"></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="../js/toastr.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/jquery.wysiwyg.js"></script>
    <script src="js/custom.js"></script>
    <script src="js/cycle.js"></script>
    <script src="js/jquery.checkbox.min.js"></script>
    <script src="js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            toastr.options = {
                positionClass: 'toast-bottom-left',
                timeOut: 2500
                // I position it properly already. not needed.
            };
            var socket = io.connect('<%=SithAPI.SOCKET_API%>');
            // on connection to server, ask for user's name with an anonymous callback
            //var previousPage = document.referrer;
            //var patt=/index.jsp/g;
            //var result=patt.test(previousPage);
            //if(result){
                socket.on('connect', function(){
                    // call the server-side function 'adduser' and send one parameter (value of prompt)
                    socket.emit('login', '<%=session.getAttribute("user").toString()%>');
                });
            //}
            socket.on("friendRequest",function(data){
                var currentCount = parseInt($("#notificCount").text());
                $("#notificCount").text(currentCount+1);
                $("#notificCount").css("visibility","visible");
                toastr.info(data, 'Friend Request')
            });
            socket.on("cepNotification",function(data){
                var currentCount = parseInt($("#notificCount").text());
                $("#notificCount").text(currentCount+1);
                $("#notificCount").css("visibility","visible");
                toastr.info(data, 'Perception Pattern Detected')
            });
            $("#notifButton").hover(
                function(){
                 $("#notificCount").text(0);
                 $("#notificCount").css("visibility","hidden");
                }
            );
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
		<span id="notifButton" class="button dropdown">
			<a href="#">Notifications
            <% if(notifs.length()>0){%>
                <span id="notificCount" class="pip"><%=notifs.length()%></span>
            <%}else{%>
                <span id="notificCount" class="pip" style="visibility: hidden">0</span>
            <%}%>
            </a>
			<ul class="notice" style="width: 300px">
                <% if(notifs.length()==0){%>
                <li>
                    <hgroup>
                        <h1>You have no notifications</h1>
                    </hgroup>
                </li>
                <%}else{
                    for(int i=0;i<notifs.length();i++){%>
                <li style="white-space: nowrap">
                    <table>
                        <tr>
                            <td>
                                <h1>
                                    <%=notifs.getJSONObject(i).getString("text")%>
                                </h1>
                            </td>
                <% if(notifs.getJSONObject(i).getString("type").equals("friendRequest")){%>
                            <td>
                                <div class="buttons">
                                    <span class="button blue" style=" top: 0px; right: 0px; left:10px; position: relative; ">
                                        <a href="#">Confirm</a>
                                    </span>
                                </div>
                            </td>
                <% }%>
                        </tr>
                    </table>
                </li>
                <%}}%>
            </ul>
		</span>
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
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
            <a href="#"><span class="icon" style="font-size: 40px">&#128711;&thinsp;</span>How World Feels</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Heat Map</a></li>
                <li><a href="piChartAnalytics.jsp"></span>Pi Chart</a></li>
            </ul>
        </li>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>How I Feel</a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span>Location Based</a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span>Time Based</a></li>
            </ul>
        </li>
    </ul>
</nav>
<section class="content" style="margin-top: 10px">

    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Welcome</h1>

                <h2>Sith - Crowdsourced perception capturing and analysis platform</h2>
            </hgroup>
        </header>
        <br>
        <div align="center">
            <iframe width="480" height="360" src="http://www.youtube.com/embed/RA1WHjnLJEQ" frameborder="0" allowfullscreen></iframe>
        </div>

        <br>
        <div align="center">
            <a href="https://twitter.com/sithplatform" class="twitter-follow-button" data-show-count="false" data-size="large">Follow @sithplatform</a>
            <script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');</script>
        </div>
        <br>
    </section>
</section>
</body>
</html>