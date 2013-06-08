<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.model.Participant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sith.model.Event" %>
<!DOCTYPE html>
<html lang="">
<%
    if(session.getAttribute("isLogged")!=null)  {
        if( !(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    SithAPI sithAPI=SithAPI.getInstance();
    Event currentEvent=currentEvent=sithAPI.getEvent(session.getAttribute("eventID").toString());
    Participant participant=sithAPI.getParticipant(session.getAttribute("user").toString());
%>
<head>
    <meta charset="utf-8">
    <title>Sith Dashboard</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all" />
    <!--[if IE]><link rel="stylesheet" href="css/ie.css" media="all" /><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong>Sith</strong></h1>
        <input type="text" value="search" />
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40" />Logged in as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%> </p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<span class="button dropdown">
			<a href="#">Notifications <span class="pip">4</span></a>
			<ul class="notice">
                <li>
                    <hgroup>
                        <h1>You have no new Notifications</h1>
                    </hgroup>
                </li>
            </ul>
		</span>
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9790;&thinsp;</span>Home</a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>My Perception</a>
        </li>
        <li>
            <a href="#"><span class="icon">&#128711;</span>Analytics</a>
            <ul class="submenu">
                <li><a href="realTimeAnalytics.jsp"></span>Realtime Analytics</a></li>
                <li><a href="nonRealTimeAnalytics.jsp"></span>Non Realtime Analytics</a></li>
            </ul>
        </li>
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
            <a href="event_admin.jsp"><span class="icon">&#128100;</span>Event Admin</a>
        </li>
        <%
            }
        %>
	</ul>
</nav>

<section class="alert">
    <div class="green">
        <p>Current event is <a href="#">Workshop1</a> , Click here to <a href="#">change</a> </p>
        <%--<span class="close">&#10006;</span>--%>
    </div>
</section>

<section class="content">
    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Participants</h1>
                <h2>Participants of this event</h2>
            </hgroup>
        </header>
        <div class="content">
            <table id="myTable" border="0" width="100">
                <thead>
                <tr>
                    <th class="avatar">Name</th>
                    <th>Feeling</th>
                    <th>Time</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<Participant> participantList=new ArrayList<Participant>();
                    participantList=sithAPI.getParticipants("dkkdnk");
                   for(Participant temp:participantList){
                %>
                <tr>
                    <td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" /> <%=temp.getUserName()%></td>
                    <td><%=temp.getMode()%></td>
                    <td><%=temp.getTime()%></td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </section>
</section>
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
</body>
</html>