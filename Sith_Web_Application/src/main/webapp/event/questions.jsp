<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.sith.perception.Perception" %>
<!DOCTYPE html>
<html lang="">
<%
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    EventHandler eventHandler=new EventHandler();
    Event currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
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
        <input type="text" value="search"/>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/>Logged in
                as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
                Guest <%}%></p>
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
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#8962;&thinsp;</span>Home</a>
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

<section class="content">
    <section class="widget" style="height: 75px">
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
                        <td>
                            <br>
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
                            <div> Your Comment </div>
                        </td>
                        <td>
                            <br>
                            <div>
                                <input id="comment" type="text" value="">
                            </div>
                        </td>
                    </tr>
                </table>
                <br>
                <div>
                    <input id="addComment" value="Post" type="button" class="button">
                </div>
            </form>
        </div>
    </section>

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
                <%}%>
            </div>
        </div>
    </section>
</section>


<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="../js/jquery.wysiwyg.js"></script>
<script src="../js/custom.js"></script>
<script src="../js/cycle.js"></script>
<script src="../js/jquery.checkbox.min.js"></script>
<script src="../js/jquery.tablesorter.min.js"></script>

<script>
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
            },
            error: function (xhr, status, error) {
                alert("Error adding event - " + error.message);
            }
        });

    });
</script>
</body>
</html>