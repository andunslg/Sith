/**
 * @author Sachintha
 */
exports.addEvent = function(eventName, desc, location, date, startTime, endTime,perceptionSchema){
	doc = {eventName:eventName, description:desc, location:location, 
			date:date, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerception_'+eventName);
	mongoAdapter.createCollection('EventUser_'+eventName);
};

exports.getEvent = function(eventID){

};

exports.getAllEvents = function(){
    //
};
exports.deleteEvent = function(eventID){
   //mongoAdaptercall
};

exports.addUserToEvent = function(eventID,userID){
    //
};

exports.removeUserFromEvent = function(eventID,userID){

};