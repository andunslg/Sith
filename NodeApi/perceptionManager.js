/**
 * @author Sachintha
 */
//mongoAdapter = require('./mongoAdapter.js');
exports.insertPerception = function(userID,eventID,perceptionVal) {
	doc = { eventID: eventID, userID: userID, perceptionValue: perceptionVal, timeStamp: (new Date()).getTime()};
	mongoAdapter.insertDocument("EventPerceptions_"+eventID, doc);
    mongoAdapter.insertDocument("UserPerceptions_"+userID,doc);
    insertInstantPercep(doc);
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
	//var count=0;
	mongoAdapter.getDocuments({}, "EventPerceptions_"+eventID, function(docs){
			fn(docs);
	});
				
};
exports.getInstantPerception = function(eventID,fn){
    //var count=0;
    mongoAdapter.getDocuments({}, "EventInstantPerceptions_"+eventID, function(docs){
        fn(docs);
    });

};
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

exports.insertComment = function(userID, eventID, perceptionValue, text){
	doc = {userID:userID, eventID:eventID, perceptionValue:perceptionValue,text:text}
	mongoAdapter.insertDocument("EventComments_"+eventID, doc);
}

exports.getEventComments = function(eventID,fn){
	mongoAdapter.getDocuments({},"EventComments_"+eventID,function(docs){
		fn(docs);
	});
}
