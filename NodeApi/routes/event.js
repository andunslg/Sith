/**
 * @author Sachintha
 * This file handles requests come for events
 */

// This method returns the nearest event list as a json object given the users gps location
percepManager = require("../perceptionManager");
eventManager = require("../eventManager");
userManager = require("../userManager");
exports.addEvent = function(req,res){
	eventManager.addEvent(req.body.eventID,req.body.eventName,req.body.eventAdmin, req.body.desc, req.body.location, req.body.startDate,
							req.body.endDate, req.body.startTime,req.body.endTime, req.body.perceptionSchema, req.body.commentEnabled);
    userManager.addUserToEvent(req.body.eventID,req.body.eventAdmin,'admin',function(error){
        if(error){
            console.log(error);
            res.write(JSON.stringify({result:error.message}));
            res.end();
        }else{
            res.writeHead(200, {'Content-Type': 'application/json'});
            var result = JSON.stringify({response: true });
            res.write(result);
            res.end();
        }
    });

};

exports.getEventByID = function(req,res){
    eventManager.getEventByID(req.query.eventID,function(docs){
        res.writeHead(200, {'Content-Type': 'application/json'});
        var result = JSON.stringify(docs);
        res.write(result);
        res.end();
    });
};

exports.getAllEvents = function(req,res){
    eventManager.getAllEvents(function(docs){
        res.writeHead(200, {'Content-Type': 'application/json'});
        var result = JSON.stringify(docs);
        res.write(result);
        res.end();
    });
};

exports.getParticipants = function(req,res){
    eventManager.getParticipants(req.query.eventID,function(docs){
        res.writeHead(200, {'Content-Type': 'application/json'});
        var result = JSON.stringify(docs);
        res.write(result);
        res.end();
    });
};
exports.deleteEvent = function(req,res){
    eventManager.deleteEvent(req.query.eventID);
    res.writeHead(200, {'Content-Type': 'application/json'});
    var result = JSON.stringify({response: true });
    res.write(result);
    res.end();
};
exports.setCommentEnabled = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    eventManager.setCommentEnabled(req.body.eventID,req.body.commentEnabled,function(result){
            if(result){
                res.write(JSON.stringify({response: true }));
            }else{
                res.write(JSON.stringify({response: false}));
            }
            res.end();
        });

};

exports.updateEvent = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    eventManager.updateEvent(req.body.oldEventID,req.body.eventID,req.body.eventName,req.body.eventAdmin,
                            req.body.desc, req.body.location, req.body.date,req.body.startTime, req.body.endTime,
                            req.body.perceptionSchema,req.body.commentEnabled,function(result){
           if(result){
               res.write(JSON.stringify({response: true }));
           }else{
               res.write(JSON.stringify({response: false}));
           }
            res.end();
        });

};
exports.searchEventListByGps = function(req,res){	
	// dataAdapter.getEventListByGps(req.body.gpsLocation);
	res.writeHead(200, {'Content-Type': 'application/json'});	
	var result = JSON.stringify([{eventName : "Colombo Code Camp", location : "Hilton", startTime :"0800", endTime :"1000"},
								 {eventName : "Architecture Meetup", location : "WSO2,kolpity", startTime :"0900", endTime :"1700"}
								]);
	res.write(result);
	res.end();
};

// This method returns the nearest event list as a json object given the name
exports.searchEventListByName = function(req,res){
	//dataAdapter.getEventListByGps(req.body.eventName);
	res.writeHead(200, {'Content-Type': 'application/json'});
  	//res.end('Hello World\n');
	var result = JSON.stringify({eventList : {eventName : "Colombo Agile Camp", location : "GallFace Hotel",
												startTime :"1600", endTime :"1900"}
								});
	res.write(result);
	res.end();
};

exports.publishEventPerception = function(req,res){
   	percepManager.insertPerception(req.body.userID , req.body.eventID , req.body.perceptionValue);
	res.writeHead(200, {'Content-Type': 'application/json'});
  	var result = JSON.stringify({response: true });
	res.write(result);
	res.end();
};

exports.publishComment = function(req,res){
	percepManager.insertComment(req.body.userID , req.body.eventID , percepManager.mapPerception(req.body.perceptionValue) , req.body.text);
	res.writeHead(200, {'Content-Type': 'application/json'});
  	var result = JSON.stringify({response: true });
	res.write(result);
	res.end();
}

exports.getEventComments = function(req,res){
	percepManager.getEventComments(req.query.eventID,function(docs){
	res.writeHead(200, {'Content-Type': 'application/json'});
	res.write(JSON.stringify(docs));
	res.end();
	});	
}

exports.getMasterPerceptions = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    res.write(JSON.stringify([{'perception':'Awesome','value':'1'},{'perception':'Wonderful','value':'2'},{'perception':'Excited','value':'3'}, {'perception':'Interested','value':'4'},{'perception':'Happy','value':'5'}, {'perception':'Neutral','value':'6'}, {'perception':'Bored','value':'7'}, {'perception':'Sleepy','value':'8'}, {'perception':'Sad','value':'9'}, {'perception':'Angry','value':'10'}, {'perception':'Horrible','value':'11'}]));
    res.end();
}