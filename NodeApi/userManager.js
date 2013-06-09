/**
 * @author Sachintha
 */
mongoAdapter = require('./mongoAdapter.js');
var crypto = require('crypto');

exports.addAnnonymousUser = function(req,res){
	res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
	var hash = crypto.createHash('md5').update(req.body.password).digest("hex");
	document = {userName: req.body.userName,password: hash};
	mongoAdapter.getSingleDocument({userName:req.body.userName},'Users',function(doc){
		if(doc){		
			res.write(JSON.stringify({result:false}));
			res.end();
		}else{
			mongoAdapter.insertDocument('Users',document);
            mongoAdapter.createCollection('UserEvent_'+req.body.userName);
            mongoAdapter.createCollection('UserPerceptions_'+req.body.userName);
			res.write(JSON.stringify({result:true}));
			res.end();	
		}
	});
};

exports.authenticateUser = function(req,res){
	res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
	var hash = crypto.createHash('md5').update(req.body.password).digest("hex");
	mongoAdapter.getSingleDocument({userName:req.body.userName , password: hash},'Users',function(doc){
		if(doc){		
			res.write(JSON.stringify({result:true}));
			res.end();
		}else{
			res.write(JSON.stringify({result:false}));
			res.end();	
		}
	});
}

//Register {userID} to {eventID}. status is whether the user is an admin or a participant
exports.addUserToEvent = function(eventID,userID,status,fn){
    console.log(eventID+userID+status);
    mongoAdapter.getSingleDocument({userID:userID},'EventUser_'+eventID,function(doc){
        if(doc){
             fn(new Error('user already registered'));
        }else{
            doc1 = {userID : userID};
            //add userID to eventuser collection(users registered for the given event)
            mongoAdapter.insertDocument('EventUser_'+eventID,doc1);
            //add eventID to userevent collection(all events registered by a given user)
            doc2 = {eventID : eventID,status:status};
            mongoAdapter.insertDocument('UserEvent_'+userID,doc2);
            fn();
        }
    });
};