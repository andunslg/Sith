/**
 * @author Sachintha
 */
//mongoAdapter = require('./mongoAdapter.js');
cepConnector = require("./cepConnector.js");
bamConnector= require("./bamConnector.js");


exports.insertPerception = function(userID,eventID,perceptionVal,latLng,location) {
    var time= (new Date()).getTime();

	doc = { eventID: eventID, userID: userID, perceptionValue: perceptionVal, timeStamp: time,latLng:latLng,location:location};
	mongoAdapter.insertDocument("EventPerceptions_"+eventID, doc);
    mongoAdapter.insertDocument("UserPerceptions_"+userID,doc);
    cepConnector.sendSithPerceptionStreamDef();
    cepConnector.sendSithPerception(userID,eventID,perceptionVal,'comment',latLng.lat,latLng.lng,'cse');
    insertInstantPercep(doc);

    bamConnector.sendPercept(userID,eventID,perceptionVal,location,latLng.lat,latLng.lng,time,'0.0.0.0');
}

insertInstantPercep = function(percepdoc){
    mongoAdapter.getSingleDocument({userID:percepdoc.userID},'EventInstantPerceptions_'+percepdoc.eventID,function(doc){
       if(doc){
           mongoAdapter.updateSelectedFields('EventInstantPerceptions_'+percepdoc.eventID,{userID:percepdoc.userID},{perceptionValue:percepdoc.perceptionValue});
          // mongoAdapter.deleteDocument('EventInstantPerceptions_'+percepdoc.eventID,{userID:percepdoc.userID},function(err){
           //  console.log('sss');
          // })
       }else{
           mongoAdapter.insertDocument('EventInstantPerceptions_'+percepdoc.eventID,percepdoc);
       }
    })
}
exports.getPerceptionForEvent = function(eventID){
	//code for filter based on events
}

exports.getPerceptionForUser = function(userID){
	//code for filter based on users
};

exports.getEventPerception = function(eventID,fn){
	mongoAdapter.getDocuments({}, "EventPerceptions_"+eventID, function(docs){
			fn(docs);
	});
				
};
exports.getInstantPerception = function(eventID,fn){
    mongoAdapter.getDocuments({}, "EventInstantPerceptions_"+eventID, function(docs){
        fn(docs);
    });

};

exports.getPerceptionCount = function(eventID,fn){
     mongoAdapter.countDocuments('EventPerceptions_'+eventID,function(count){
               fn(count);
     });
}
//exports.getUser
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

exports.insertComment = function(userID, eventID, perceptionValue, text,lat,lng,location){
	doc = {userID:userID, eventID:eventID, perceptionValue:perceptionValue,text:text}
	mongoAdapter.insertDocument("EventComments_"+eventID, doc);
    cepConnector.sendSithPerceptionStreamDef();
    cepConnector.sendSithPerception(userID,eventID,perceptionValue,text,lat,lng,location);
}

exports.getEventComments = function(eventID,fn){
	mongoAdapter.getDocuments({},"EventComments_"+eventID,function(docs){
		fn(docs);
	});
}

/*
exports.getAggregatedAnalytics = function(userID,perception){
     mongoAdapter.getLocationAggregatedSelfAnalytics("UserPerceptions_sach","Angry",function(docs){
      console.log(docs);
     });
}
/*
var java = require("java");
java.classpath.push("cep-publisher-1.0.jar");
var jClass = java.newInstanceSync("org.sith.cep.publisher.SithCEPPublisher","tcp://192.248.8.246:7611","admin","apst@sith");

exports.publishToCEP = function(userID,eventID,perceptionVal,comment) {
    var metaDataArray = java.newArray("java.lang.Object", ["192.248.8.246"]);
    var payloadArray = java.newArray("java.lang.Object", [eventID,userID,perceptionVal,comment]);
    var result=jClass.publishToCEPSync(metaDataArray,payloadArray);
    console.log("Returned data - "+result);
}*/
