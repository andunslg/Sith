<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="">

<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    ArrayList<String> perceptionList=new ArrayList<String>();
    perceptionList.add("Excited");
    perceptionList.add("Amazing");
    perceptionList.add("Happy");
    perceptionList.add("Interested");
    perceptionList.add("Satisfied");
    perceptionList.add("Bored");
    perceptionList.add("Sleepy");
    perceptionList.add("Depressed");
    perceptionList.add("Frustrated");
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
        <input type="text" value="search"/>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/uiface2.jpeg" alt="" height="40" width="40"/> Welcome
                back <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
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


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Add new event</h1>

                <h2>Enter Event Details</h2>
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td>
                            <div>Event ID</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventID" id="eventID" value="Unique event ID" type="text"
                                       style="width: 400px">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Event Name</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventName" id="eventName" value="Event Name" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Start time</div>
                        </td>
                        <td>
                            <div>
                                <input name="startTime" id="startTime" value="hh" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>End Time</div>
                        </td>
                        <td>
                            <div>
                                <input name="endTime" id="endTime" value="hh" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Date</div>
                        </td>
                        <td>
                            <div>
                                <input name="date" id="date" value="dd-mm-yyyy" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Location</div>
                        </td>
                        <td>
                            <div>
                                <input name="location" id="location" value="Event Location" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Description</div>
                        </td>
                        <td>
                            <div>
                                <input name="description" id="description" value="Description" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Perception Schema &nbsp;&nbsp;&nbsp;</div>
                        </td>
                        <td>
                            <div>
                                <select multiple="multiple" name="perceptionSchema" id="perceptionSchema"
                                        style="width: 400px">
                                    <%
                                        for(String perception : perceptionList){
                                            if(perception.equals("Happy")){
                                    %>
                                    <option name="<%=perception%>" value="<%=perception%>"
                                            selected="selected"><%=perception%>
                                    </option>
                                    <%
                                    }else{
                                    %>
                                    <option name="<%=perception%> " value="<%=perception%>"><%=perception%>
                                    </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <div>
                    <input id="addEvent" value="Add" type="button" class="button">
                </div>
            </form>

        </div>
    </section>
</section>

<script>
    $("#addEvent").click(function () {
        var eventID = $('input[id=eventID]').val();
        var eventName = $('input[id=eventName]').val();
        var startTime = $('input[id=startTime]').val();
        var endTime = $('input[id=endTime]').val();
        var date = $('input[id=date]').val();
        var location = $('input[id=location]').val();
        var description = $('input[id=description]').val();

        var perceptionSchema = "";
        $('#perceptionSchema :selected').each(function (i, selected) {
            if (i == 0) {
                perceptionSchema += $(selected).text();
            }
            else {
                perceptionSchema += ':' + $(selected).text();
            }

        });

        var datObj = {};

        datObj['eventID'] = eventID;
        datObj['eventName'] = eventName;
        datObj['startTime'] = startTime;
        datObj['endTime'] = endTime;
        datObj['date'] = date;
        datObj['location'] = location;
        datObj['description'] = description;
        datObj['perceptionSchema'] = perceptionSchema;


        $.ajax({
            url: 'event/addEventHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                var $response = $(data);
                var msg = $response.filter('#msg').text()
                alert(msg)
                if (msg == 'The Event is successfully added.' || msg == 'The Event is not added. Please try later!') {
                    window.location.href = '../myEvents.jsp';
                }
            },
            error: function (xhr, status, error) {
                alert("Error adding event - " + error.message);
            }
        });

    });
</script>


</body>
</html>