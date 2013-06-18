<!DOCTYPE html>
<html lang="">

<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
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


    <script src="js/jquery-1.7.1.min.js"></script>
    <script src="js/jquery-ui.js"></script>
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
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span>My Events</a></li>
                <li><a href="joinEvents.jsp"></span>Join Events</a></li>
                <li><a href="addEvents.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
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