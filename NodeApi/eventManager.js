/**
 * @author Sachintha
 */
exports.addEvent = function(eventID, eventName,eventAdmin, desc, location, startDate,endDate, startTime, endTime,perceptionSchema){
	doc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
			startDate:startDate,endDate:endDate, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerception_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
};

exports.getEventByID = function(eventID,fn){
     mongoAdapter.getSingleDocument({eventID: eventID},'EventDetails', function (doc) {
         fn(doc);
     });
};

exports.getAllEvents = function(fn){
    mongoAdapter.getDocuments({}, 'EventDetails', function (doc) {
        fn(doc);
    });
};
exports.deleteEvent = function(eventID){
    mongoAdapter.deleteDocument('EventDetails', {eventID:eventID},function(err){
              if(err)
                console.log(err.message);
    });
    mongoAdapter.dropCollection('EventPerception_'+eventID);
    mongoAdapter.dropCollection('EventUser_'+eventID);
};

exports.updateEvent = function(oldEventID,eventID, eventName,eventAdmin, desc, location, date, startTime, endTime,perceptionSchema,fn){
    newdoc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
        date:date, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema};
     this.getEventByID(eventID,function(result){
         if(!result || (oldEventID==eventID)){
             mongoAdapter.updateDocument('EventDetails',{eventID:oldEventID},newdoc);
             fn(true);
         }else{
             fn(false);
         }
     });
}
exports.getParticipants = function(eventID,fn){
    mongoAdapter.getDocuments({}, 'EventUser_' + eventID, function (docs) {
        fn(docs);
    });
};