<%@ page import="com.sith.login.Authenticator" %>
<%--
  Created by IntelliJ IDEA.
  User: Prabhath
  Date: 6/6/13
  Time: 5:26 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user=request.getParameter("user");
    String password=request.getParameter("password");
    String password2=request.getParameter("password2");

    Authenticator authenticator=new Authenticator();
    if(password2==null && user!=null){
        if(authenticator.authenticateUser(user,password)){
            session.setAttribute("user",user);
            if(session.getAttribute("isLogged")!=null)  {
                session.setAttribute("isLogged",true);
            }
            response.sendRedirect("perceptions.jsp");
        }else{
            response.sendRedirect("index.jsp?state=loginFailed");
        }
    }else if(password2!=null){
        if(password.equals(password2)){
            if(authenticator.addUser(user,password)){
                session.setAttribute("user",user);
                if(session.getAttribute("isLogged")!=null)  {
                    session.setAttribute("isLogged",true);
                }
                response.sendRedirect("perceptions.jsp");
            }
        }else{
            response.sendRedirect("signup.jsp?state=pdif");
        }
    }

%>