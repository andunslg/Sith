<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
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

    EventHandler eventHandler=new EventHandler();
    UserHandler userHandler=new UserHandler();

    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());

    String deletedEvents=userHandler.checkDeletedEvents(participant.getUserID());
    ArrayList<Event> events=userHandler.getUserEventList(participant.getUserID());

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
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
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
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /> </strong><fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> <fmt:message key="sith.dashboard.home.loggedAs" />
                <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
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
                <li><a href="realtimeHeatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.realTime" /></a></li>
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

    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.menu.myEvents" /></h1>

                <h2><fmt:message key="sith.dashboard.myEvents.description" /></h2>
            </hgroup>
        </header>
            <div class="content">
                <table id="myTable" border="0" width="100">
                    <thead>
                    <tr>
                        <th class="avatar"><fmt:message key="sith.dashboard.myEvents.name" /></th>
                        <th><fmt:message key="sith.dashboard.myEvents.type" /></th>
                        <th><fmt:message key="sith.dashboard.myEvents.Change" /></th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for(Event event : events){
                    %>
                    <tr id="<%=event.getEventID()%>" class="event_rows">
                        <td class="avatar"><%=event.getEventName()%>
                        </td>
                        <%
                            if(event.getAdminID().equals(session.getAttribute("user").toString())){ %>
                        <td>
                            <fmt:message key="sith.dashboard.myEvents.admin" />
                        </td>
                        <td>
                            <span class="button"><a href="event/eventAdmin.jsp?eventID=<%=event.getEventID()%>"><fmt:message key="sith.dashboard.myEvents.adminPanelBtn" /></a></span>
                        </td>
                        <%
                        }else{
                        %>
                        <td>
                            <fmt:message key="sith.dashboard.myEvents.participant" />
                        </td>
                        <td>
                            <span class="button"><a href="event/removeUserFromEventHandler.jsp?eventID=<%=event.getEventID()%>&userID=<%=participant.getUserID()%>"><fmt:message key="sith.dashboard.myEvents.unRegisterBtn" /></a></span>
                        </td>
                        <%
                            }

                        %>

                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                <%
                    if(!deletedEvents.equals("")){
                %>
                <br>
                <br>
                <div>
                    <fmt:message key="sith.dashboard.myEvents.deletedEventDescription" /><%=deletedEvents%>
                </div>
                <%
                    }
                %>
            </div>


    </section>

</section>

<script type="text/javascript">

    $('.event_rows').click(function () {
        document.location.href = 'event/event.jsp' + '?eventID=' + this.id;
    });


</script>
</body>
</html>