<%@ page import="com.sith.SithAPI" %>
<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.event.Participant" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="">

<%
    SithAPI sithAPI=SithAPI.getInstance();

    if(session.getAttribute("isLogged")!=null){
        if(!(Boolean)session.getAttribute("isLogged")){
            response.sendRedirect("index.jsp");
        }
    }

    ArrayList<String> perceptionList=sithAPI.getMasterPerceptions();
    EventHandler eventHandler=new EventHandler();
    Participant participant=eventHandler.getParticipant(session.getAttribute("user").toString());
%>

<head>
    <meta charset="utf-8">
    <title>SITH Dashboard</title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <link rel="stylesheet" href="css/bootstrap-responsive.css" media="all"/>
    <link rel="stylesheet" href="css/button_style.css" media="all"/>
    <link rel="stylesheet" href="css/jquery-ui.css" media="all"/>

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


    <link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css" />
    <link rel="stylesheet" href="css/jquery-ui-timepicker-addon.css" />
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="js/jquery-ui-timepicker-addon.js"></script>

    <link rel="stylesheet" href="/resources/demos/style.css" />
    <script>
        $(function() {
            $( "#datepicker" ).datepicker();
        });
    </script>

</head>
<body>

<div class="testing">
    <header class="main">
        <h1><strong>Sith </strong>Dashboard</h1>
        <input type="text" value="search"/>
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40"/> Welcome
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
            <span class="button"><a href="home.jsp">Home</a></span>
            <span class="button"><a href="http://proj16.cse.mrt.ac.lk/">Help</a></span>
            <span class="button"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>

<nav>
    <ul>
        <li>
            <a href="home.jsp"><span class="icon" style="font-size: 40px">&#9780;&thinsp;</span>Events</a>
            <ul class="submenu">
                <li><a href="myEvents.jsp"></span>My Events</a></li>
                <li><a href="joinEvents.jsp"></span>Join Events</a></li>
                <li><a href="addEvents.jsp"></span>Add Events</a></li>
            </ul>
        </li>
        <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>
    </ul>
</nav>


<section class="content" style="margin-top: 10px">

    <section class="widget" height="100">
        <header>
            <span class="icon">&#128100;</span>
            <hgroup>
                <h1>Add new event</h1>

                <h2>Enter Event Details</h2>
            </hgroup>
        </header>
        <div class="content">
            <form>
                <table>
                    <tr>
                        <td>
                            <div>Event ID</div>
                        </td>
                        <td>
                            <div>
                                <input name="eventID" id="eventID" value="Unique event ID" type="text"
                                       style="width: 400px">
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
                                <input name="eventName" id="eventName" value="Event Name" type="text">
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
                                <input name="start" id="start" value="06/12/2013 00:00" type="text">
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
                                <input name="end" id="end" value="06/12/2013 01:00" type="text">
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
                                <input name="location" id="location" value="Event Location" type="text">
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
                                <input name="description" id="description" value="Description" type="text">
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
                            <div  >Perception Schema &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</div>
                        </td>
                        <td>
                            <select multiple="multiple" name="perceptionSchema" id="perceptionSchema"
                                    style="width: 400px;height: 120px">
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
                        <td>
                            <div class="m-btn-group" style="display: table-row;display: inline-table">
                                <a href="#" title=">" class="m-btn icn-only"  onclick="FirstListBox();"><i class="icon-chevron-right" ></i></a>
                                <a href="#" class="m-btn icn-only" onclick="SecondListBox();"><i class="icon-chevron-left"></i></a>
                            </div>
                        </td>
                        <td>
                            <select name="selectedPerceptionSchema"  id="selectedPerceptionSchema" multiple="multiple"
                                    style="width:350px;height: 120px">

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
                            &nbsp;
                        </td>
                    </tr>
                </table>
                <div style="display: inline-block">
                    <input id="addEvent" value="Add" type="button" class="button" style="text-align: center;width: 100px">
                </div>
            </form>
        </div>
    </section>
</section>

<script>
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
            alert(er)
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
            alert(er)
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
            alert(er)
        }
    }

    $(function() {
        $('#start').datetimepicker();
        $('#end').datetimepicker();
    });


    $("#addEvent").click(function () {
        var eventID = $('input[id=eventID]').val();
        var eventName = $('input[id=eventName]').val();
        var start = $('input[id=start]').val();
        var end = $('input[id=end]').val();
        var location = $('input[id=location]').val();
        var description = $('input[id=description]').val();

        var perceptionSchema = "";


        $("#selectedPerceptionSchema>option").each(function () {
            if(perceptionSchema!=""){
                perceptionSchema += ":"+$(this).text();
            }else{
                perceptionSchema+= $(this).text();
            }
        });

//        var selObj = document.getElementById('perceptionSchema');
//        var i;
//        var first=1;
//        for (i=0; i<selObj.options.length; i++) {
//            if (selObj.options[i].selected) {
//                if (first == 1) {
//                    perceptionSchema += selObj.options[i].value;
//                    first =0;
//                }
//                else {
//                    perceptionSchema += ':' + selObj.options[i].value;
//                }
//            }
//        }

        if(start.length!=16  ||end.length!=16){
            alert("Please select correct Start and End values")
        }
        else{

            var datObj = {};

            datObj['eventID'] = eventID;
            datObj['eventName'] = eventName;
            datObj['eventAdmin'] = '<%=participant.getUserID()%>';
            datObj['start'] = start;
            datObj['end'] = end;
            datObj['location'] = location;
            datObj['description'] = description;
            datObj['perceptionSchema'] = perceptionSchema;


            $.ajax({
                url: 'event/addEventHandler.jsp',
                data: datObj,
                type: 'POST',
                success: function (data) {
                    alert(data)
                    if ((data.indexOf("The Event is successfully added.") != -1) || (data.indexOf("Please fill the ")!= -1)) {
                        window.location.href = 'myEvents.jsp';
                    }
                },
                error: function (xhr, status, error) {
                    alert("Error adding event - " + error.message);
                }
            });
        }
    });
</script>


</body>
</html>