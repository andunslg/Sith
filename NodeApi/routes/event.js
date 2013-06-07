/**
 * @author Sachintha
 * This file handles requests come for events
 */

// This method returns the nearest event list as a json object given the users gps location
percepManager = require("../perceptionManager");
eventManager = require("../eventManager");
exports.addEvent = function(req,res){
	eventManager.addEvent(req.body.eventName, req.body.desc, req.body.location, req.body.date, 
							req.body.startTime, req.body.endTime, req.body.perceptionSchema);
	res.writeHead(200, {'Content-Type': 'application/json'});
  	var result = JSON.stringify({response: true });
	res.write(result);
	res.end();
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

//user regiter for event
exports.registerForEvent = function(req,res){	
	//dataAdapter.registerForEvent(req.body.userId,req.body.eventId);
	res.writeHead(200, {'Content-Type': 'application/json'});
  	var result = JSON.stringify({response: "true" });
	res.write(result);
	res.end();
};

exports.publishEventPerception = function(req,res){
   	percepManager.insertPerception(req.body.userID , req.body.eventID , percepManager.mapPerception(req.body.perceptionValue));  	
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

exports.getAllComments = function(req,res){
	percepManager.getAllComments(function(docs){
	res.writeHead(200, {'Content-Type': 'application/json'});
	res.write(JSON.stringify(docs));
	res.end();
	});	
}
