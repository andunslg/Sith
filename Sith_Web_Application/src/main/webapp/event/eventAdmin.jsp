<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.Event" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>
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

    ArrayList<String> perceptionList=sithAPI.getMasterPerceptions();
    ArrayList<String> temp=perceptionList;
    for(int i=0;i<perceptionList.size();i++){
        if(perceptionListSelected.contains(perceptionList.get(i))){
            for(int j=0;j<temp.size();j++){
                if(perceptionList.get(i).equals(temp.get(j))){
                    temp.remove(j);
                    break;
                }
            }
        }
    }
    perceptionList=temp;
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
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
                <h1>Event Admin Panel</h1>

                <h2>Event Details</h2>
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td style="width: 160px">
                            <div>Event ID</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventID" id="eventID" value="<%=currentEvent.getEventID()%>" type="text"
                                       style="width: 400px" readonly>
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
                            <div>Event Name</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventName" id="eventName" value="<%=currentEvent.getEventName()%>" type="text">
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
                            <div>Location</div>
                        </td>
                        <td>
                            <div>
                                <input name="location" id="location" value="<%=currentEvent.getLocation()%>" type="text">
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
                            <div>Description</div>
                        </td>
                        <td>
                            <div>
                                <input name="description" id="description" value="<%=currentEvent.getDescription()%>" type="text">
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
                            <div>Perception Schema </div>
                        </td>
                        <td>
                            <select multiple="multiple" name="perceptionSchema" id="perceptionSchema"
                                    style="width: 400px;height:120px;vertical-align: middle">
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
                        </td>
                        <td style="vertical-align: middle;width: 83px">
                            <div class="m-btn-group" align="center">
                                <a  class="m-btn icn-only"  onclick="FirstListBox();"><i class="icon-chevron-right" ></i></a>
                                <a  class="m-btn icn-only" onclick="SecondListBox();"><i class="icon-chevron-left"></i></a>
                            </div>
                        </td>
                        <td>
                            <select name="selectedPerceptionSchema"  id="selectedPerceptionSchema" multiple="multiple"
                                    style="width:300px;height:120px;vertical-align: middle">
                                <%
                                    for(String perception : perceptionListSelected){
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

                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <div>Enable User Comments &nbsp;</div>
                        </td>
                        <td>
                            <div>
                                <%
                                    if("true".equals(currentEvent.getCommentEnabled())){
                                %>
                                <input name="commentEnabled" id="commentEnabled" type="checkbox" checked="true" style="width: 10%">
                                <%
                                }
                                else{
                                %>
                                <input name="commentEnabled" id="commentEnabled" type="checkbox" style="width: 10%">
                                <%
                                    }
                                %>
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
                        <td>
                            <div align="center">
                                <input id="delete" value="Delete Event" type="button" class="button" style="text-align: center;width: 100px">
                            </div>
                        </td>
                    </tr>
                </table>

            </form>
        </div>
    </section>

</section>

<script type="text/javascript">

    $(document).ready(function () {
        $( "#datepicker" ).datepicker();
        $('#start').datetimepicker();
        $('#end').datetimepicker();
    });

    function SecListBox(ListBox,text,value)
    {
        try
        {
            var option=document.createElement("OPTION");
            option.value=value;
            option.text=text;
            ListBox.options.add(option)
        }
        catch(er)
        {
            apprise(er)
        }
    }
    function FirstListBox()
    {
        try
        {
            var count=document.getElementById("perceptionSchema").options.length;
            for(i=0;i<count;i++)
            {
                if(document.getElementById("perceptionSchema").options[i].selected)
                {
                    SecListBox(document.getElementById("selectedPerceptionSchema"),document.getElementById("perceptionSchema").options[i].value,document.getElementById("perceptionSchema").options[i].value);document.getElementById("perceptionSchema").remove(i);
                    break;
                }
            }
        }
        catch(er)
        {
            apprise(er)
        }
    }
    function SecondListBox()
    {
        try
        {
            var count=document.getElementById("selectedPerceptionSchema").options.length;
            for(i=0;i<count;i++)
            {
                if(document.getElementById("selectedPerceptionSchema").options[i].selected){SecListBox(document.getElementById("perceptionSchema"),document.getElementById("selectedPerceptionSchema").options[i].value,document.getElementById("selectedPerceptionSchema").options[i].value);document.getElementById("selectedPerceptionSchema").remove(i);
                    break
                }
            }

        }
        catch(er)
        {
            apprise(er)
        }
    }

    $("#delete").click(function () {

        var datObj = {};
        datObj['eventID'] = '<%=currentEvent.getEventID()%>';

        $.ajax({
            url: './deleteEventHandler.jsp',
            data: datObj,
            type: 'POST',
            success: function (data) {
                apprise(data)
                if (data.indexOf("You are successfully deleted the event") != -1) {
                    window.location.href = '../myEvents.jsp';
                }
            },
            error: function (xhr, status, error) {
                apprise("Error deleting event - " + error.message);
            }
        });

    });

    $("#update").click(function () {
        var eventID = $('input[id=eventID]').val();
        var eventName = $('input[id=eventName]').val();
        var start = $('input[id=start]').val();
        var end = $('input[id=end]').val();
        var location = $('input[id=location]').val();
        var description = $('input[id=description]').val();

        var c=document.getElementById('commentEnabled');
        var commentEnabled = false;
        if(c.checked){
            commentEnabled=true;
        }

        var perceptionSchema = "";


        $("#selectedPerceptionSchema>option").each(function () {
            if(perceptionSchema!=""){
                perceptionSchema += ":"+$(this).text();
            }else{
                perceptionSchema+= $(this).text();
            }
        });

        if(start.length!=16  ||end.length!=16){
            apprise("Please select correct Start and End values")
        }
        else if(perceptionSchema==""){
            apprise("Please select perception schema")
        }
        else{

            var datObj = {};

            datObj['oldEventID'] ='<%=currentEvent.getEventID()%>';
            datObj['eventID'] = eventID;
            datObj['eventName'] = eventName;
            datObj['eventAdmin'] = '<%=participant.getUserID()%>';
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
                    apprise(data)
                    if (data.indexOf("The Event is successfully updated.") != -1) {
                        window.location.reload();
                    }
                },
                error: function (xhr, status, error) {
                    apprise("Error updating event - " + error.message);
                }
            });
        }
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