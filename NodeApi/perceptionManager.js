/**
 * @author Sachintha
 */
//mongoAdapter = require('./mongoAdapter.js');
exports.insertPerception = function(userID,eventID,perceptionVal) {
	doc = { eventID: eventID, userID: userID, perceptionValue: perceptionVal, timeStamp: (new Date()).getTime()};
	mongoAdapter.insertDocument("Event_Perception", doc);
}

exports.getPerceptionForEvent = function(eventID){
	//code for filter based on events
}

exports.getPerceptionForUser = function(userID){
	//code for filter based on users
}

exports.getAllPerception = function(fn){
	//var count=0;
	mongoAdapter.getDocuments({},"Event_Perception",function(docs){
			fn(docs);
	});
				
}
//Map strings to perception values
exports.mapPerception = function(perception){
	switch(perception)
			{
				case "Interested":
  				return "+2";
  				break;
				case "Happy":
  				return "+1";
  				break;
  				case "Bored":
  				return "-1";
  				break;
  				case "Sleepy":
  				return "-2";
  				break;
				default:
  				return "Not valid";
			}
}

exports.insertComment = function(userID, eventID, perceptionValue, text){
	doc = {userID:userID, eventID:eventID, perceptionValie:perceptionValue,text:text}
	mongoAdapter.insertDocument("Comments", doc);
}

exports.getAllComments = function(fn){
	mongoAdapter.getDocuments({},"Comments",function(docs){
		fn(docs);
	});
}
