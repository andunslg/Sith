<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");

    boolean res=eventHandler.deleteEvent(eventID);
    if(res){
        message="You are successfully deleted the event";
    }else{
        message="Deletion Failed";
    }

%>
<%=message%>



