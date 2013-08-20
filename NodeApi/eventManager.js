/**
 * @author Sachintha
 *
 */
bamConnector=require("./bamConnector.js");
util=require("./util.js")

exports.addEvent = function(eventID, eventName,eventAdmin, desc, location,latLng, startDate,endDate, startTime, endTime,perceptionSchema, commentEnabled,fixedLocation,colors,timeVariantParams){
	doc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,latLng:latLng,
			startDate:startDate,endDate:endDate, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema, commentEnabled:commentEnabled,fixedLocation:fixedLocation, colors:colors,timeVariantParams:timeVariantParams };
	mongoAdapter.insertDocument('EventDetails',doc);
	mongoAdapter.createCollection('EventPerceptions_'+eventID);
    mongoAdapter.createCollection('EventComments_'+eventID);
	mongoAdapter.createCollection('EventUser_'+eventID);
    mongoAdapter.createCollection('EventInstantPerceptions_'+eventID);
    mongoAdapter.createCollection('EventTimeVariantParams_'+eventID);

    //unix timestamp
    var start=(util.parseDateTime(startDate,startTime)).getTime();
    var end=(util.parseDateTime(endDate,endTime)).getTime();

    //TODO Prabhath : Add  fixedLocation,timeVariantParams to bam send
    bamConnector.addEventInfo(eventAdmin,eventID,eventName,location,latLng.lat,latLng.lng,start,end,'false');
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
    mongoAdapter.dropCollection('EventTimeVariantParams_'+eventID);
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

exports.updateEvent = function(oldEventID,eventID, eventName,eventAdmin, desc, location,latLng, startDate,endDate, startTime, endTime,perceptionSchema,commentEnabled,fixedLocation,colors,timeVariantParams,fn){
    var newdoc = {eventID:eventID,eventName:eventName,eventAdmin:eventAdmin, description:desc, location:location,latLng:latLng,
        startDate:startDate,endDate:endDate, startTime:startTime, endTime:endTime, perceptionSchema:perceptionSchema, commentEnabled:commentEnabled,fixedLocation:fixedLocation,colors:colors, timeVariantParams:timeVariantParams};
     this.getEventByID(eventID,function(result){
         if(!result || (oldEventID==eventID)){
             mongoAdapter.updateDocument('EventDetails',{eventID:oldEventID},newdoc);
             fn(true);
         }else{
             fn(false);
         }
     });
    //TODO Prabhath : Add bam event update
}
exports.getParticipants = function(eventID,fn){
    mongoAdapter.getDocuments({}, 'EventUser_' + eventID, function (docs) {
        fn(docs);
    });
};

exports.getColorSchema = function(eventID,fn){
    mongoAdapter.getSingleDocument({eventID: eventID},'EventDetails', function (doc) {
        if(doc.colors){
            var colorArray = doc.colors.split(":");
            var percepArray = doc.perceptionSchema.split(":");
            var colorSchema = new Object();
            for(var i=0; i<percepArray.length;i++){
                colorSchema[percepArray[i]] = colorArray[i];
            }
            fn(colorSchema);
        } else{
            fn("Error");
        }
    });
}

exports.insertTimeVariantParam = function(eventID,timeVariantParam) {

    mongoAdapter.insertDocument("EventTimeVariantParams_"+eventID, timeVariantParam);

}