<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="com.sith.perception.Perception" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />
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

    DateFormat dateFormat1 = new SimpleDateFormat("MM/dd/yyyy HH:mm");
    Date currentDate = new Date();

    Date eventEndDate=dateFormat1.parse(currentEvent.getEndDate()+" "+currentEvent.getEndTime());

    String colors="\"\"";

    if(!currentEvent.getColors().equals("")){
        colors=currentEvent.getColors();
    }
    String latLang=currentEvent.getLatLng().toString();
%>
<head>
    <meta charset="utf-8">
    <title>Sith</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="../css/style.css" media="all"/>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <!--[if IE]>
    <link rel="stylesheet" href="css/ie.css" media="all"/><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong> <fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/><fmt:message key="sith.dashboard.home.loggedAs" />
                <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>Guest <%}%></p>
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
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://sithplatform.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="../index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon"><i class="fa fa-home fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.home" /></a>
        </li>
        <li>
            <a href="event.jsp"><span class="icon"><i class="fa fa-thumbs-up fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.myPerception" /></a>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-dashboard fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.analytics" /></a>
            <ul class="submenu">
                <%
                    if(currentEvent.getAdminID().equals(participant.getUserID())){
                        if(currentDate.compareTo(eventEndDate)<0){
                %>
                <li><a href="realTimeAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.realTimeAnalitics" /></a></li>
                <%
                    }
                %>
                <li><a href="nonRealTimeAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.postAnalitics" /></a></li>
                <%
                    }
                %>
                <li><a href="selfAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.selfAnalytics" /></a></li>

            </ul>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
                if(currentDate.compareTo(eventEndDate)<0){
        %>
        <li>
            <a href="timeVariantParameters.jsp"><span class="icon"><i class="fa fa-clock-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.temporalParams" /></a>
        </li>
        <%
                }
            }
        %>
        <li>
            <a href="questions.jsp"><span class="icon"><i class="fa fa-comments fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.comments" /></a>
        </li>
        <li>
            <a href="participants.jsp"><span class="icon"><i class="fa fa-users fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.participants" /></a>
        </li>
        <%
            if(currentEvent.getAdminID().equals(participant.getUserID())){
        %>
        <li>
            <a href="eventAdmin.jsp"><span class="icon"><i class="fa fa-cogs fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.settings" /></a>
        </li>
        <li>
            <a href="social.jsp"><span class="icon"><i class="fa fa-twitter fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.event.menu.socilaMediaInt" /></a>
        </li>
        <%
            }
        %>
    </ul>
</nav>
<section class="alert">
    <div class="green">
        <span><fmt:message key="sith.dashboard.event.CurrentEventIs" /> <strong><%=currentEvent.getEventName()%></strong>, <fmt:message key="sith.dashboard.event.clickToChange" /> <a href="../myEvents.jsp" style="color:#00477b"><fmt:message key="sith.dashboard.myEvents.Change" /></a></span>
        <span  id="current_perception"  style="margin: auto;float: right;display: none;"><fmt:message key="sith.dashboard.event.CurrentPerceptionIs" /> <strong></strong></span>
    </div>
</section>

<section class="content">
    <%
        if(participant.getUserID().equals(currentEvent.getAdminID())){
            if(currentDate.compareTo(eventEndDate)<0){
    %>
    <section class="widget" style="min-height: 100px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.comment.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.event.comment.description" /></h2>
            </hgroup>
        </header>
        <%
            if("false".equals(currentEvent.getCommentEnabled())) {
        %>
        <div class="content" align="center" style="vertical-align: middle">
            <input type="button" class="button" id="commentEnable" value="<fmt:message key="sith.dashboard.event.comment.enable" />" style="width: 160px">
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
            }
        %>
    <%--</section>--%>
    <%
        }
    %>
    <%
        if("true".equals(currentEvent.getCommentEnabled())){
            if(currentDate.compareTo(eventEndDate)<0){
    %>

    <section class="widget" style="min-height: 200px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.comment.yourComment" /></h1>
                <h2><fmt:message key="sith.dashboard.event.comment.enterYourComment" /></h2>
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
                            <br> <br> <br> <br>
                            <div style="vertical-align: middle"> <fmt:message key="sith.dashboard.event.comment.yourComment" /></div>
                        </td>
                        <td>
                            <br>

                            <form method="post" action="">
                                <textarea id="comment" value ="" name="comments" cols="100" rows="5" placeholder="<fmt:message key="sith.dashboard.event.comment.enterYourComment" /> ..."></textarea>
                                <br>
                            </form>
                        </td>
                    </tr>
                </table>
                <br>
                <div align="center" >
                    <input id="<fmt:message key="sith.dashboard.event.comment.add" />" value="Post" type="button" class="button" style="width: 160px">
                </div>
            </form>
        </div>
    </section>
    <%
            }
        }
    %>
    <%
        if(currentEvent.getAdminID().equals(participant.getUserID())){
    %>
    <section class="widget">
        <header>
            <span class="icon">&#59168;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.comment.comment.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.event.comment.comment.description" /></h2>
            </hgroup>
            <div class="buttons">

                <input type="button" id="download"  value="<fmt:message key="sith.dashboard.event.comment.download" />" class="button" style="width: 160px">

            </div>
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

    $("#download").click(function () {

        window.location= "getCommentPDF.jsp";

    });

    $("#addComment").click(function () {
        var eventID = '<%=currentEvent.getEventID()%>';
        var userID = '<%=participant.getUserID()%>';
        var comment = $('textarea[id=comment]').val();
        var perception = $("#overallPerception").val();

        var datObj = {};

        datObj['eventID'] = eventID;
        datObj['userID'] = userID;
        datObj['text'] = comment;
        datObj['perceptionValue'] = perception;

        if(comment != ""){
            $.ajax({
                url: './publishCommentHandler.jsp',
                data: datObj,
                type: 'POST',
                success: function (data) {
                    var $response = $(data);
                    var msg = $response.filter('#msg').text();
                    alert(msg)
                    window.location.href='event.jsp';
                },
                error: function (xhr, status, error) {
                    alert("Error adding event - " + error.message);
                }
            });
        }else{
            alert("The comment should not be empty!");
        }

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

        datObj['latLng'] = JSON.stringify(<%=latLang%>);
        datObj['fixedLocation'] = <%=currentEvent.isFixedLocation()%>;
        datObj['colors'] = <%=colors%>;
        datObj['timeVariantParams'] = "<%=currentEvent.getTimeVariantParamsAsString()%>";


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

        datObj['latLng'] = JSON.stringify(<%=latLang%>);
        datObj['fixedLocation'] = <%=currentEvent.isFixedLocation()%>;
        datObj['colors'] = <%=colors%>;
        datObj['timeVariantParams'] = "<%=currentEvent.getTimeVariantParamsAsString()%>";


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