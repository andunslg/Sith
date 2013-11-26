<%@ page import="com.sith.event.EventHandler" %><%
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
    if("".equals(eventID)||"".equals(eventName)||"".equals(location) || "".equals(perceptionSchema)){
        message="Please fill the required fields with suitable values.";
    }else{
        String res=eventHandler.addEvent(eventID,eventName,eventAdmin,startDate,startTime,endDate,endTime,location,latLng, description,perceptionSchema,commentEnabled,colors,timeVariantParams,fixedLocation);
        if("success".equals(res)){
           message="The Event is successfully added.";
        }else if("alreadyRegistered".equals(res)){
           message="Event ID is not available!";
        }
    }
%><%=message%>