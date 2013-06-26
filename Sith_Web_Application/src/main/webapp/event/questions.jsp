<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sith.perception.Perception" %>
<%@ page import="java.io.File" %>
<%@ page import="java.io.FileWriter" %>
<%@ page import="java.io.BufferedWriter" %>
<!DOCTYPE html>
<html lang="">
<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("../index.jsp");
        }
    }

    EventHandler eventHandler=new EventHandler();
    Event currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    String currentPerceptionOfEvent = currentEvent.getEventID()+"_currentPerception";
%>
<head>
    <meta charset="utf-8">
    <title>Sith</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <!--[if IE]>
    <link rel="stylesheet" href="css/ie.css" media="all"/><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong>Sith</strong></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/>Logged in
                as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
        </div>
        <div class="buttons">
            <button class="ico-font">&#9206;</button>
            <%--<span class="button dropdown">--%>
            <%--<a href="#">Notifications <span class="pip">4</span></a>--%>
            <%--<ul class="notice">--%>
            <%--<li>--%>
            <%--<hgroup>--%>
            <%--<h1>You have no new Notifications</h1>--%>
            <%--</hgroup>--%>
            <%--</li>--%>
            <%--</ul>--%>
            <%--</span>--%>
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="../index.jsp?state=loggedOut">Logout</a></span>
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
                %>
                <li><a href="realTimeAnalytics.jsp"></span>Realtime Analytics</a></li>
                <li><a href="nonRealTimeAnalytics.jsp"></span>Non Realtime Analytics</a></li>
                <%
                    }
                %>
                <li><a href="selfAnalytics.jsp"></span>Self Analytics</a></li>
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
            <a href="eventAdmin.jsp"><span class="icon">&#128100;</span>Event Admin</a>
        </li>
        <%
            }
        %>
    </ul>
</nav>

<section class="alert">
    <div class="green">
        <span>Current event is <strong><%=currentEvent.getEventName()%></strong>, Click here to <a href="../myEvents.jsp">change</a></span>
        <span  id="current_perception"  style="margin: auto;float: right;display: none;">Current Perception is <strong></strong></span>
    </div>
</section>

<section class="content">
    <%
        if(participant.getUserID().equals(currentEvent.getAdminID())){
    %>
    <section class="widget" style="min-height: 100px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Enable User Comments</h1>

                <h2>Enable the commenting functionality for users</h2>
            </hgroup>
        </header>
        <%
            if("false".equals(currentEvent.getCommentEnabled())) {
        %>
        <div class="content" align="center" style="vertical-align: middle">
            <input type="button" class="button" id="commentEnable" value="Enable User Comments" style="width: 160px">
        </div>
        <%
        }
        else{
        %>
        <div class="content" align="center" style="vertical-align: middle">
            <br>
            <input type="button" class="button" id="commentDisable" value="Disable User Comments" style="width: 160px">
        </div>
        <%
            }
        %>
    </section>
    <%
        }
    %>
    <%
        if("true".equals(currentEvent.getCommentEnabled())){
    %>

    <section class="widget" style="min-height: 200px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Your Comment</h1>
                <h2>Enter your comment</h2>
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td style="width: 200px">
                            <div>
                                <%=currentEvent.getEventName()%> was &nbsp; &nbsp;
                            </div>
                        </td>
                        <td>
                            <div>
                                <select id="overallPerception">
                                    <%
                                        String perceptionArr[]=currentEvent.getPerceptionSchema().split(":");
                                        for(int i=0;i<perceptionArr.length;i++){
                                            if(i ==0){
                                    %>
                                    <option selected="selected" value="<%=perceptionArr[i]%>"><%=perceptionArr[i]%></option>
                                    <%
                                    }
                                    else{
                                    %>
                                    <option value="<%=perceptionArr[i]%>"><%=perceptionArr[i]%></option>
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
                    <tr>
                        <td style="width: 200px">
                            <div> Your Comment </div>
                        </td>
                        <td>
                            <br>
                            <div>
                                <input id="comment" type="text" value="" style="width: 600px;height: 200px; vertical-align: middle">
                            </div>
                        </td>
                    </tr>
                </table>
                <br>
                <div align="center" >
                    <input id="addComment" value="Post" type="button" class="button" style="width: 160px">
                </div>
            </form>
        </div>
    </section>
    <%
        }
    %>
    <%
        if(currentEvent.getAdminID().equals(participant.getUserID())){
    %>
    <section class="widget">
        <header>
            <span class="icon">&#59168;</span>
            <hgroup>
                <h1>Comments</h1>

                <h2>What others saying?</h2>
            </hgroup>
        </header>
        <div class="content no-padding timeline">
            <div class="tl-post comments">
                <%

                    ArrayList<Perception> list=eventHandler.getComments(currentEvent.getEventID());
                    for(Perception p : list){

                %>
                <span class="icon">&#59168;</span>

                <p>
                    <strong>
                        <%=p.getUserID() %> is feeling <%=p.getPerceptionValue() %> about  <%=eventHandler.getEvent(p.getEventID()).getEventName() %> and  <%=p.getUserID() %>'s comment is  <%=p.getText() %>
                    </strong>
                </p>
                <%}
                    File file = new File(System.getProperty("java.io.tmpdir")+File.separator+"report1"+currentEvent.getEventID()+".csv");

                    file.createNewFile();


                    FileWriter fw = new FileWriter(file.getAbsoluteFile());
                    BufferedWriter bw = new BufferedWriter(fw);
                    bw.write("Name,No,Comment,,");
                    for(Perception p : list){
                    bw.newLine();
                    bw.write(p.getUserID()+","+p.getPerceptionValue()+","+p.getText()+",,");
                }
                bw.close();
                fw.close();%>
            </div>
        </div>
    </section>
    <%
        }
    %>
</section>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="../js/jquery.wysiwyg.js"></script>
<script src="../js/custom.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.checkbox.min.js"></script>
<script src="../js/jquery.tablesorter.min.js"></script>

<script>
    window.onload=setCurrentPerception

    function setCurrentPerception(){
        if(sessionStorage.getItem("<%=currentPerceptionOfEvent%>")!= null ){
            var currentPerception = sessionStorage.getItem("<%=currentPerceptionOfEvent%>");
            $('#current_perception strong').html(currentPerception);
            $('#current_perception').show();
        }

    }
    $("#addComment").click(function () {
        var eventID = '<%=currentEvent.getEventID()%>';
        var userID = '<%=participant.getUserID()%>';
        var comment = $('input[id=comment]').val();
        var perception = $("#overallPerception").val();

        var datObj = {};

        datObj['eventID'] = eventID;
        datObj['userID'] = userID;
        datObj['text'] = comment;
        datObj['perceptionValue'] = perception;

        $.ajax({
            url: './publishCommentHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                var $response = $(data);
                var msg = $response.filter('#msg').text();
                alert(msg)
                window.location.reload();
            },
            error: function (xhr, status, error) {
                alert("Error adding event - " + error.message);
            }
        });

    });

    $("#commentEnable").click(function () {
        var eventID = '<%=currentEvent.getEventID()%>';
        var eventName = '<%=currentEvent.getEventName()%>';
        var start = '<%=currentEvent.getStartDate()+" "+currentEvent.getStartTime()%>';
        var end = '<%=currentEvent.getEndDate()+" "+currentEvent.getEndTime()%>';
        var location = '<%=currentEvent.getLocation()%>';
        var description = '<%=currentEvent.getDescription()%>';
        var perceptionSchema = '<%=currentEvent.getPerceptionSchema()%>';
        var eventAdmin='<%=participant.getUserID()%>';
        var commentEnabled = 'true';


        var datObj = {};

        datObj['oldEventID'] =eventID;
        datObj['eventID'] = eventID;
        datObj['eventName'] = eventName;
        datObj['eventAdmin'] =eventAdmin;
        datObj['start'] = start;
        datObj['end'] = end;
        datObj['location'] = location;
        datObj['description'] = description;
        datObj['perceptionSchema'] = perceptionSchema;
        datObj['commentEnabled'] = commentEnabled;


        $.ajax({
            url: 'updateEventHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                if (data.indexOf("The Event is successfully updated.") != -1) {
                    alert("Comments enabled successfully")
                    window.location.reload();
                }
            },
            error: function (xhr, status, error) {
                alert("Error enabling comments - " + error.message);
            }
        });

    });

    $("#commentDisable").click(function () {
        var eventID = '<%=currentEvent.getEventID()%>';
        var eventName = '<%=currentEvent.getEventName()%>';
        var start = '<%=currentEvent.getStartDate()+" "+currentEvent.getStartTime()%>';
        var end = '<%=currentEvent.getEndDate()+" "+currentEvent.getEndTime()%>';
        var location = '<%=currentEvent.getLocation()%>';
        var description = '<%=currentEvent.getDescription()%>';
        var perceptionSchema = '<%=currentEvent.getPerceptionSchema()%>';
        var eventAdmin='<%=participant.getUserID()%>';
        var commentEnabled = 'false';


        var datObj = {};

        datObj['oldEventID'] =eventID;
        datObj['eventID'] = eventID;
        datObj['eventName'] = eventName;
        datObj['eventAdmin'] =eventAdmin;
        datObj['start'] = start;
        datObj['end'] = end;
        datObj['location'] = location;
        datObj['description'] = description;
        datObj['perceptionSchema'] = perceptionSchema;
        datObj['commentEnabled'] = commentEnabled;


        $.ajax({
            url: 'updateEventHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                if (data.indexOf("The Event is successfully updated.") != -1) {
                    alert("Comments enabled successfully")
                    window.location.reload();
                }
            },
            error: function (xhr, status, error) {
                alert("Error enabling comments - " + error.message);
            }
        });
    });
</script>
</body>
</html>