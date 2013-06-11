<%@ page import="com.sith.event.EventHandler" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();

    String eventID=request.getParameter("eventID");
    String userID=request.getParameter("userID");


    boolean res=eventHandler.removeUserFromEvent(userID,eventID);
    if(res){
        message="You are unregistered from event";
    }else{
        message="Unregistration Failed";
    }



%>
<html>
<head>

    <script type="text/javascript" src="../js/jquery-1.7.1.min.js"></script>
    <script>
        $(document).ready(function(){
            alert('<%=message%>');
            window.location.href = '../myEvents.jsp';
        });
    </script>
</head>
<body>
</body>
</html>



