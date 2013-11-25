<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
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
    SithAPI sithAPI=SithAPI.getInstance();
    EventHandler eventHandler=new EventHandler();

    Event currentEvent=null;
    if(request.getParameter("eventID")!=null){
        currentEvent=eventHandler.getEvent(request.getParameter("eventID").toString());
        session.setAttribute("eventID",currentEvent.getEventID());
    }else{
        currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    }

    String arr[]=currentEvent.getPerceptionSchema().split(":");
    List<String> perceptionListSelected=Arrays.asList(arr);
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    DateFormat dateFormat1 = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    Date currentDate = new Date();
    Date eventEndDate=dateFormat1.parse(currentEvent.getEndDate()+" "+currentEvent.getEndTime());
%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <link rel="stylesheet" href="../css/button_style.css" media="all"/>
    <link rel="stylesheet" href="../css/apprise.min.css" media="all"/>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="../css/jquery-ui-timepicker-addon.css" />
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="../js/jquery-ui-timepicker-addon.js"></script>
    <script src="../js/apprise-1.5.min.js"></script>
    <script src="../js/jquery-migrate-1.0.0.js"></script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong> <fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> <fmt:message key="sith.dashboard.home.loggedAs" />
                <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>Guest <%}%></p>
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


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.social.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.event.social.description" /></h2>

                <img src="https://abs.twimg.com/a/1381432172/images/resources/twitter-bird-light-bgs.png" style="float: right">
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td>
                            <div><fmt:message key="sith.dashboard.event.social.keywords" /></div>
                        </td>
                        <td>
                            <div>
                                <input name="start" id="topic"  type="text">
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
                            <div><fmt:message key="sith.dashboard.event.social.start" /></div>
                        </td>
                        <td>
                            <div>
                                <input name="start" id="start" value="<%=currentEvent.getStartDate()+" "+currentEvent.getStartTime()%>" type="text">
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
                            <div><fmt:message key="sith.dashboard.event.social.end" /></div>
                        </td>
                        <td>
                            <div>
                                <input name="end" id="end" value="<%=currentEvent.getEndDate()+" "+currentEvent.getEndTime()%>" type="text">
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
                            <div><fmt:message key="sith.dashboard.event.social.positivePercep" /> </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionPositive"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px"><fmt:message key="sith.dashboard.event.social.message" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <div><fmt:message key="sith.dashboard.event.social.neutralPercep" /> </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionNeutral"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px"><fmt:message key="sith.dashboard.event.social.message" /></div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div><fmt:message key="sith.dashboard.event.social.negativePercep" /> </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionNegative"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px"><fmt:message key="sith.dashboard.event.social.message" /></div>
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
                            <div align="center">
                                <span class="button" id="update" style="width: 150px"><fmt:message key="sith.dashboard.event.social.update" /></span>
                            </div>

                        </td>
                    </tr>
                </table>

            </form>
        </div>
    </section>

</section>

<script type="text/javascript">
    $("#update").click(function(){
        var topic = $("#topic").val();
        var start = $("#start").val();
        var end = $("#end").val();
        var eventID = '<%=currentEvent.getEventID()%>';
        var schema = $("#perceptionPositive").find(':selected').text()+":"+$("#perceptionNeutral").find(':selected').text()+":"+$("#perceptionNegative").find(':selected').text();
        console.log(topic+' '+schema);
        $.ajax({
            url: 'http://sithplatform.cse.mrt.ac.lk/TwitterSith/webresources/service',
            data: 'topic='+topic+'&start='+start+'&end='+end+'&id='+eventID+'&schema='+schema,
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded',
            dataType: 'text',
            success: function (data) {
                apprise("Successfully integrated with twitter!");
            },
            error: function (xhr, status, error) {
                apprise("Error updating event - " + error.message);
            }
        });
    });

</script>

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