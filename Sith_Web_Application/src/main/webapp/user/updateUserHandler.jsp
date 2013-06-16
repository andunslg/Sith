<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page import="com.sith.login.Authenticator" %>

<%
    String message="";
    UserHandler userHandler=new UserHandler();
    Authenticator  authenticator=new Authenticator();

    String oldUserName=request.getParameter("oldUserName");
    String newUserName=request.getParameter("newUserName");
    String oldPassword=request.getParameter("oldPassword");
    String newPassword=request.getParameter("newPassword");
    String newPasswordConfirm=request.getParameter("newPasswordConfirm");

    if(oldUserName.equals( session.getAttribute("user"))){
        if("false".equals(session.getAttribute("isLogged"))){
            message="User not logged-in";
        }
        else{
            if(authenticator.authenticateUser(oldUserName,oldPassword)){
                if(newPassword.equals(newPasswordConfirm)){
                    boolean result=userHandler.updateUser(oldUserName,newUserName,newPasswordConfirm);
                    if(result){
                        message="User profile updated successfully";
                    }
                    else{
                        message="User profile updated failed";
                    }
                }
                else{
                    message="Password mismatch. Try again!";
                }
            }
            else{
                message="Old username or password is incorrect. Try again!";
            }
        }

    }
%>
<%=message%>




