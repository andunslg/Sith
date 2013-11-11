<%@ page import="com.sith.user.FriendHandler" %>
<%@ page import="java.util.List" %>
<%@ page import="com.sith.SithAPI" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />
<!DOCTYPE html>
<html lang="">
<% if(session.getAttribute("isLogged")!=null){
    if(!(Boolean)session.getAttribute("isLogged")){
        response.sendRedirect("index.jsp");
    }
}
%>
<head>
    <meta charset="utf-8">
    <title>Sith Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/apprise.min.css" type="text/css" />
    <!--[if IE]>
    <link rel="stylesheet" href="css/ie.css" media="all"/><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong><fmt:message key="sith.dashboard.sith" /> </strong><fmt:message key="sith.dashboard.dashboard" /></h1>
        <%--<input type="text" value="search"/>--%>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/>Logged in
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
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button blue"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span>My Event</a></li>
                <li><a href="joinEvents.jsp"></span>Join Events</a></li>
                <li><a href="addEvents.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#128711;&thinsp;</span>How World Feels</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Heat Map</a></li>
                <li><a href="piChartAnalytics.jsp"></span>Pi Chart</a></li>
            </ul>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>How I Feel</a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span>Location Based</a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span>Time Based</a></li>
            </ul>
        </li>
    </ul>
</nav>
<section class="content" style="margin-top: 10px">
    <section class="widget">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Find friends</h1>
            </hgroup>
        </header>
        <div class="content">
            <table>

                <tr>
                    <td>
                        <div>Name:</div>
                    </td>
                    <td>
                        <div>
                            <input id="query"  value="Enter name here"  >
                        </div>
                    </td>
                    <td>
                        <div>
                            <span class="button" id="search">Search</span>
                        </div>
                    </td>
                </tr>

            </table>
            <br/>
            <table id="myTable" border="0" width="100">
                <thead>
                <tr>
                    <th class="avatar">Name</th>
                    <th>Edit</th>
                </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </section>
</section>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="js/jquery.wysiwyg.js"></script>
<script src="js/custom.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.checkbox.min.js"></script>
<%--<script src="js/flot.js"></script>--%>
<%--<script src="js/flot.resize.js"></script>--%>
<%--<script src="js/flot-graphs.js"></script>--%>
<%--<script src="js/flot-time.js"></script>--%>
<script src="js/cycle.js"></script>
<script src="js/jquery.tablesorter.min.js"></script>
<script src="js/apprise-1.5.min.js"></script>

<script type="text/javascript">
    $(document).ready(function(){
        $("#search").click(function () {
            var username = '<%=session.getAttribute("user").toString()%>';
            var query = $('input[id=query]').val();
            var friends;
            $.ajax({
                url: '<%=SithAPI.GET_FRIENDS_SUGGESTIONS%>?userID='+username+'&query='+query,
                type: 'GET',
                success: function (data) {
                    if(typeof data=='string' || data instanceof String){
                        friends = JSON.parse(data);
                    }else{
                        friends = data;
                    }
                    var s='';
                    for(var i = 0; i < friends.length; i++){
                        if(friends[i].type=="pendingRequest"){
                            s+='<tr><td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" />'+ friends[i].userName+'</td><td><span class="button" id="confirm">Confirm</span></td></tr>';
                        }else if(friends[i].type=="friend"){
                        s+='<tr><td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" />'+ friends[i].userName+'</td><td class="avatar"><img src="images/tick_green_big.gif" alt="" style="margin: 6px 5px 0 0"/>Friend</td></tr>';
                        }else if(friends[i].type == "requestSent"){
                            s+='<tr><td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" />'+ friends[i].userName+'</td><td><span>Request Sent</span></td></tr>';
                        }else if(!friends[i].type){
                            s+='<tr><td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" />'+ friends[i].userName+'</td><td><span class="button" id="addFriend">Add</span></td></tr>';
                        }
                        }
                    $('#myTable tbody').html(s);
                },
                error: function (xhr, status, error) {
                    apprise("Error : " + error.message);
                }
            });
        });

        $("#addFriend").live('click',function () {
            var sender = '<%=session.getAttribute("user").toString()%>';
            var receiver =$(this).closest("tr").find(".avatar").text();
            var selectedButton = $(this);
            console.log(receiver);
            $.ajax({
            url: '<%=SithAPI.SEND_FRIEND_REQUEST%>?sender='+sender+'&receiver='+receiver,
            type: 'GET',
            success: function (data) {
                selectedButton.removeClass("button").html("Request Sent")
            },
            error: function (xhr, status, error) {
            apprise("Error : " + error.message);
            }
            });
        });
    })
</script>
</body>
</html>