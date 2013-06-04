<!DOCTYPE html>
<html lang="">
<head>
	<meta charset="utf-8">
	<title>Retina Dashboard</title>
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta name="robots" content="" />
	<meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
	<link rel="stylesheet" href="css/style.css" media="all" />
	<script  type = "text/javascript" src ="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
	<script type = "text/javascript" src = "js/jquery.wysiwyg.js"></script>
	<script type = "text/javascript" src = "js/custom.js"></script>
	<script type = "text/javascript" src = "js/cycle.js"></script>
	<script type = "text/javascript" src = "js/jquery.checkbox.min.js"></script>
	<script type = "text/javascript" src = "js/jquery.tablesorter.min.js"></script>
	<script type = "text/javascript" src = "js/highCharts/highcharts.js"></script>
	<script type = "text/javascript" src = "js/highCharts/modules/exporting.js"></script>
    <script type = "text/javascript" src = "js/charts/realTimePercepGraph2.js"></script>
    <script type = "text/javascript" src = "js/charts/perceptionCountGraphs.js"> </script>
</head>
<body>
<div class="testing">
<header class="main">
	<h1><strong>SITH</strong> Dashboard</h1>
	<input type="text" value="search" />
</header>
<section class="user">
	<div class="profile-img">
		<p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40" /> Welcome To SITH</p>
	</div>
	<div class="buttons">
		<button class="ico-font">&#9206;</button>
		<span class="button dropdown">
			<a href="#">Notifications <span class="pip">4</span></a>
			<ul class="notice">
				<li>
					<hgroup>
						<h1>You have no new Notifications</h1>
					</hgroup>
				</li>
			</ul>
		</span>
		<span class="button">Help</span>
		<span class="button blue"><a href="index.html">Logout</a></span>
	</div>
</section>
</div>
<nav>
	<ul>
		<li class="section">
            <a href="perceptions.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>Perceptions</a>
        </li>
         <li>
            <a href="dashboard.jsp"><span class="icon">&#128711;</span>Analytics</a>
        </li>
         <li>
            <a href="questions.html"><span class="icon">&#59160;</span>Questions</a>
        </li>
         <li>
            <a href="profile.html"><span class="icon">&#128101;</span>Profile</a>
        </li>     
	</ul>
</nav>
<section class="alert">
	<div class="green">	
		<p>Hi Lee, you have <a href="#">3 new pages</a> and <a href="#">16 comments</a> to approve, better get going!</p>
		<span class="close">&#10006;</span>
	</div>
</section>
<section class="content">
	<section class="widget">
		<header>
			<span class="icon">&#128200;</span>
			<hgroup>
				<h1>Website Statistics</h1>
				<h2>An insiders view</h2>
			</hgroup>
			<aside>
				<button class="left-btn">&#59229;</button><button class="right-btn">&#59230;</button>
			</aside>
		</header>
		<div class="content">
        			<div id="LiveChart" style="min-width: 400px; height: 400px; margin: 0 auto"></div>
					<p>
						Chart Type
						<select id='chartType'>
							<option value="bar">Bar Chart</option>
							<option value="pie">Pie Chart</option>
						</select>
					</p>
					<div id="CountChart" style="min-width: 400px; height: 400px;"></div>
		</div>
	</section>
	
	<div class="widget-container">
		<section class="widget small">
			<header>
				<span class="icon">&#59168;</span>
				<hgroup>
					<h1>Latest comments</h1>
					<h2>What they're saying</h2>
				</hgroup>
				<aside>
					<span>
						<a href="#">&#9881;</a>
						<ul class="settings-dd">
							<li><label>Option a</label><input type="checkbox" /></li>
							<li><label>Option b</label><input type="checkbox" checked="checked" /></li>
							<li><label>Option c</label><input type="checkbox" /></li>
						</ul>
					</span>
				</aside>
			</header>
			<div class="content no-padding timeline">
				<div class="tl-post comments">
					<span class="icon">&#59168;</span>
					<p>
						<a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
						<span class="reply"><input type="text" value="Respond to comment..."/></span>
					</p>
				</div>
				<div class="tl-post comments">
					<span class="icon">&#59168;</span>
					<p>
						<a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
						<span class="reply"><input type="text" value="Respond to comment..."/></span>
					</p>
				</div>
				<span class="show-more"><a	 href="#">More</a></span>
			</div>
		</section>
		
		<section class="widget 	small">
			<header>
				<span class="icon">&#128319;</span>
				<hgroup>
					<h1>Quick Post</h1>
					<h2>Speed things up</h2>
				</hgroup>
				<aside>
					<span>
						<a href="#">&#9881;</a>
						<ul class="settings-dd">
							<li><label>Option a</label><input type="checkbox" /></li>
							<li><label>Option b</label><input type="checkbox" checked="checked" /></li>
							<li><label>Option c</label><input type="checkbox" /></li>
						</ul>
					</span>
				</aside>
			</header>
			<div class="content">
				<div class="field-wrap">
					<input type="text" value="Title"/>
				</div>
				<div class="field-wrap">
					<textarea id="quick_post" rows="5"></textarea>
				</div>
				<button type="submit" class="green">Post</button> <button type="submit" class="">Preview</button>
			</div>
		</section>
	</div>
</section>
<script type="text/javascript">
// Feature slider for graphs
$('.cycle').cycle({
	fx: "scrollHorz",
	timeout: 0,
    slideResize: 0,
    prev:    '.left-btn', 
    next:    '.right-btn'
});
</script>
</body>
</html>