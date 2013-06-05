/**
 * @author Sachintha
 * This file handles requests come for events
 */

// This method returns the nearest event list as a json object given the users gps location
percepManager2 = require("../perceptionManager");
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
	//dataAdapter.publishEventPerception(userId,eventId,timestamp,perception_val)
   	percepManager2.insertPerception(req.body.userID , req.body.eventID , percepManager2.mapPerception(req.body.perceptionValue));  	
	res.writeHead(200, {'Content-Type': 'application/json'});
  	var result = JSON.stringify({response: true });
	res.write(result);
	res.end();
};

