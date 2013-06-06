<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>Sith Dashboard</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all" />
    <script  type = "text/javascript" src ="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
    <script type = "text/javascript" src = "js/jquery.wysiwyg.js"></script>
    <script type = "text/javascript" src = "js/custom.js"></script>
    <script type = "text/javascript" src = "js/cycle.js"></script>
    <script type = "text/javascript" src = "js/jquery.checkbox.min.js"></script>
    <script type = "text/javascript" src = "js/jquery.tablesorter.min.js"></script>
    <script type = "text/javascript" src = "js/highCharts/highcharts.js"></script>
    <script type = "text/javascript" src = "js/highCharts/modules/exporting.js"></script>
    <script type = "text/javascript" src = "js/charts/realTimePercepGraph.js"></script>
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong>SITH</strong> Dashboard</h1>
        <input type="text" value="search" />
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40" /> Logged in as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%> </p>
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
        <p>Current event is <a href="event.jsp">Workshop1</a> , Click here to <a href="#">change</a> </p>
        <%--<span class="close">&#10006;</span>--%>
    </div>
</section>
<section class="content">
    <section class="widget">
        <header>
            <span class="icon">&#128200;</span>
            <hgroup>
                <h1>Event Statistics</h1>
                <h2>Public view</h2>
            </hgroup>
            <aside>
                <button class="left-btn">&#59229;</button><button class="right-btn">&#59230;</button>
            </aside>
        </header>
        <div class="content">
            <div id="LiveChart" style="min-width: 400px; height: 400px; margin: 0 auto"></div></br></br>
            <div id="TotLiveChart" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
        </div>
    </section>


</section>
<script type="text/javascript">
    // Feature slider for graphs
    $('.cycle').cycle({
        fx: "scrollHorz",
        timeout: 0,
        slideResize: 0,
        prev:    '.left-btn',
        next:    '.right-btn'
    });
</script>
</body>
</html>