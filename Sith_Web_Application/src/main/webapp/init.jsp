<%@ page import="com.sith.login.Authenticator" %>
<%@ page import="com.sith.user.UserHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String user=request.getParameter("user");
    String password=request.getParameter("password");
    String password2=request.getParameter("password2");

    Authenticator authenticator=new Authenticator();
    UserHandler userHandler=new UserHandler();
    if(user==null||password==null||user.equals("")||password.equals("")){
        if(password2==null){
            response.sendRedirect("index.jsp?state=loginFailed");
        }
        else{
            response.sendRedirect("signup.jsp");
        }

    } else {
        if(password2==null){
            if(authenticator.authenticateUser(user,password)){
                session.setAttribute("user",user);
                if(session.getAttribute("isLogged")!=null){
                    session.setAttribute("isLogged",true);
                }
                response.sendRedirect("home.jsp");
            }else{
                response.sendRedirect("index.jsp?state=loginFailed");
            }
        }else if(password2!=null){
            if(password.equals(password2)){
                if(userHandler.addUser(user,password)){
                    session.setAttribute("user",user);
                    if(session.getAttribute("isLogged")!=null){
                        session.setAttribute("isLogged",true);
                    }
                    response.sendRedirect("home.jsp");
                }else{
                    response.sendRedirect("signup.jsp?state=duplicateUser");
                }
            }else{
                response.sendRedirect("signup.jsp?state=pdif");
            }
        }
    }

%>