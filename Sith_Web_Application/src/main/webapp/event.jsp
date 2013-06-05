<%@ page import="com.sith.login.SithAPI" %>
<%@ page import="com.sith.model.Participant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="">
<% SithAPI sithAPI=new SithAPI(); %>
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
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
		<li>
            <a href="perceptions.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>Perceptions</a>
        </li>
         <li >
            <a href="dashboard.jsp"><span class="icon">&#128711;</span>Analytics</a>
        </li>
         <li>
            <a href="questions.jsp"><span class="icon">&#59160;</span>Questions</a>
        </li>
         <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>     
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
                <% List<Participant> participantList=new ArrayList<Participant>();
                    participantList=sithAPI.getParticipants("dkkdnk");
                   for(Participant participant:participantList){
                %>
                <tr>
                    <td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" /> <%=participant.getName()%></td>
                    <td><%=participant.getMode()%></td>
                    <td><%=participant.getTime()%></td>
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