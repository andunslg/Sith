<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String userID=request.getParameter("userID");
    String text=request.getParameter("text");
    String perceptionValue=request.getParameter("perceptionValue");
    boolean res=eventHandler.addComment(eventID,userID,perceptionValue,text);
    if(res){
        message="The comment is successfully added.";
    }else{
        message="The comment is not added.";
    }


%>
<html>
<body>
<div id="msg"><%=message%>
</div>
</body>
</html>



