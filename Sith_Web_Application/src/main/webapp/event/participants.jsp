<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
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
    Event currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());

    ArrayList<Participant> participantList=new ArrayList<Participant>();
    participantList=eventHandler.getParticipants(currentEvent.getEventID());

    DateFormat dateFormat1 = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    Date currentDate = new Date();

    Date eventEndDate=dateFormat1.parse(currentEvent.getEndDate()+" "+currentEvent.getEndTime());
%>
<head>
    <meta charset="utf-8">
    <title>Sith Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <!--[if IE]>
    <link rel="stylesheet" href="../css/ie.css" media="all"/><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong> <fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/><fmt:message key="sith.dashboard.home.loggedAs" />
                <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %> Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<%--<span class="button dropdown">--%>
			<%--<a href="#">Notifications <span class="pip">4</span></a>--%>
			<%--<ul class="notice">--%>
                <%--<li>--%>
                    <%--<hgroup>--%>
                        <%--<h1>You have no new Notifications</h1>--%>
                    <%--</hgroup>--%>
                <%--</li>--%>
            <%--</ul>--%>
		<%--</span>--%>
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://sithplatform.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="../index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon"><i class="fa fa-home fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.home" /></a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon"><i class="fa fa-thumbs-up fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.myPerception" /></a>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-dashboard fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.analytics" /></a>
            <ul class="submenu">
                <%
                    if(currentEvent.getAdminID().equals(participant.getUserID())){
                        if(currentDate.compareTo(eventEndDate)<0){
                %>
                <li><a href="realTimeAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.realTimeAnalitics" /></a></li>
                <%
                    }
                %>
                <li><a href="nonRealTimeAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.postAnalitics" /></a></li>
                <%
                    }
                %>
                <li><a href="selfAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.selfAnalytics" /></a></li>

            </ul>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
                if(currentDate.compareTo(eventEndDate)<0){
        %>
        <li>
            <a href="timeVariantParameters.jsp"><span class="icon"><i class="fa fa-clock-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.temporalParams" /></a>
        </li>
        <%
                }
            }
        %>
        <li>
            <a href="questions.jsp"><span class="icon"><i class="fa fa-comments fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.comments" /></a>
        </li>
        <li>
            <a href="participants.jsp"><span class="icon"><i class="fa fa-users fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.participants" /></a>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
        %>
        <li>
            <a href="eventAdmin.jsp"><span class="icon"><i class="fa fa-cogs fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.settings" /></a>
        </li>
        <li>
            <a href="social.jsp"><span class="icon"><i class="fa fa-twitter fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.socilaMediaInt" /></a>
        </li>
        <%
            }
        %>
    </ul>
</nav>
<section class="alert">
    <div class="green">
        <span><fmt:message key="sith.dashboard.event.CurrentEventIs" /> <strong><%=currentEvent.getEventName()%></strong>, <fmt:message key="sith.dashboard.event.clickToChange" /> <a href="../myEvents.jsp" style="color:#00477b"><fmt:message key="sith.dashboard.myEvents.Change" /></a></span>
        <span  id="current_perception"  style="margin: auto;float: right;display: none;"><fmt:message key="sith.dashboard.event.CurrentPerceptionIs" /> <strong></strong></span>
    </div>
</section>

<section class="content">
    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.participant.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.event.participant.description" /></h2>
            </hgroup>
        </header>
        <div class="content">
            <table id="myTable" border="0" width="100">
                <thead>
                <tr>
                    <th class="avatar"><fmt:message key="sith.dashboard.eventName.participant.name" /></th>
                    <th><fmt:message key="sith.dashboard.eventStatus.participant.status" /></th>
                </tr>
                </thead>
                <tbody>
                <%
                    for(Participant temp : participantList){
                %>
                <tr>
                    <td class="avatar"><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40"
                                            width="40"/> <%=temp.getUserName()%>
                    </td>
                    <%
                        if(currentEvent.getAdminID().equals(temp.getUserID())){
                    %>
                    <td><fmt:message key="sith.dashboard.myEvents.admin" /></td>
                    <%
                    }
                    else{
                    %>
                    <td><fmt:message key="sith.dashboard.myEvents.participant" /></td>
                    <%
                        }
                    %>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</section>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="../js/jquery.wysiwyg.js"></script>
<script src="../js/custom.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.checkbox.min.js"></script>
<script src="../js/flot.js"></script>
<script src="../js/flot.resize.js"></script>
<script src="../js/flot-graphs.js"></script>
<script src="../js/flot-time.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.tablesorter.min.js"></script>
</body>
</html>