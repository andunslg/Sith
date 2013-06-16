<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String commentEnabled=request.getParameter("commentEnabled");

    boolean res=eventHandler.setCommentEnabled(eventID,commentEnabled);
    if(res){
        message="Comments Enabled.";
    }else{
        message="Comments are not enabled. Please try later!";
    }

%>
<html>
<body>
<div id="msg"><%=message%>
</div>
</body>
</html>





