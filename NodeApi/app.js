
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , eventRoutes = require('./routes/event')
  , analyticRoutes = require('./routes/analytics')
  , userMgmtRoutes = require('./routes/userMgmt');
	
var app = express();
app.engine('html', require('hjs').renderFile);
app.configure(function(){
  app.set('port', process.env.PORT || 3000);
  app.set('views', __dirname + '/views');
  app.set('view engine', 'hjs');
  app.use(express.favicon());
  app.use(express.logger('dev'));
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(path.join(__dirname, 'public')));
});

app.all('/*', function(req, res, next) {
 res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "X-Requested-With");
  next();
});
app.configure('development', function(){
  app.use(express.errorHandler());
});

//routes for web pages
app.get('/',routes.index);
app.get('/webDashboard',routes.getWebDashboard);
app.get('/myPerception',routes.percep_event);
app.get('/selfAnalyticDashboard',routes.getSelfAnalyticDashBoard);
app.get('/webDashboard2',routes.getWebDashBoard2);
app.get('/vote',routes.vote);
//routing for real time analytic data
app.get('/getPeriodicAvgPerception',analyticRoutes.sendPeriodicAvgPerception);
app.get('/countPeriodicPerceptions',analyticRoutes.sendPeriodicPerceptionCount);
//routing for perception count data
app.get('/countPerceptions',analyticRoutes.sendPerceptionCount); //this will count perception for each categories

//routing for event category
app.get('/searchEventListByGps', eventRoutes.searchEventListByGps);
app.get('/searchEventListByName',eventRoutes.searchEventListByName);
app.post('/registerForEvent', eventRoutes.registerForEvent);
app.post('/publishEventPerception', eventRoutes.publishEventPerception);
//routing for user mangement
app.post('/registerAnnonymousUser',userMgmtRoutes.registerAnnonymousUser);
app.post('/authenticateUser',userMgmtRoutes.authenticateUser);
http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
}); 