<!DOCTYPE html>
<html lang="">
<head>
    <meta charset="utf-8">
    <title>Sith</title>
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="robots" content="" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="stylesheet" href="css/style.css" media="all" />
    <!--[if IE]><link rel="stylesheet" href="css/ie.css" media="all" /><![endif]-->
</head>
<body>
<div class="testing">
    <header class="main">
        <h1><strong>Sith</strong></h1>
        <input type="text" value="search" />
    </header>
    <section class="user">
        <div class="profile-img">
            <p><img src="images/moods-emotions-faces-many-variety-feelin.png" alt="" height="40" width="40" />Logged in as <% if(session.getAttribute("user")!=null){%> <%=session.getAttribute("user").toString()%> <%} else{ %>Guest <%}%></p>
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
            <span class="button blue"><a href="index.jsp?state=loggedOut">Logout</a></span>
        </div>
    </section>
</div>
<nav>
    <ul>
		<li>
            <a href="perceptions.jsp"><span class="icon" style="font-size: 40px">&#9787;&thinsp;</span>Perceptions</a>
        </li>
         <li>
            <a href="dashboard.jsp"><span class="icon">&#128711;</span>Analytics</a>
        </li>
         <li class="section">
            <a href="questions.jsp"><span class="icon">&#59160;</span>Questions</a>
        </li>
         <li>
            <a href="profile.jsp"><span class="icon">&#128101;</span>Profile</a>
        </li>     
	</ul>
</nav>
<section class="content">

    <form method="POST" action="perceptions.jsp">
        <input  name="user" type="text" value="Email" />
        <input name="password" value="Password" type="password" />
    </form>

    <section class="widget">
        <header>
            <span class="icon">&#59168;</span>
            <hgroup>
                <h1>Comments</h1>
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
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum..
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>How to design for retina display</strong><br />
                    <a href="#">John Doe says:</a> Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <div class="tl-post comments">
                <span class="icon">&#59168;</span>
                <p>
                    <strong>The best designs of 2012</strong><br />
                    <a href="#">John Doe says:</a> Lorem ipsum dolor sit amet, consecteteur adipiscing elit sed diam nonummy.
                    <span class="reply"><input type="text" value="Respond to comment..."/></span>
                </p>
            </div>
            <span class="show-more"><a	 href="#">More</a></span>
        </div>
    </section>
</section>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
<script src="js/jquery.wysiwyg.js"></script>
<script src="js/custom.js"></script>
<script src="js/cycle.js"></script>
<script src="js/jquery.checkbox.min.js"></script>
<!--<script src="js/flot.js"></script>
<script src="js/flot.resize.js"></script>
<script src="js/flot-graphs.js"></script>
<script src="js/flot-time.js"></script>
<script src="js/cycle.js"></script>-->
<script src="js/jquery.tablesorter.min.js"></script>
</body>
</html>