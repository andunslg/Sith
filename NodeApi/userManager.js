/**
 * @author Sachintha
 */
mongoAdapter = require('./mongoAdapter.js');
mySQLConnector= require("./mySQLConnector.js");
bamConnector= require("./bamConnector.js");
notificationManager2 = require("./notificationManager.js");
var crypto = require('crypto');

//annonymous users are registered without having any email verification...just collect username and password
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

exports.addAnalyticsUser=function(req,res){
    //TODO
    mySQLConnector.createMySQLDB(req.body.userName,"1234");
    bamConnector.createTanant();
}


exports.addFBUser = function(userName,token){
    var newUserName = "sith@123!@#$_" +userName;
    var document = {userName: newUserName, token:token};
    mongoAdapter.insertDocument('Users',document);
    mongoAdapter.createCollection('UserEvent_'+newUserName);
    mongoAdapter.createCollection('UserPerceptions_'+newUserName);
};
exports.getUserById = function(userID,fn){
    mongoAdapter.getSingleDocument({userName: userID},'Users', function (docs) {
        fn(docs);
    });
};

exports.updateAnnonymousUser = function(oldUserName, userName,password,fn){
    var hash = crypto.createHash('md5').update(password).digest("hex");
    newDoc = {userName:userName,password:hash}
    this.getUserById(userName,function(result){
        console.log(result);
        if((!result) || (oldUserName==userName)){
            mongoAdapter.updateDocument('Users',{userName:oldUserName},newDoc);
            fn(true);
        }else{
            fn(false);
        }
    })

};

exports.deleteUser = function(userID,fn){
    mongoAdapter.deleteDocument('Users',{userName:userID},function(error){
        if(error){
            fn(error);
            return;
        }
        fn(null);
    });
    mongoAdapter.dropCollection('UserEvent_'+userID);
    mongoAdapter.dropCollection('UserPerceptions_'+userID);
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
            mongoAdapter.getSingleDocument({userName:req.body.userName},"OnlineUsers",function(onlineUsers){
             if(!onlineUsers){
                 mongoAdapter.insertDocument("OnlineUsers",doc);
             }
                res.write(JSON.stringify({result:true}));
                res.end();
            })

        }else{
            res.write(JSON.stringify({result:false}));
            res.end();
        }
    });
}

exports.logOut = function(userID,fn){
         mongoAdapter.deleteDocument("OnlineUsers",{userName:userID},function(error){
          if(error){
            fn(error);
          }
             fn(null);
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

exports.sendFriendRequest = function(sender,receiver){
    //add firend request entry in the senders table for annotate friend list in searching. To identify the users to whom the sender have sent the message
    notificationManager2.addNotification(receiver,"friendRequestToOther","pending","friend request to "+receiver,sender);
    //send notification to the receiver
    notificationManager2.notifyUserByOtherUser(sender,receiver,"friendRequest",generateFriendRequestMessage(sender),isUserOnline(receiver));
}
//sender is the one who has sent the requestand receiver is the one who accept the notification
exports.acceptsFriendRequest = function(sender,receiver){
   mongoAdapter.insertDocument("UserFriends_"+sender,{UserName:receiver});
   mongoAdapter.insertDocument("UserFriends_"+receiver,{UserName:sender});
   mongoAdapter.updateDocument("UserNotifications_"+receiver,{sender:sender,type:"friendRequest"},{"status":"friended"});
   notificationManager2.notifyUserByOtherUser(receiver,sender,"requestAccepted",receiver+" has accepted your friend request",isUserOnline(sender));
   notificationManager2.removeNotification(sender,{sender:receiver,type:"friendRequestToOther"});
}

generateFriendRequestMessage = function(sender){
    var msg = sender+" wants to be a friend of you!"
    return msg;
}
isUserOnline = function(userName){
     if(GLOBAL.onlineUsers[userName]){
         return true;
     }
    return false;
}
exports.removeUserFromEvent = function(userID,eventID,fn){
    mongoAdapter.deleteDocument('EventUser_'+eventID,{userID:userID},function(err){
        if(err)
            fn(err);
        fn(null);
    });
    mongoAdapter.deleteDocument('UserEvent_'+userID,{eventID:eventID},function(err){
        if(err)
            fn(err);
        fn(null);
    });
}
exports.getSubscribedEvents = function(userID,fn){
    mongoAdapter.getDocuments({},'UserEvent_'+userID,function(docs){
        fn(docs);
    });
}
