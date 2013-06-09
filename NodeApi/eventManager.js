/**
 * @author Sachintha
 */
exports.addEvent = function(eventID, eventName,eventAdmin, desc, location, date, startTime, endTime,perceptionSchema){
	doc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
			date:date, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerception_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
};

exports.getEventByID = function(eventID,fn){
     mongoAdapter.getDocuments({eventID:eventID},'EventDetails',function(doc){
                fn(doc);
     });
};

exports.getAllEvents = function(fn){
    mongoAdapter.getDocuments({},'EventDetails',function(doc){
        fn(doc);
    });
};
exports.deleteEvent = function(eventID){
   //mongoAdaptercall
};

