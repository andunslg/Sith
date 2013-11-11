<%@ page import="com.sith.user.NotificationHandler" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="com.sith.SithAPI" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />

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
    <title><fmt:message key="sith.dashboard.topic" /></title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all"/>
    <link href="css/toastr.css" rel="stylesheet" />
    <!-- Include this file if you are using Pines Icons. -->
    <script src='<%=SithAPI.SOCKET_API%>/socket.io/socket.io.js'></script>
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="js/toastr.min.js"></script>
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
                toastr.info(data, 'Friend Request');
                console.log($('ul#notifList > li:first').text());
                //remove the existing "No notifications" message
                if($('ul#notifList > li:first').text()=="You have no notifications"){
                    $('ul#notifList > li:first').remove();
                };
                //append new notification to the top
                $("#notifList").prepend('<li><table><tr><td class="sender" style="visibility: hidden;font-size: 1px">'+data.split(" ")[0]+'</td><td><h1>'+data+'</h1></td><td><div class="buttons"><span class="button blue" style=" top: 0px; right: 0px; left:10px; position: relative; "><a id="confirm" href="#">Confirm</a></span></div></td></tr></table></li>');
            });
            socket.on("requestAccepted",function(data){
                var currentCount = parseInt($("#notificCount").text());
                $("#notificCount").text(currentCount+1);
                $("#notificCount").css("visibility","visible");
                toastr.info(data, 'Friend Request Accepted!');
                //remove the existing "No notifications" message
                if($('ul#notifList > li:first').text()=="You have no notifications"){
                    $('ul#notifList > li:first').remove();
                };
                //append new notification to the top
                $("#notifList").prepend('<li><table><tr><td><h1>'+data+'</h1></td></tr></table></li>');
            });
            socket.on("cepNotification",function(data){
                var currentCount = parseInt($("#notificCount").text());
                $("#notificCount").text(currentCount+1);
                $("#notificCount").css("visibility","visible");
                toastr.info(data, 'Perception Pattern Detected');
                //remove the existing "No notifications" message
                if($('ul#notifList > li:first').text()=="You have no notifications"){
                    $('ul#notifList > li:first').remove();
                };
                //append new notification to the top
                $("#notifList").prepend('<li><table><tr><td><h1>'+data+'</h1></td></tr></table></li>');
            });
            $("#notifButton").hover(
                function(){
                 $("#notificCount").text(0);
                 $("#notificCount").css("visibility","hidden");
                }
            );
            $("#confirm").live("click",function(){
                var sender =$(this).closest("tr").find(".sender").text();
                var receiver = '<%=session.getAttribute("user").toString()%>';
                var button = $(this);
                console.log(sender);
                $.ajax({
                    url: '<%=SithAPI.CONFIRM_FRIEND_REQUEST%>?sender='+sender+'&receiver='+receiver,
                    type: 'GET',
                    success: function (data) {
                        button.html("Confirmed");
                        toastr.info('You are now friend with '+sender);
                    },
                    error: function (xhr, status, error) {
                        apprise("Error : " + error.message);
                    }
                });
            })
        });
    </script>
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong><fmt:message key="sith.dashboard.sith" /> </strong><fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/><fmt:message key="sith.dashboard.home.loggedAs" />
                <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<span id="notifButton" class="button dropdown">
			<a href="#"><fmt:message key="sith.dashboard.home.notifications" />
            <% if(notifs.length()>0){%>
                <span id="notificCount" class="pip"><%=notifs.length()%></span>
            <%}else{%>
                <span id="notificCount" class="pip" style="visibility: hidden">0</span>
            <%}%>
            </a>
			<ul id="notifList"class="notice" style="width: 300px">
                <% if(notifs.length()==0){%>
                <li><hgroup><h1><fmt:message key="sith.dashboard.home.NoNotificationsMsg" /></h1></hgroup></li>
                <%}else{
                    for(int i=0;i<notifs.length();i++){%>
                <li style="white-space: nowrap">
                    <table>
                        <tr>
                            <td class="sender" style="visibility: hidden;font-size: 1px"><%=notifs.getJSONObject(i).getString("sender")%></td>
                            <td>
                                <h1>
                                    <%=notifs.getJSONObject(i).getString("text")%>
                                </h1>
                            </td>
                                <% if(notifs.getJSONObject(i).getString("type").equals("friendRequest")){%>
                            <td>
                                <div class="buttons">
                                    <span class="button blue" style=" top: 0px; right: 0px; left:10px; position: relative; ">
                                        <a id="confirm" href="#">Confirm</a>
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
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span><fmt:message key="sith.dashboard.menu.events" /></a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span><fmt:message key="sith.dashboard.menu.myEvents" /></a></li>
                <li><a href="joinEvents.jsp"></span><fmt:message key="sith.dashboard.menu.joinEvents" /></a></li>
                <li><a href="addEvents.jsp"></span><fmt:message key="sith.dashboard.menu.addEvents" /></a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span><fmt:message key="sith.dashboard.menu.profile" /></a>
        </li>
        <li>
            <a href="newsFeed.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span><fmt:message key="sith.dashboard.menu.newsfeed" /></a>
        </li>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px;text-align:center ">&#128711;&thinsp;</span><fmt:message key="sith.dashboard.menu.worldAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.heatMap" /></a></li>
                <li><a href="piChartAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.piChart" /></a></li>
                <li><a href="realtimeHeatMapAnalytics.jsp"></span>Real Time Analytics</a></li>
            </ul>
        </li>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span><fmt:message key="sith.dashboard.menu.myAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.locationBased" /></a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.timeBased" /></a></li>
            </ul>
        </li>
    </ul>
</nav>
<section class="content" style="margin-top: 10px">

    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.home.welcome" /></h1>


                <h2><fmt:message key="sith.dashboard.home.description" /></h2>
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
    </section>
</section>
</body>
</html>