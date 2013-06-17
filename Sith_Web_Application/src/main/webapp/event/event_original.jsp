<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<!DOCTYPE html>
<html lang="">

<%
    EventHandler eventHandler=new EventHandler();
    Event currentEvent=null;

    if(request.getParameter("eventID")!=null){
        currentEvent=eventHandler.getEvent(request.getParameter("eventID").toString());
        session.setAttribute("eventID",currentEvent.getEventID());
    }else{
        currentEvent=eventHandler.getEvent(session.getAttribute("eventID").toString());
    }
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }
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

    <script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
    <script type="text/javascript" src="../js/jquery.carousel.min.js"></script>
    <script type="text/javascript" src="../js/jquery.mousewheel.js"></script>
    <script src="../js/jquery-ui.js"></script>
    <script type="text/javascript" src="../js/jquery.tooltipster.min.js"></script>

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
                url: 'http://192.248.8.246:3000/publishEventPerception',
                data: 'eventID=' + eventID + '&userID=' + userID + '&perceptionValue=' + perceptionValue,
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
        <h1><strong>Sith </strong>Dashboard</h1>
        <%--<input type="text" value="search"/>--%>
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
            <span class="button"><a href="../home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="../index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="../home.jsp"><span class="icon" style="font-size: 40px">&#9790;&thinsp;</span>Home</a>
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


<section class="content" height="250">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>My Perceptions</h1>

                <h2>Current Perception</h2>
            </hgroup>
        </header>
        <h4 id="h42" align="center">Select your Perception</h4>

        <div id="wrapper2" style="width:100%; text-align:center;visibility:hidden">
            <img id="selected_image2" src="../images/perceptions/default.png" alt="Smiley face" align="center">
        </div>
        <div class="row-fluid" align="center">
            <%
                String perceptionArr[]=currentEvent.getPerceptionSchema().split(":");
                for(int i=0;i<perceptionArr.length;i++){
                    String perception=perceptionArr[i];
                    String lowerPerception=perception.toLowerCase();
                    if(i ==0){
            %>
            <div id="<%="toggle"+i%>" class="span2 offset1">
                <img class="thumbnail" style="width: 80px;height: 80px" src="<%="../images/perceptions/"+lowerPerception+".png"%>"
                     title="<%=perception%>">
            </div>
            <%
            }else{
            %>
            <div id="<%="toggle"+i%>" class="span2">
                <img class="thumbnail" style="width: 80px;height: 80px" src="<%="../images/perceptions/"+lowerPerception+".png"%>"
                     title="<%=perception%>">
            </div>
            <%
                    }
                }
            %>

            <%--<div id="toggle1" class="span2 offset1">--%>
            <%--<img class="thumbnail" style="width: 80px;height: 80px" src="../images/perceptions/excited.png"--%>
            <%--title="Happy">--%>
            <%--</div>--%>
            <%--<div id="toggle2" class="span2">--%>
            <%--<img class="thumbnail" src="../images/perceptions/happy.png" style="width: 80px;height: 80px"--%>
            <%--title="Interested">--%>
            <%--</div>--%>
            <%--<div id="toggle3" class="span2">--%>
            <%--<img class="thumbnail" src="../images/perceptions/satisfied.png" style="width: 80px;height: 80px"--%>
            <%--title="Satisfied">--%>
            <%--</div>--%>
            <%--<div id="toggle4" class="span2">--%>
            <%--<img class="thumbnail" src="../images/perceptions/doomed.png" style="width: 80px;height: 80px"--%>
            <%--title="Bored">--%>
            <%--</div>--%>
            <%--<div id="toggle5" class="span2">--%>
            <%--<img class="thumbnail" src="../images/perceptions/neutral.png" style="width: 80px;height: 80px"--%>
            <%--title="Sleepy">--%>
            <%--</div>--%>

        </div>
    </section>

    <%--<section class="widget">--%>
    <%--<header>--%>
    <%--<span class="icon">&#128100;</span>--%>
    <%--<hgroup>--%>
    <%--<h1>Perceptions</h1>--%>
    <%--<h2>Current Perceptions</h2>--%>
    <%--</hgroup>--%>
    <%--<aside>--%>
    <%--<span> <a href="#">&#9881;</a>--%>
    <%--<ul class="settings-dd">--%>
    <%--<li>--%>
    <%--<label>Option a</label>--%>
    <%--<input type="checkbox" />--%>
    <%--</li>--%>
    <%--<li>--%>
    <%--<label>Option b</label>--%>
    <%--<input type="checkbox" checked="checked" />--%>
    <%--</li>--%>
    <%--<li>--%>
    <%--<label>Option c</label>--%>
    <%--<input type="checkbox" />--%>
    <%--</li>--%>
    <%--</ul> </span>--%>
    <%--</aside>--%>
    <%--</header>--%>
    <%--<div class="row-fluid" align="center">--%>
    <%--<div class="span10 offset1" aligh="center">--%>
    <%--<ul id="carosal"  class="roundabout-holder" style="padding: 0px; position: relative;width: 80%;height: 40%">--%>

    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="1" class="emotions" src="images/perceptions/128_19.png" alt="Enjoying">--%>

    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="2" class="emotions" src="images/perceptions/funny.png" alt="Funny">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="3" class="emotions" src="images/perceptions/lovely.png" alt="Lovely">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="4"  class="emotions" src="images/perceptions/neutral.png" alt="Neutral">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="5" class="emotions" src="images/perceptions/satisfied.png" alt="Sad">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="6"  class="emotions" src="images/perceptions/angry.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="7"  class="emotions" src="images/perceptions/annoyed.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="8"  class="emotions" src="images/perceptions/crying.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="9"  class="emotions" src="images/perceptions/excited.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="10"  class="emotions" src="images/perceptions/rocking.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="11"  class="emotions" src="images/perceptions/very_happy.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="12"  class="emotions" src="images/perceptions/doomed.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="13"  class="emotions" src="images/perceptions/happy.png" alt="smile">--%>
    <%--</li>--%>
    <%--<li class="roundabout-moveable-item" style="position: absolute; left: 119px; top: 139px; width: 100px; height: 100px; opacity: 0.43; z-index: 109; font-size: 6.9px;">--%>
    <%--<img id="14"  class="emotions" src="images/perceptions/laughing.png" alt="smile">--%>
    <%--</li>--%>
    <%--</ul>--%>
    <%--</div>--%>
    <%--</div>--%>
    <%--<br>--%>
    <%--<br>--%>
    <%--<h4 id="h4" align="center">Select your Perception</h4>--%>
    <%--<div id="wrapper" style="width:100%; text-align:center;visibility:hidden" >--%>
    <%--<img id="selected_image" src="images/perceptions/annoyed.png" alt="Smiley face" align="center">--%>
    <%--</div>--%>
    <%--</section>--%>
</section>
<script>
    $("#toggle1").click(function () {
        $("#toggle1").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Happy";
        edit_save.src = "../images/perceptions/excited.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI(<%=currentEvent.getEventID()%>, <%=session.getAttribute("user").toString()%>, "Happy");
    });
    $("#toggle5").click(function () {
        $("#toggle5").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Sleepy";
        edit_save.src = "../images/perceptions/neutral.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI(<%=currentEvent.getEventID()%>, <%=session.getAttribute("user").toString()%>, "Sleepy");


    });
    $("#toggle2").click(function () {
        $("#toggle2").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Interested";
        edit_save.src = "../images/perceptions/happy.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI(<%=currentEvent.getEventID()%>, <%=session.getAttribute("user").toString()%>, "Interested");

    });
    $("#toggle4").click(function () {
        $("#toggle4").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Bored";
        edit_save.src = "../images/perceptions/doomed.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI(<%=currentEvent.getEventID()%>, <%=session.getAttribute("user").toString()%>, "Bored");

    });
    $("#toggle3").click(function () {
        $("#toggle3").effect("shake");
        var edit_save = document.getElementById("selected_image2");
        document.getElementById("h42").innerHTML = "You are Neutral";
        edit_save.src = "../images/perceptions/satisfied.png";
        document.getElementById('selected_image2').style.visibility = 'visible';
        postToAPI(<%=currentEvent.getEventID()%>, <%=session.getAttribute("user").toString()%>, "Neutral");

    });
    //    jQuery(document).ready(function($){
    //        $('#carosal').carousel({
    //
    //            resize:false,
    //            mouseScroll:true,
    //            mouseDrag:true,
    //            speedAdjusted:2,
    //            scaleRatio:0.4,
    //            scrollbar:true,
    //            tooltip:true,
    //            mouseWheel:true,
    //            mouseWheelReverse:true,
    //            itemClick:onItemClick});
    //    });
    //
    //    function onItemClick(event) {
    //        var perception = event.index;
    //
    //        postToAPI("123","aslgg","Interested");// Here I have hardcorded user ID
    //        showPerception(perception);
    //    }
    //    function showPerception(perception){
    //        var edit_save = document.getElementById("selected_image");
    //
    //        if(perception == "0"){
    //            document.getElementById("h4").innerHTML = "You are Enjoying";
    //            edit_save.src = "images/perceptions/128_19.png";
    //        }
    //        else if(perception == "1"){
    //            document.getElementById("h4").innerHTML = "You are Funny";
    //            edit_save.src = "images/perceptions/funny.png";
    //        }
    //        else if(perception == "2"){
    //            document.getElementById("h4").innerHTML = "You are Lovely";
    //            edit_save.src ="images/perceptions/lovely.png" ;
    //        }
    //        else if(perception == "3"){
    //            document.getElementById("h4").innerHTML = "You are Neutral";
    //            edit_save.src = "images/perceptions/neutral.png";
    //        }
    //        else if(perception == "4"){
    //            document.getElementById("h4").innerHTML = "You are Satisfied";
    //            edit_save.src = "images/perceptions/satisfied.png";
    //        }
    //        else if(perception == "5"){
    //            document.getElementById("h4").innerHTML = "You are Angry";
    //            edit_save.src = "images/perceptions/angry.png";
    //        }
    //        else if(perception == "6"){
    //            document.getElementById("h4").innerHTML = "You are Annoyed";
    //            edit_save.src = "images/perceptions/annoyed.png";
    //        }
    //        else if(perception == "7"){
    //            document.getElementById("h4").innerHTML = "You are Crying";
    //            edit_save.src = "images/perceptions/crying.png";
    //        }
    //        else if(perception == "8"){
    //            document.getElementById("h4").innerHTML = "You are Excited";
    //            edit_save.src ="images/perceptions/excited.png" ;
    //        }
    //        else if(perception == "9"){
    //            document.getElementById("h4").innerHTML = "You are Rocking";
    //            edit_save.src ="images/perceptions/rocking.png"
    //        }
    //        else if(perception == "10"){
    //            document.getElementById("h4").innerHTML = "You are Very Happy";
    //            edit_save.src ="images/perceptions/very_happy.png" ;
    //        }
    //        else if(perception == "11"){
    //            document.getElementById("h4").innerHTML = "You are Doomed";
    //            edit_save.src = "images/perceptions/doomed.png";
    //        }
    //        else if(perception == "12"){
    //            document.getElementById("h4").innerHTML = "You are Happy";
    //            edit_save.src ="images/perceptions/happy.png" ;
    //        }
    //        else if(perception == "13"){
    //            document.getElementById("h4").innerHTML = "You are Laughing";
    //            edit_save.src = "images/perceptions/laughing.png";
    //        }
    //        document.getElementById('selected_image').style.visibility='visible';
    //
    //    }
</script>

</body>
</html>