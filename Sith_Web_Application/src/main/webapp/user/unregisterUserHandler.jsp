<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page import="com.sith.login.Authenticator" %>

<%
    String message="";
    UserHandler userHandler=new UserHandler();
    Authenticator authenticator=new Authenticator();

    String userName=request.getParameter("userName");

    if(userName.equals(session.getAttribute("user"))){
        if("false".equals(session.getAttribute("isLogged"))){
            message="User not logged-in";
        }else{
            boolean result=userHandler.deleteUser(userName);
            if(result){
                session.setAttribute("isLogged",false);
                session.removeAttribute("user");
                message="User profile deleted successfully";
            }else{
                message="User profile deletion failed";
            }
        }

    }
%>
<%=message%>




