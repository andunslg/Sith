<%@ page import="com.sith.login.SithAPI" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="">
<% SithAPI sithAPI=new SithAPI(); %>
<head>
    <meta charset="utf-8">
    <title>Sith</title>
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
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40" />Logged in as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%></p>
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
            <a href="perceptions.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>My Perception</a>
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
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
    </ul>
</nav>

<section class="alert">
    <div class="green">
        <p>Current event is <a href="eventt.jsp">Workshop1</a> , Click here to <a href="#">change</a> </p>
        <%--<span class="close">&#10006;</span>--%>
    </div>
</section>

<section class="content">

    <form method="POST" action="perceptions.jsp">
        <input  name="user" type="text" value="Email" />
        <input name="password" value="Password" type="password" />
    </form>

    <section class="widget">
        <header>
            <span class="icon">&#59168;</span>
            <hgroup>
                <h1>Comments</h1>
                <h2>What they're saying</h2>
            </hgroup>
        </header>
        <div class="content no-padding timeline">
            <div class="tl-post comments">
                <%List<String> list=sithAPI.getComments("kdnka");
                    String[] temp=null;
                    for(String s:list){
                        temp=s.split("::");
                    %>
                <span class="icon">&#59168;</span>
                <p>
                    <strong><%=temp[0] %></strong><br />
                    <%=temp[1] %>
                </p>
                <%}%>
            </div>
        </div>
    </section>
</section>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="js/jquery.wysiwyg.js"></script>
<script src="js/custom.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.checkbox.min.js"></script>
<!--<script src="js/flot.js"></script>
<script src="js/flot.resize.js"></script>
<script src="js/flot-graphs.js"></script>
<script src="js/flot-time.js"></script>
<script src="js/cycle.js"></script>-->
<script src="js/jquery.tablesorter.min.js"></script>
</body>
</html>