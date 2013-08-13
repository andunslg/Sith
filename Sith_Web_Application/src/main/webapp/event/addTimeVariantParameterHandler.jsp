<%@ page import="com.sith.event.EventHandler" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.ArrayList" %>

<%
    String message="";
    EventHandler eventHandler=new EventHandler();
    HashMap<String,String> params=new HashMap<String,String>();

    try{
        ArrayList<String> timeVariantParams=eventHandler.getEvent(request.getParameter("eventID")).getTimeVariantParams();
        for(String param:timeVariantParams){
            params.put(param,request.getParameter(param));
        }

        boolean res=eventHandler.addTimeVariantParameter(request.getParameter("eventID"),params);

        if(res){
            message="Param added";
        }else{
            message="Param not added";
        }
    }catch(Exception e){
        message="Param not added";
    }
%>
<%=message%>




