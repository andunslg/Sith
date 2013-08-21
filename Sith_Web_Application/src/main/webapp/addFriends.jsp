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
        <h1><strong>Sith</strong></h1>
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
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>How World Feels</a>
            <ul class="submenu">
                <li><a href="heatMapAnalytics.jsp"></span>Heat Map</a></li>
                <li><a href="piChartAnalytics.jsp"></span>Pi Chart</a></li>
            </ul>
        </li>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>How I Feel</a>
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
                <h1>Friends</h1>
            </hgroup>
            <div class="buttons"><span class="button blue" style="float: right;"><a href="profile.jsp">Edit friends</a></span></div>
        </header>
        <div class="content">
            <table>
                <tr>
                    <td>
                        <div>Name:</div>
                    </td>
                    <td>
                        <div>
                            <input id="username"  value="Enter name here"  >
                        </div>
                    </td>
                    <td>
                        <div>
                            <input id="search" type="button" value="Search" class="button" style="text-align: center;width: 100px">
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
                <tr>
                    <td class="avatar"><img src="images/uiface1.png" alt="" height="40" width="40" /> John Doe</td>
                    <td><span class="button"><a href="">Add</a></span></td>
                </tr>
                <tr>
                    <td class="avatar"><img src="images/uiface2.png" alt="" height="40" width="40" /> John Doe</td>
                    <td><span class="button"><a href="">Add</a></span></td>
                </tr>
                <tr>
                    <td class="avatar"><img src="images/uiface3.png" alt="" height="40" width="40" /> John Doe</td>
                    <td><span class="button"><a href="">Add</a></span></td>
                </tr>
                <tr>
                    <td class="avatar"><img src="images/uiface4.png" alt="" height="40" width="40" /> John Doe</td>
                    <td><span class="button"><a href="">Add</a></span></td>
                </tr>
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
        var username = $('input[id=username]').val();
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
                var username = $('input[id=username]').val();

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