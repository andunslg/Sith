<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.model.Event" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sith.model.Participant" %>
<!DOCTYPE html>
<html lang="">

<%

    SithAPI sithAPI=SithAPI.getInstance();

    if(session.getAttribute("isLogged")!=null)  {
        if( !(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    Participant participant=sithAPI.getParticipant(session.getAttribute("user").toString());
    ArrayList<Event> events=sithAPI.getUserEventList(participant.getUserID());
%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all" />
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all" />


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


    <script type="text/javascript">

        $(document).ready(function() {

        });


    </script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <input type="text" value="search" />
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/uiface2.jpeg" alt="" height="40" width="40" /> Welcome back <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
		<span class="button dropdown">
			<a href="#">Notifications <span class="pip"></span></a>
			<ul class="notice">
                <li>
                    <hgroup>
                        <h1>You have no notifications</h1>
                    </hgroup>
                </li>
            </ul>
		</span>
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="#"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="my_events.jsp"></span>My Events</a></li>
                <li><a href="join_events.jsp"></span>Join Events</a></li>
                <li><a href="add_events.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
    </ul>
</nav>



<section class="content">

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
                        <th>Administrator</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        for (Event event:events){
                    %>
                    <tr id="<%=event.getEventID()%>" class="event_rows">
                        <td class="avatar"><%=event.getEventName()%></td>
                        <%
                            if(event.getAdminID().equals(session.getAttribute("user").toString()))  { %>
                        <td>
                            Admin
                        </td>
                        <%
                        }
                        else{
                        %>
                        <td>
                            Participant
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
            </div>
        </header>

    </section>

</section>

<script type="text/javascript">

        $('.event_rows').click(function() {
           document.location.href='event.jsp'+'?eventID='+this.id;
        });


</script>
</body>
</html>