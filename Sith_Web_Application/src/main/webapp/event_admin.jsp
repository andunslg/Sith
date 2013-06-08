<%@ page import="com.sith.model.Event" %>
<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.model.Participant" %>
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
    <title>SITH Dashboard</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all" />
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all" />
    <link rel="stylesheet" type="text/css" href="css/carousel.css" media="screen" alt="">
    <link rel="stylesheet" type="text/css" href="css/tooltipster.css" />

    <script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="js/jquery.carousel.min.js"></script>
    <script type="text/javascript" src="js/jquery.mousewheel.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script type="text/javascript" src="js/jquery.tooltipster.min.js"></script>

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

        function postToAPI(eventID,userID,perceptionValue){
            $.ajax({
                url: 'http://192.248.8.246:3000/publishEventPerception',
                data: 'eventID='+eventID+'&userID='+userID+'&perceptionValue='+perceptionValue,
                type: 'POST',
                success: function (data) {
                    console.log('Success: ')
                },
                error: function (xhr, status, error) {
                    console.log('Error: ' + error.message);
                }
            });
        }

        $(document).ready(function() {
            $('.thumbnail').tooltipster();
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
        <p>Current event is <%=currentEvent.getEventName()%> , Click here to <a href="my_events.jsp">change</a> </p>
    </div>
</section>


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Event Admin Panel</h1>
                <h2>Event Details</h2>
            </hgroup>
        </header>
        <div class="content">
            <table>
                <tr>
                    <td >
                        <div>Event Name</div>
                    </td>
                    <td>
                        <div>
                            <input id="eventName" value="<%=currentEvent.getEventName()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Start time</div>
                    </td>
                    <td>
                        <div>
                            <input id="statTime" value="<%=currentEvent.getStartTime()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>End Time</div>
                    </td>
                    <td>
                        <div>
                            <input id="endTime" value="<%=currentEvent.getEndTime()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Date</div>
                    </td>
                    <td>
                        <div>
                            <input id="date" value="<%=currentEvent.getDate()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Location</div>
                    </td>
                    <td>
                        <div>
                            <input id="location" value="<%=currentEvent.getLocation()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Description</div>
                    </td>
                    <td>
                        <div>
                            <input id="description" value="<%=currentEvent.getDescription()%>" type="text">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td >
                        <div>Perception Schema &nbsp;&nbsp;&nbsp;</div>
                    </td>
                    <td>
                        <div>
                            <input id="perceptionSchema"value="<%=currentEvent.getPerceptionSchema()%>" type="text">
                        </div>
                    </td>
                </tr>
            </table>
            <div>
                <input id="update" value="Update" type="button" class="button">
            </div>
            <div>
                <input id="delete" value="Delete Event" type="button" class="button">
            </div>
        </div>
    </section>

</section>

</body>
</html>