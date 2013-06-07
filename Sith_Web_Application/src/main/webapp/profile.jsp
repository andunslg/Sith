<!DOCTYPE html>
<html lang="">
<%  if(session.getAttribute("isLogged")!=null)  {
    if( !(Boolean)session.getAttribute("isLogged")){
        response.sendRedirect("index.jsp");
    }
}
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
            <a href="#"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="my_events.jsp"></span>My Event</a></li>
                <li><a href="join_events.jsp"></span>Join Events</a></li>
                <li><a href="add_events.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
    </ul>
</nav>

<section class="alert">
    <div class="green">

    </div>
</section>

<section class="content">
    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>My Profile</h1>
                <h2>Edit and Save the profile</h2>
            </hgroup>
        </header>
        <div class="content">
            <table>
                <tr>
                    <td >
                        <div>User name</div>
                    </td>
                    <td>
                        <div>
                            <input value=<% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%> readonly>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Old Pasword</div>
                    </td>
                    <td>
                        <div>
                            <input id="old password" type="password">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>New Pasword</div>
                    </td>
                    <td>
                        <div>
                            <input id="new password" type="password">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div >Confirm New Pasword &nbsp;&nbsp;&nbsp;</div>
                    </td>
                    <td>
                        <div>
                            <input id="new password confirm" type="password">
                        </div>
                    </td>
                </tr>
            </table>
            <div>
                <input id="update" type="button" value="Update" class="button">
            </div>
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