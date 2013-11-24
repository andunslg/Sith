<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="com.sith.SithAPI" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=new SithAPI();
    EventHandler eventHandler=new EventHandler();
    Event currentEvent=null;

    if(request.getParameter("eventID")!=null){
        currentEvent=eventHandler.getEvent(request.getParameter("eventID").toString());
        session.setAttribute("eventID",currentEvent.getEventID());
    }else{
        currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    }
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    String currentPerceptionOfEvent = currentEvent.getEventID()+"_currentPerception";
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    String location=currentEvent.getLatLng().toString();
    if(!currentEvent.isFixedLocation()){
        //TODO Have to find a way to predicat the client location
    }

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
    <link rel="stylesheet" href="../css/bootstrap-responsive.css" media="all"/>
    <link rel="stylesheet" type="text/css" href="../css/carousel.css" media="screen" alt="">
    <link rel="stylesheet" type="text/css" href="../css/tooltipster.css"/>
    <link rel="stylesheet" type="text/css" href="../css/apprise.min.css"/>
    <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
    <script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.carousel.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mousewheel.js"></script>
    <script src="../js/jquery-ui.js"></script>
    <script type="text/javascript" src="../js/jquery.tooltipster.min.js"></script>
    <script type="text/javascript" src="../js/apprise-1.5.min.js"></script>
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
    <script type="text/javascript">

        function postToAPI(eventID, userID, perceptionValue) {
            $.ajax({
                url: '<%=SithAPI.PUBLISH_PERCEPTION%>',
                data: 'eventID=' + eventID + '&userID=' + userID + '&perceptionValue=' + perceptionValue+'&lat='+'<%=currentEvent.getLatLng().getString("lat")%>'+'&lng='+'<%=currentEvent.getLatLng().getString("lng")%>'+'&location='+'<%=currentEvent.getLocation()%>',
                type: 'POST',
                success: function (data) {
                    console.log('Success: ')
                },
                error: function (xhr, status, error) {
                    console.log('Error: ' + error.message);
                }
            });
        }

        $(document).ready(function () {
            $('.thumbnail').tooltipster();
        });
    </script>
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><i class="fa fa-globe fa-2x" style="padding-right: 8px;"></i><strong><fmt:message key="sith.dashboard.sith" /></strong> <fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="../images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> <fmt:message key="sith.dashboard.home.loggedAs" /><% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
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
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://sithplatform.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
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

        <span><fmt:message key="sith.dashboard.event.CurrentEventIs" /> <strong><%=currentEvent.getEventName()%></strong>, <fmt:message key="sith.dashboard.event.clickToChange" /><a href="../myEvents.jsp"><fmt:message key="sith.dashboard.myEvents.Change" /></a></span>
        <span  id="current_perception"  style="margin: auto;float: right;display: none;"><fmt:message key="sith.dashboard.event.CurrentPerceptionIs" /> <strong></strong></span>

    </div>
</section>


<section class="content" height="250">
    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.event.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.event.CurrentPerceptionIs" /></h2>
            </hgroup>
        </header>
        <div class="content">
        <br>
        <%
            if(currentDate.compareTo(eventEndDate)<0){

        %>
        <h4 id="h42" align="center"><fmt:message key="sith.dashboard.event.selectPerception" /></h4>

        <div id="wrapper2" style="width:100%; text-align:center;visibility:hidden">
            <img id="selected_image2" src="../images/perceptions/default.png" alt="Smiley face" align="center">
        </div>
        <div align="center">
            <table border="0" style="text-align: center" align="center">
                <tr >
                    <%
                        String perceptionArr[]=currentEvent.getPerceptionSchema().split(":");
                        HashMap<String,Integer> perceptionMap=sithAPI.getMasterPerceptionsMap();

                        int j;
                        boolean flag = true;   // set flag to true to begin first pass
                        String temp;   //holding variable

                        while ( flag )
                        {
                            flag= false;    //set flag to false awaiting a possible swap
                            for( j=0;  j < perceptionArr.length -1;  j++ )
                            {
                                if ( perceptionMap.get(perceptionArr[ j ]) > perceptionMap.get(perceptionArr[ j+1 ]))   // change to > for ascending sort
                                {
                                    temp = perceptionArr[ j ];                //swap elements
                                    perceptionArr[ j ] = perceptionArr[ j+1 ];
                                    perceptionArr[ j+1 ] = temp;
                                    flag = true;              //shows a swap occurred
                                }
                            }
                        }
                        int count = 1000/perceptionArr.length;

                        for(int i=0;i<perceptionArr.length;i++){
                            String perception=perceptionArr[i];
                            String lowerPerception=perception.toLowerCase();
                    %>

                    <td width = "<%=count%>px"class="test"  id="<%=lowerPerception%>">
                        <img class="thumbnail" style="width: 80px;height: 80px" src="<%="../images/perceptions/"+lowerPerception+".png"%>"
                             title="<%=perception%>">
                    </td>
                    <%
                        }
                    %>

                </tr>
            </table>
        </div>
        <%
        }
        else{
        %>
        <div>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <fmt:message key="sith.dashboard.event.finished" /> <a href="selfAnalytics.jsp"><fmt:message key="sith.dashboard.event.clickToChange" /> &nbsp; &nbsp; &nbsp; &nbsp; </a> <fmt:message key="sith.dashboard.event.view" />
        </div>
        <%
            }
        %>
            </div>
    </section>
</section>
<script>
var clickTime = 0;
function getWindowWidth(){
    var w=window.innerWidth;
    return w;
}
function getCurrentTime(){
    var currentTime = new Date();
    var seconds = currentTime.getSeconds();
    var minuites = currentTime.getMinutes();
    var hours= currentTime.getHours();
    var time = seconds+(minuites*60)+(hours*3600);

    return time;
}

$("#awesome").click(function () {
    $("#awesome").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){

        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.awesome" />";
        edit_save.src = "../images/perceptions/awesome.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Awesome");
        noOfClicks=1;
        clickTime=getCurrentTime();

    }else{
        apprise("Too Quick");
    }
    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","awesome");
    $('#current_perception strong').html('Awesome');
    $('#current_perception').show();
});

$("#wonderful").click(function () {
    $("#wonderful").effect("shake");
    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.wonderful" />";
        edit_save.src = "../images/perceptions/wonderful.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Wonderful");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }
    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","wonderful");
    $('#current_perception strong').html('Wonderful');
    $('#current_perception').show();
});

$("#excited").click(function () {
    $("#excited").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.excited" />";
        edit_save.src = "../images/perceptions/excited.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Excited");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","excited");
    $('#current_perception strong').html('Excited');
    $('#current_perception').show();
});

$("#happy").click(function () {
    $("#happy").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.happy" />";
        edit_save.src = "../images/perceptions/happy.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>','<%=session.getAttribute("user").toString()%>', "Happy");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","happy");
    $('#current_perception strong').html('Happy');
    $('#current_perception').show();
});

$("#interested").click(function () {
    $("#interested").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.interested" />";
        edit_save.src = "../images/perceptions/interested.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Interested");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","interested");
    $('#current_perception strong').html('Interested');
    $('#current_perception').show();
});

$("#neutral").click(function () {
    $("#neutral").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.neutral" />";
        edit_save.src = "../images/perceptions/neutral.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Neutral");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","neutral");
    $('#current_perception strong').html('Neutral');
    $('#current_perception').show();
});

$("#bored").click(function () {
    $("#bored").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){

        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.neutral" />";
        edit_save.src = "../images/perceptions/bored.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Bored");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","bored");
    $('#current_perception strong').html('Bored');
    $('#current_perception').show();
});

$("#sleepy").click(function () {
    $("#sleepy").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.sleepy" />";
        edit_save.src = "../images/perceptions/sleepy.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>','<%=session.getAttribute("user").toString()%>', "Sleepy");
        sessionStorage.setItem("<%=currentPerceptionOfEvent%>","sleepy");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    $('#current_perception strong').html('Sleepy');
    $('#current_perception').show();
});

$("#sad").click(function () {
    $("#sad").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.sad" />";
        edit_save.src = "../images/perceptions/sad.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Sad");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","sad");
    $('#current_perception strong').html('Sad');
    $('#current_perception').show();
});
$("#angry").click(function () {
    $("#angry").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.angry" />";
        edit_save.src = "../images/perceptions/angry.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>','<%=session.getAttribute("user").toString()%>', "Angry");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }

    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","angry");
    $('#current_perception strong').html('Angry');
    $('#current_perception').show();
});
$("#horrible").click(function () {
    $("#horrible").effect("shake");

    var clicked=false;
    if(clickTime==0){
        clickTime = getCurrentTime();
        clicked=true;
    }
    var timeVariance = Math.abs(getCurrentTime()-clickTime);

    if(timeVariance >15 || clicked==true){
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> <fmt:message key="sith.dashboard.perceptionSchema.horrible" />";
        edit_save.src = "../images/perceptions/horrible.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI('<%=currentEvent.getEventID()%>', '<%=session.getAttribute("user").toString()%>', "Horrible");
        noOfClicks=noOfClicks+1;
        clickTime=getCurrentTime();
    }else{
        apprise("Too Quick");
    }
    sessionStorage.setItem("<%=currentPerceptionOfEvent%>","horrible");
    $('#current_perception strong').html('Horrible');
    $('#current_perception').show();
});
window.onload=persistCurrentPerception;
function persistCurrentPerception(){
    if(sessionStorage.getItem("<%=currentPerceptionOfEvent%>")!= null ){
        var currentPerception = sessionStorage.getItem("<%=currentPerceptionOfEvent%>");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "<fmt:message key="sith.dashboard.event.iFeel" /> "+currentPerception;
        edit_save.src = "../images/perceptions/"+currentPerception+".png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        $('#current_perception strong').html(currentPerception);
        $('#current_perception').show();
//            $("#selected_image2").attr('src','http://192.248.8.246:8080/images/perceptions/awesome.png');
    }
}


</script>

</body>
</html>