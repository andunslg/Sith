<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String userID=request.getParameter("userID");


    boolean res=eventHandler.addUserToEvent(userID,eventID);
    if(res){
        message="You are successfully registered to event";
    }else{
        message="Registration Failed";
    }



%>
<html>
<body>
<div id="msg"><%=message%>
</div>
</body>
</html>



