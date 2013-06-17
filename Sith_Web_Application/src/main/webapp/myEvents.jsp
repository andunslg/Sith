<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all"/>


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
                <h1>My Events</h1>

                <h2>Events I am administrating and registered</h2>
            </hgroup>

            <div class="content">
                <%--This have to be formalized, This is a hack--%>
                <br>
                <br>
                <br>
                <br>
                <br>
                <br>
                <table id="myTable" border="0" width="100">
                    <thead>
                    <tr>
                        <th class="avatar">Name</th>
                        <th>Type</th>
                        <th>Change</th>
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
                            Admin
                        </td>
                        <td>
                            <span class="button"><a href="event/eventAdmin.jsp?eventID=<%=event.getEventID()%>">Admin Panel</a></span>
                        </td>
                        <%
                        }else{
                        %>
                        <td>
                            Participant
                        </td>
                        <td>
                            <span class="button"><a href="event/removeUserFromEventHandler.jsp?eventID=<%=event.getEventID()%>&userID=<%=participant.getUserID()%>">Un-register</a></span>
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
                    Following events have been deleted by there admins. So they have been removed form your registration list. There event ID's are <%=deletedEvents%>
                </div>
                <%
                    }
                %>
            </div>
        </header>

    </section>

</section>

<script type="text/javascript">

    $('.event_rows').click(function () {
        document.location.href = 'event/event.jsp' + '?eventID=' + this.id;
    });


</script>
</body>
</html>