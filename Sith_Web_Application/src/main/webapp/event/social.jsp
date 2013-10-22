<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="">

<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
    SithAPI sithAPI=SithAPI.getInstance();
    EventHandler eventHandler=new EventHandler();

    Event currentEvent=null;
    if(request.getParameter("eventID")!=null){
        currentEvent=eventHandler.getEvent(request.getParameter("eventID").toString());
        session.setAttribute("eventID",currentEvent.getEventID());
    }else{
        currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    }

    String arr[]=currentEvent.getPerceptionSchema().split(":");
    List<String> perceptionListSelected=Arrays.asList(arr);
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    DateFormat dateFormat1 = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    Date currentDate = new Date();
    Date eventEndDate=dateFormat1.parse(currentEvent.getEndDate()+" "+currentEvent.getEndTime());
%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <link rel="stylesheet" href="../css/button_style.css" media="all"/>
    <link rel="stylesheet" href="../css/apprise.min.css" media="all"/>
    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="../css/jquery-ui-timepicker-addon.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="../js/jquery-ui-timepicker-addon.js"></script>
    <script src="../js/apprise-1.5.min.js"></script>
    <script src="../js/jquery-migrate-1.0.0.js"></script>
</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> Welcome
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
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="../index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon" style="font-size: 40px">&#8962;&thinsp;</span>Home</a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>My Perception</a>
        </li>
        <li>
            <a href="#"><span class="icon">&#128711;</span>Analytics</a>
            <ul class="submenu">
                <%
                    if(currentEvent.getAdminID().equals(participant.getUserID())){
                        if(currentDate.compareTo(eventEndDate)<0){
                %>
                <li><a href="realTimeAnalytics.jsp"></span>Realtime Analytics</a></li>
                <%
                    }
                %>
                <li><a href="nonRealTimeAnalytics.jsp"></span>Non Realtime Analytics</a></li>
                <%
                    }
                %>
                <li><a href="selfAnalytics.jsp"></span>Self Analytics</a></li>
            </ul>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
                if(currentDate.compareTo(eventEndDate)<0){
        %>
        <li>
            <a href="timeVariantParameters.jsp"><span class="icon">&#128711;</span>Temporal Params</a>
        </li>
        <%
                }
            }
        %>
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
            <a href="eventAdmin.jsp"><span class="icon">&#128100;</span>Event Admin</a>
        </li>
        <%
            }
        %>
    </ul>
</nav>

<section class="alert">
    <div class="green">
        <p>Current event is <%=currentEvent.getEventName()%> , Click here to <a href="../myEvents.jsp">change</a></p>
    </div>
</section>


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Integrate Social Networks</h1>

                <h2>Twitter Integration</h2>

                <img src="https://abs.twimg.com/a/1381432172/images/resources/twitter-bird-light-bgs.png" style="float: right">
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td>
                            <div>Key words</div>
                        </td>
                        <td>
                            <div>
                                <input name="start" id="topic"  type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Start</div>
                        </td>
                        <td>
                            <div>
                                <input name="start" id="start" value="<%=currentEvent.getStartDate()+" "+currentEvent.getStartTime()%>" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>End</div>
                        </td>
                        <td>
                            <div>
                                <input name="end" id="end" value="<%=currentEvent.getEndDate()+" "+currentEvent.getEndTime()%>" type="text">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <div>Positive Perception: </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionPositive"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px">If you change perception schema, make sure to define the color schema</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>


                    <tr>
                        <td>
                            <div>Neutral Perception: </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionNeutral"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px">If you change perception schema, make sure to define the color schema</div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>

                    <tr>
                        <td>
                            <div>Negative Perception: </div>
                        </td>
                        <td>
                            <select multiple="single" name="perceptionSchema" id="perceptionNegative"
                                    style="width: 400px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){

                                %>
                                <option name="<%=perception%>" value="<%=perception%>"><%=perception%></option>
                                <%
                                    }
                                %>
                            </select>
                            <div style="padding-top: 8px">If you change perception schema, make sure to define the color schema</div>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                        <td>
                            <div align="center">
                                <input id="update" value="Update" type="button" class="button" style="text-align: center;width: 100px">
                            </div>

                        </td>
                    </tr>
                </table>

            </form>
        </div>
    </section>

</section>

<script type="text/javascript">
    $("#update").click(function(){
        var topic = $("#topic").val();
        var start = $("#start").val();
        var end = $("#end").val();
        var eventID = '<%=currentEvent.getEventID()%>';
        var schema = $("#perceptionPositive").find(':selected').text()+":"+$("#perceptionNeutral").find(':selected').text()+":"+$("#perceptionNegative").find(':selected').text();
        console.log(topic+' '+schema);
        $.ajax({
            url: 'http://sithplatform.cse.mrt.ac.lk/TwitterSith/webresources/service',
            data: 'topic='+topic+'&start='+start+'&end='+end+'&id='+eventID+'&schema='+schema,
            type: 'POST',
            contentType: 'application/x-www-form-urlencoded',
            dataType: 'text',
            success: function (data) {
                apprise("Successfully integrated with twitter!");
            },
            error: function (xhr, status, error) {
                apprise("Error updating event - " + error.message);
            }
        });
    });

</script>

<script src="../js/jquery.wysiwyg.js"></script>
<script src="../js/custom.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.checkbox.min.js"></script>
<script src="../js/flot.js"></script>
<script src="../js/flot.resize.js"></script>
<script src="../js/flot-graphs.js"></script>
<script src="../js/flot-time.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.tablesorter.min.js"></script>
</body>
</html>