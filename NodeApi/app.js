
/**
 * Module dependencies.
 */

var express = require('express')
  , routes = require('./routes')
  , http = require('http')
  , path = require('path')
  , eventRoutes = require('./routes/event')
  , analyticRoutes = require('./routes/analytics')
  , userMgmtRoutes = require('./routes/userMgmt')
  , passport = require("passport")
  , BearerStrategy =require('passport-http-bearer')
  , cacheAccess = require('./routes/cacheAccess')
  , mapRouts=require('./routes/maps.js')
  ,friendRoutes=require('./routes/friend.js')
  ,notificationManager = require('./routes/notification.js');

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

app.configure('production', function(){
    console.log('prod');
    app.use(express.errorHandler());
});
app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
    console.log('dev');
});

process.on('uncaughtException', function(err) {
    // handle the error safely
    console.log(err);
});

//routes for web pages
app.get('/',routes.index);
app.get('/webDashboard',routes.getWebDashboard);
app.get('/myPerception',routes.percep_event);
app.get('/selfAnalyticDashboard',routes.getSelfAnalyticDashBoard);
app.get('/webDashboard2',routes.getWebDashBoard2);
app.get('/vote',routes.vote);

//routing for real time analytic
//app.get('/getPeriodicAvgPerception',analyticRoutes.sendPeriodicAvgPerception);
app.get('/countPeriodicPerceptions',analyticRoutes.sendPeriodicPerceptionCount);
//app.get('/getAggregated',analyticRoutes.getAggregatedAnalyticsMapReduce);
//routing for perception count data
app.get('/countPerceptions',analyticRoutes.sendPerceptionCount); //deprecated..not using
app.get('/countPerceptions2',analyticRoutes.sendPerceptionCount2);
app.get('/countPerceptionsMapReduce',analyticRoutes.sendPerceptionCountMapReduce);
app.get('/getTimeAnalysis',analyticRoutes.getTimeAnalysis);
app.get('/getSelfAnalytics',analyticRoutes.getSelfAnalytics);

//routing for get all the perceptions available in the platform
app.get('/getMasterPerceptions',eventRoutes.getMasterPerceptions);
app.get('/getColorSchema',eventRoutes.getColorSchema);

//routing for event category
app.post('/addEvent',eventRoutes.addEvent);
app.get('/getEventById',eventRoutes.getEventByID);
app.get('/getAllEvents',eventRoutes.getAllEvents);
app.get('/getParticipants',eventRoutes.getParticipants);
app.get('/deleteEvent',eventRoutes.deleteEvent);
app.put('/updateEvent',eventRoutes.updateEvent);
//app.get('/searchEventListByGps', eventRoutes.searchEventListByGps);
//app.get('/searchEventListByName',eventRoutes.searchEventListByName);
app.post('/publishEventPerception', eventRoutes.publishEventPerception);
app.post('/publishComment',eventRoutes.publishComment);
app.get('/getEventComments',eventRoutes.getEventComments);
app.put('/setCommentEnabled',eventRoutes.setCommentEnabled);
app.post('/addTimeVariantParam',eventRoutes.addTimeVariantParam);
app.post('/getTimeVariantParamValues',eventRoutes.retrieveTimeVariantParam);

//routing for user mangement
app.post('/registerAnnonymousUser',userMgmtRoutes.registerAnnonymousUser);
app.post('/registerFBUser',userMgmtRoutes.registerFBUser);
app.post('/authenticateUser',userMgmtRoutes.authenticateUser);
app.put('/updateAnnonymousUser',userMgmtRoutes.updateAnnonymousUser);
app.get('/registerUserForEvent',userMgmtRoutes.registerUserForEvent);
app.get('/getUserById',userMgmtRoutes.getUserById);
app.get('/getSubscribedEvents',userMgmtRoutes.getSubscribedEvents);
app.get('/unsubscribeFromEvent',userMgmtRoutes.removeUserFromEvent);
app.get('/deleteUser',userMgmtRoutes.deleteUser);

//maps
app.get('/getAllMapData',mapRouts.getAverageLocationPerceptions);
app.get('/getAllCurrentEventMapData',mapRouts.getAllCurrentEventMap);
app.get('/getSelfMap',mapRouts.getSelfMap);
app.get('/getEventMap',mapRouts.getEventMap);
app.get('/getLocationRating',mapRouts.getLocationValue);
//notifs
app.get('/getNotifications',notificationManager.getNotifications);
app.get('/sendFriendRequest',userMgmtRoutes.sendFriendRequest);
app.get('/confirmFriendRequest',userMgmtRoutes.acceptFriendRequest);
//friends
app.get('/getAllfriends',friendRoutes.getAllfriends);
app.get('/getFriendsSuggestions',friendRoutes.searchFriendsToAdd);
app.post('/removeFriend',friendRoutes.removeFriend)
//news feed
app.post('/getUserNews',friendRoutes.getUserNews);
//analytics
app.post('/receiveCEPAnalytics',analyticRoutes.receiveCEPAnalytics);
app.post('/receiveCEPMapAnalytics',analyticRoutes.receiveCEPMapAnalytics)
var server = http.createServer(app).listen(app.get('port'), function(){
  console.log("Express server listening on port " + app.get('port'));
});
GLOBAL.io = require('socket.io').listen(server);
GLOBAL.onlineUsers = {};
GLOBAL.realTimeMapUser = [];
GLOBAL.io.sockets.on('connection', function (socket) {
    socket.on('login', function (userName) {
        GLOBAL.onlineUsers[userName] = {
            "socket":socket.id
        }
        console.log(userName+" logged in!");
    });
    socket.on('realtimeMap', function (userName) {
        GLOBAL.realTimeMapUser.push(socket);
        console.log(userName+" Entered to realtime map");
    });
    socket.on('disconnect', function () {
        var index = GLOBAL.realTimeMapUser.indexOf(socket);
        GLOBAL.realTimeMapUser.splice(index,1);
        console.log("disconnected");
    });
});
