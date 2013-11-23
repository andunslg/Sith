<%--
  Created by IntelliJ IDEA.
  User: Prabhath
  Date: 8/21/13
  Time: 9:21 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<%@ page import="com.sith.user.FriendHandler" %>

<%
    String message="";
    FriendHandler friendHandler=new FriendHandler();

    String userID=request.getParameter("userID");
    String friendID=request.getParameter("friendID");
    String type=request.getParameter("type");

    boolean res=false;
    String url=null;

    if(type.equals("add")){
        res=friendHandler.addFriend(userID,friendID);
        if(res){
            message="Friend request sent to "+friendID;
        }else{
            message="Adding friend failed";
        }
        url=  "'../addFriends.jsp'" ;
    }else if(type.equals("remove")){
        res=friendHandler.removeFriend(userID,friendID);
        if(res){
            message="You are unfriend with "+friendID;
        }else{
            message="Unfriend Failed";
        }
        url=  "'../profile.jsp'" ;
    }

%>



<html>
<head>

    <script type="text/javascript" src="http://code.jquery.com/jquery-1.7.1.min.js"></script>
    <script>
        $(document).ready(function(){
            apprise('<%=message%>');
            window.location.href = <%=url%>;
        });
    </script>
</head>
<body>
</body>
</html>