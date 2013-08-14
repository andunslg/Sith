<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String eventName=request.getParameter("eventName");
    String eventAdmin=request.getParameter("eventAdmin");
    String location=request.getParameter("location");
    String latLng = request.getParameter("latLng");
    String description=request.getParameter("description");
    String perceptionSchema=request.getParameter("perceptionSchema");
    String commentEnabled=request.getParameter("commentEnabled");
    String fixedLocation=request.getParameter("fixedLocation");
    String start=request.getParameter("start");
    String end=request.getParameter("end");
    String colors = request.getParameter("colors");
    String timeVariantParams = request.getParameter("timeVariantParams");

    String startDate=start.substring(0,10);
    String startTime=start.substring(11,16);
    String endDate=end.substring(0,10);
    String endTime=end.substring(11,16);

    if("Unique event ID".equals(eventID)||"Event Name".equals(eventName)||"Event Location".equals(location)){
        message="Please fill the required filed with suitable values.";
    }else{

        if(!eventHandler.isEventAvailable(eventID)){
            message="Event ID is already taken use another one.";
        }else{
            boolean res=eventHandler.addEvent(eventID,eventName,eventAdmin,startDate,startTime,endDate,endTime,location,latLng, description,perceptionSchema,commentEnabled,colors,timeVariantParams,fixedLocation);
            if(res){
                message="The Event is successfully added.";
            }else{
                message="The Event is not added. Please try later!";
            }
        }
    }

%>
<%=message%>




