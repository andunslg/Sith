<!DOCTYPE html>
<html lang="">
<% String state=request.getParameter("state");
    boolean loginFailed=false;
    if(state!=null){
        session.setAttribute("isLogged",false);
        if(state.equalsIgnoreCase("loginFailed")){
            loginFailed=true;

        }
    }
%>
<head>
	<meta charset="utf-8">
	<title>SITH Dashboard</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="robots" content="" />
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="css/style.css" media="all" />
	<!--[if IE]><link rel="stylesheet" href="css/ie.css" media="all" /><![endif]-->
</head>
<body class="login">
	<section>
		<h1><strong>SITH</strong> Dashboard</h1>
        <%if(loginFailed){ %>
        <p style="color: red">Incorrect username or password!</p>
        <%} %>
		<form method="POST" action="perceptions.jsp">
			<input  name="user" type="text" value="Username" />
			<input name="password" value="Password" type="password" />
			<input type="submit" class="blue" value="Login" style="color: floralwhite"/>
		</form>
        <p><a href="signup.jsp">Sign Up</a></p>
		<p><a href="#">Forgot your password?</a></p>
	</section>
</body>
</html>