<!DOCTYPE html>
<html lang="">
<% String state=request.getParameter("state");
    boolean isReturn=false;
    if(state!=null && state.equalsIgnoreCase("pdif")){
        isReturn=true;
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
        <%if(isReturn){ %>
        <p style="color: red">Passwords do not match.</p>
        <%} %>
		<form method="POST" action="init.jsp">
			<input name="user" placeholder="username" type="text"  />
			<input name="password" placeholder="password" type="password" />
            <input name="password2" placeholder="retype password" type="password" />
			<input type="submit" class="blue"  value="Sign Up" style="color: floralwhite"/>
		</form>
	</section>
</body>
</html>