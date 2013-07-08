/**
 * @author Sachintha
 */
exports.addEvent = function(eventID, eventName,eventAdmin, desc, location, startDate,endDate, startTime, endTime,perceptionSchema, commentEnabled,colors){
	doc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
			startDate:startDate,endDate:endDate, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema, commentEnabled:commentEnabled, colors:colors};
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerceptions_'+eventID);
    mongoAdapter.createCollection('EventComments_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
    mongoAdapter.createCollection('EventInstantPerceptions_'+eventID);
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
    mongoAdapter.dropCollection('EventPerceptions_'+eventID);
    mongoAdapter.dropCollection('EventComments_'+eventID);
    mongoAdapter.dropCollection('EventUser_'+eventID);
    mongoAdapter.dropCollection('EventInstantPerceptions_'+eventID);
};

exports.setCommentEnabled = function(eventID,commentEnabled,fn){
    this.getEventByID(eventID,function(result){
        if(!result ){
            mongoAdapter.updateSelectedFields('EventDetails',{eventID:eventID},{commentEnabled:commentEnabled});
            fn(true);
        }else{
            fn(false);
        }
    });
}
//exports.getCommentEnabled = function(eventID, fn){
//    mongoAdapter.getProjection('EventDetails',{eventID: eventID},{commentEnabled:1}, function (doc) {
//        fn(doc);
//    });
//
//}

exports.updateEvent = function(oldEventID,eventID, eventName,eventAdmin, desc, location, date, startTime, endTime,perceptionSchema,commentEnabled,colors,fn){
    newdoc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,
        date:date, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema, commentEnabled:commentEnabled,colors:colors};
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