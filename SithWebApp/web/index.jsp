<!DOCTYPE html>
<html lang="">
<% String state=request.getParameter("state");
    if(state!=null){
       session.removeAttribute("user");
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
		<form method="link" action="perceptions.jsp">
			<input  name="user" type="text" value="Email" />
			<input name="password" value="Password" type="password" />
			<input type="submit" class="blue">Login</input>
		</form>
        <p><a href="signup.html">Sign Up</a></p>
		<p><a href="#">Forgot your password?</a></p>
	</section>
<script src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
// Page load delay by Curtis Henson - http://curtishenson.com/articles/quick-tip-delay-page-loading-with-jquery/
$(function(){
	$('.login button').click(function(e){ 
		// Get the url of the link 
		var toLoad = $(this).attr('href');  
 
		// Do some stuff 
		$(this).addClass("loading"); 
 
			// Stop doing stuff  
			// Wait 700ms before loading the url 
			setTimeout(function(){window.location = toLoad}, 10000);	  
 
		// Don't let the link do its natural thing 
		e.preventDefault
	});
	
	$('input').each(function() {

       var default_value = this.value;

       $(this).focus(function(){
               if(this.value == default_value) {
                       this.value = '';
               }
       });

       $(this).blur(function(){
               if(this.value == '') {
                       this.value = default_value;
               }
       });

});
});
</script>
</body>
</html>