
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , eventRoutes = require('./routes/event')
  , analyticRoutes = require('./routes/analytics');;
	
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

app.configure('development', function(){
  app.use(express.errorHandler());
});

//routes for web pages
app.get('/',routes.index);
app.get('/webDashboard',routes.getWebDashboard);
app.get('/myPerception',routes.percep_event);
//routing for real time analytic data
app.get('/stats',analyticRoutes.getRealTimePerceptData);
app.get('/countPerceptions',analyticRoutes.countPerceptions);
//routing for event category
app.get('/searchEventListByGps', eventRoutes.searchEventListByGps);
app.get('/searchEventListByName',eventRoutes.searchEventListByName);
app.post('/registerForEvent', eventRoutes.registerForEvent);
app.post('/publishEventPerception', eventRoutes.publishEventPerception);

http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
}); 