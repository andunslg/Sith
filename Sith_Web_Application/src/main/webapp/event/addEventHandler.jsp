<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String eventName=request.getParameter("eventName");
    String eventAdmin=request.getParameter("eventAdmin");
    String startTime=request.getParameter("startTime");
    String endTime=request.getParameter("endTime");
    String date=request.getParameter("date");
    String location=request.getParameter("location");
    String description=request.getParameter("description");
    String perceptionSchema=request.getParameter("perceptionSchema");

    if("Unique event ID".equals(eventID)||"Event Name".equals(eventName)||"hh".equals(startTime)||"hh".equals(endTime)||"dd-mm-yyyy".equals(date)||"Event Location".equals(location)){
        message="Please fill the required filed with suitable values.";
    }else{

        if(!eventHandler.isEventAvailable(eventID)){
            message="Event ID is already taken use another one.";
        }else{
            boolean res=eventHandler.addEvent(eventID,eventName,eventAdmin,startTime,endTime,date,location,description,perceptionSchema);
            if(res){
                message="The Event is successfully added.";
            }else{
                message="The Event is not added. Please try later!";
            }
        }
    }

%>
<html>
<body>
<div id="msg"><%=message%>
</div>
</body>
</html>



