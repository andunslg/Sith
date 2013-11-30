<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="language" value="${not empty param.lang ? param.lang :'english' }" scope="session" />
<fmt:setLocale value="${language}" />
<fmt:setBundle basename="i18n.lang" />
<script type="text/javascript">
    localStorage.clear();
</script>
<html lang="">
<%
    String state=request.getParameter("state");
    boolean loginFailed=false;
    if(state!=null){
        session.setAttribute("isLogged",false);
        if(state.equalsIgnoreCase("loginFailed")){
            loginFailed=true;
        }
    }
%>
<script language="JavaScript">
    function selectText(textField) {
        textField.focus();
        textField.select();
    }
</script>
<head>
    <meta charset="utf-8">
    <title><fmt:message key="sith.dashboard.topic" /></title>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="robots" content=""/>
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all"/>
    <!--[if IE]>
    <link rel="stylesheet" href="css/ie.css" media="all"/><![endif]-->
</head>
<body class="login">
<section>
    <h1><fmt:message key="sith.dashboard.topic" /></h1>
    <%if(loginFailed){ %>
    <p style="color: red"><fmt:message key="sith.dashboard.incorrectPasswordUserName" /></p>
    <%} %>
    <form method="POST" action="init.jsp">
        <fmt:message key="sith.dashboard.username" var="unameText" />
        <input placeholder="${unameText}" name="user" type="text"/>
        <fmt:message key="sith.dashboard.password" var="pwText" />
        <input placeholder="${pwText}" name="password" type="password"/>
        <fmt:message key="sith.dashboard.login" var="loginButtonValue" />
        <input type="submit" class="blue" value="${loginButtonValue}" style="color: floralwhite"/>
    </form>
    <p><a href="signup.jsp"><fmt:message key="sith.dashboard.signup" /></a></p>

    <%--<p><a href="#"><fmt:message key="sith.dashboard.forgotPassword" /></a></p>--%>
    <p style="color: #ffffff">-----------------------------------------------------------------------------</p>
    <p style="font-size: large;color: #ffffff"><fmt:message key="sith.dashboard.selectLanguage" /></p>
    <p style="font-size: large"><a id="englishLang" href="index.jsp?lang=english">English</a> / <a id="sinhalaLang" href="index.jsp?lang=sinhala">සිංහල</a> / <a id="tamilLang" href="index.jsp?lang=tamil">தமிழ்</a></p>
    <p style="color: #ffffff">-----------------------------------------------------------------------------</p>
</section>

</body>
</html>