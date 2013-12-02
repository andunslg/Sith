<%@ page import="com.sith.user.FriendHandler" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
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
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/><fmt:message key="sith.dashboard.home.loggedAs" /> <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%}else{ %>
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
            <span class="button"><a href="home.jsp"><fmt:message key="sith.dashboard.home.home" /></a></span>
            <span class="button"><a href="http://sithplatform.cse.mrt.ac.lk/"><fmt:message key="sith.dashboard.home.help" /></a></span>
            <span class="button"><a href="index.jsp?state=loggedOut"><fmt:message key="sith.dashboard.home.logout" /></a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-sign-in fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.events" /></a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span><fmt:message key="sith.dashboard.menu.myEvents" /></a></li>
                <li><a href="joinEvents.jsp"></span><fmt:message key="sith.dashboard.menu.joinEvents" /></a></li>
                <li><a href="addEvents.jsp"></span><fmt:message key="sith.dashboard.menu.addEvents" /></a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon"><i class="fa fa-user fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.profile" /></a>
        </li>
        <li>
            <a href="newsFeed.jsp"><span class="icon"><i class="fa fa-file-text-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.newsfeed" /></a>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-globe fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.worldAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.heatMap" /></a></li>
                <li><a href="piChartAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.piChart" /></a></li>
                <li><a href="realtimeHeatMapAnalytics.jsp"></span><fmt:message key="sith.dashboard.event.menu.realTimeAnalitics" /></a></li>
            </ul>
        </li>
        <li>
            <a href="#"><span class="icon"><i class="fa fa-smile-o fa-2x" style="font-size: 30px"></i></span><fmt:message key="sith.dashboard.menu.myAnalytics" /></a>
            <ul class="submenu">
                <li><a href="heatMapSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.locationBased" /></a></li>
                <li><a href="TimeBasedSelfAnalytics.jsp"></span><fmt:message key="sith.dashboard.menu.timeBased" /></a></li>
            </ul>
        </li>
    </ul>
</nav>
<section class="content" style="margin-top: 10px">
    <section class="widget" style="min-height: 400px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.myProfile.topic" /></h1>

                <h2><fmt:message key="sith.dashboard.myProfile.description" /></h2>
            </hgroup>
        </header>
        <div class="content">
            <table>
                <tr>
                    <td>
                        <div><fmt:message key="sith.dashboard.myProfile.userName" /></div>
                    </td>
                    <td>
                        <div>
                            <p id="userName"><%if(session.getAttribute("user")!=null){%><%=session.getAttribute("user").toString()%><%}else{%>Guest<%}%></p>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div><fmt:message key="sith.dashboard.myProfile.oldPassWord" /></div>
                    </td>
                    <td>
                        <div>
                            <input id="oldPassword" type="password">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div><fmt:message key="sith.dashboard.myProfile.newPassWord" /></div>
                    </td>
                    <td>
                        <div>
                            <input id="newPassword" type="password">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div><fmt:message key="sith.dashboard.myProfile.confirmNewPassWord" /> &nbsp;&nbsp;&nbsp;</div>
                    </td>
                    <td>
                        <div>
                            <input id="newPasswordConfirm" type="password">
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>
                            <input id="update" type="button" value="<fmt:message key="sith.dashboard.myProfile.update" />" class="button" style="text-align: center;width: 140px">
                        </div>
                    </td>

                    <td>
                        <div>
                            <input id="unregister" type="button" value="<fmt:message key="sith.dashboard.myProfile.unRegister" />" class="button" style="text-align: center;width: 140px">
                        </div>
                    </td>
                </tr>
            </table>

        </div>
    </section>
    <section class="widget" style="min-height: 0px">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1><fmt:message key="sith.dashboard.myProfile.friends" /></h1>
            </hgroup>
            <div class="buttons"><span class="button blue" style="float: right;"><a href="addFriends.jsp"><fmt:message key="sith.dashboard.myProfile.addFriend" /></a></span></div>
        </header>
        <div class="content">
                <%
                    FriendHandler friendHandler=new FriendHandler();
                    List<String> friends=null;
                    String userID=session.getAttribute("user").toString();
                    if(userID!=null){
                        friends=friendHandler.getAllFriends(userID);
                    }
                    if(friends!=null){
                        if(!friends.isEmpty()){ %>
                            <table id="myTable" border="0" width="100">
                            <thead>
                            <tr>
                            <th class="avatar">Name</th>
                            <th>Edit</th>
                            </tr>
                            </thead>
                            <tbody>
                        <% for(String s:friends){%>
                        <tr>
                            <td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" /> <%=s%></td>
                            <td><span class="button"><a href="/user/friendHandler.jsp?type=remove&userID=<%=userID%>&friendID=<%=s%>"><fmt:message key="sith.dashboard.myProfile.unFriend" /></a></span></td>
                        </tr>
                        <%
                            }
                        }else{ %>
                            <p style="text-align: center;">You don't have added any friends</p>
                        <%}
                    }
                %>
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
<script src="js/flot.js"></script>
<script src="js/flot.resize.js"></script>
<script src="js/flot-graphs.js"></script>
<script src="js/flot-time.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.tablesorter.min.js"></script>
<script src="js/apprise-1.5.min.js"></script>

<script type="text/javascript">
    $("#update").click(function () {
        var username = $("#userName").text();
        var oldPassword = $('input[id=oldPassword]').val();
        var newPassword = $('input[id=newPassword]').val();
        var newPasswordConfirm = $('input[id=newPasswordConfirm]').val();
        if(oldPassword.length==0 ||newPassword.length==0||newPasswordConfirm.length==0){
//            alert("Please type a password")
            apprise("Please type a password");
        }
        else{
            var datObj = {};
            datObj['oldUserName'] = username;
            datObj['newUserName'] = username;
            datObj['oldPassword'] = oldPassword;
            datObj['newPassword'] = newPassword;
            datObj['newPasswordConfirm'] = newPasswordConfirm;
            $.ajax({
                url: 'user/updateUserHandler.jsp',
                data: datObj,
                type: 'POST',
                success: function (data) {
                    apprise(data)
                    if (data.indexOf("User profile updated successfully") != -1 ) {
                        window.location.href = 'home.jsp';
                    }
                    else if(data.indexOf("User not logged-in")!=-1){
                        window.location.href = 'index.jsp';
                    }
                },
                error: function (xhr, status, error) {
                    apprise("Error updating user - " + error.message);
                }
            });
        }
    });

    $("#unregister").click(function () {
//        var conf = confirm("Are you sure want to unregister from Sith Platform ?");
        apprise('Are you sure want to unregister from Sith Platform ?',{'verify':true},function(r){
            if(r){
                var username = $('#userName').val();

                var datObj = {};
                datObj['userName'] = username;

                $.ajax({
                    url: 'user/unregisterUserHandler.jsp',
                    data: datObj,
                    type: 'POST',
                    success: function (data) {
                        apprise(data)
                        if (data.indexOf("User profile deleted successfully") != -1 ) {
                            window.location.href = 'index.jsp?state=loggedOut';
                        }
                        else if(data.indexOf("User not logged-in")!=-1){
                            window.location.href = 'index.jsp?state=loggedOut';
                        }
                    },
                    error: function (xhr, status, error) {
                        apprise("Error updating user - " + error.message);
                    }
                });
            }
        });
    });
</script>
</body>
</html>