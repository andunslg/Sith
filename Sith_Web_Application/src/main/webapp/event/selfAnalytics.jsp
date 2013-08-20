<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="com.sith.SithAPI"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
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
    String currentPerceptionOfEvent = currentEvent.getEventID()+"_currentPerception";

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
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.wysiwyg.js"></script>
    <script type="text/javascript" src="../js/custom.js"></script>
    <script type="text/javascript" src="../js/cycle.js"></script>
    <script type="text/javascript" src="../js/jquery.checkbox.min.js"></script>
    <script type="text/javascript" src="../js/jquery.tablesorter.min.js"></script>
    <script type="text/javascript" src="../js/highCharts/highcharts.js"></script>
    <script type="text/javascript" src="../js/highCharts/modules/exporting.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
                countTimeChart('<%=SithAPI.GET_SELF_ANALYTICS%>?userID=<%=participant.getUserID()%>&eventID=<%=currentEvent.getEventID()%>');
        })
    </script>
    <script type="text/javascript" src="../js/charts/countTimeAnalysis.js"></script>
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong>SITH</strong> Dashboard</h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> Logged
                in
                as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
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
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="../index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon" style="font-size: 40px">&#8962;&thinsp;</span>Home</a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>My Perception</a>
        </li>
        <li>
            <a href="#"><span class="icon">&#128711;</span>Analytics</a>
            <ul class="submenu">
                <%
                    if(currentEvent.getAdminID().equals(participant.getUserID())){
                        if(currentDate.compareTo(eventEndDate)<0){
                %>
                <li><a href="realTimeAnalytics.jsp"></span>Realtime Analytics</a></li>
                <%
                    }
                %>
                <li><a href="nonRealTimeAnalytics.jsp"></span>Non Realtime Analytics</a></li>
                <%
                    }
                %>
                <li><a href="selfAnalytics.jsp"></span>Self Analytics</a></li>
            </ul>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
                if(currentDate.compareTo(eventEndDate)<0){
        %>
        <li>
            <a href="timeVariantParameters.jsp"><span class="icon">&#128711;</span>Temporal Params</a>
        </li>
        <%
                }
            }
        %>
        <li>
            <a href="questions.jsp"><span class="icon">&#59160;</span>Questions</a>
        </li>
        <li>
            <a href="participants.jsp"><span class="icon">&#128101;</span>Participants</a>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
        %>
        <li>
            <a href="eventAdmin.jsp"><span class="icon">&#128100;</span>Event Admin</a>
        </li>
        <%
            }
        %>
    </ul>
</nav>
<section class="alert">
    <div class="green">
        <span>Current event is <strong><%=currentEvent.getEventName()%></strong>, Click here to <a href="../myEvents.jsp">change</a></span>
        <span  id="current_perception"  style="margin: auto;float: right;display: none;">Current Perception is <strong></strong></span>
    </div>
</section>
<section class="content">
    <section class="widget">
        <header>
            <span class="icon">&#128200;</span>
            <hgroup>
                <h1>Self Statistics</h1>

                <h2>This is how your perceptions changed with the time</h2>
            </hgroup>
            <aside>
                <button class="left-btn">&#59229;</button>
                <button class="right-btn">&#59230;</button>
            </aside>
        </header>
        <div class="content">
            <p>Graph Type:</p><select id="perceptions"></select><br>
            <div id="TimeAnalysis" style="min-width: 400px; height: 400px;"></div>
        </div>
    </section>


</section>
<script type="text/javascript">

    window.onload=setCurrentPerception

    function setCurrentPerception(){
        if(sessionStorage.getItem("<%=currentPerceptionOfEvent%>")!= null ){
            var currentPerception = sessionStorage.getItem("<%=currentPerceptionOfEvent%>");
            $('#current_perception strong').html(currentPerception);
            $('#current_perception').show();
        }

    }
    // Feature slider for graphs
    $('.cycle').cycle({
        fx: "scrollHorz",
        timeout: 0,
        slideResize: 0,
        prev: '.left-btn',
        next: '.right-btn'
    });
</script>
</body>
</html>