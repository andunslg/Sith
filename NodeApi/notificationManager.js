/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 8/19/13
 * Time: 10:14 PM
 * To change this template use File | Settings | File Templates.
 */
/**
 * notification status can be pending/seen
 * type can be friendRequest/cepNotification
 * **/
notifyMongoAdapter = require('./mongoAdapter.js');

//retrieve notifications in db for a particular user filtering on type and status
exports.getNotifications = function(type,status,userID,fn){
    var query;
    if(!type && !status){
      query = {}
    }else if(status && type){
       query = {status:status,type:type}
    }else if(status){
      query = {status:status}
    }else if(type){
      query = {type:type}
    }
   notifyMongoAdapter.getDocuments(query,"UserNotifications_"+userID,function(docs){
       fn(docs);
   });
}
exports.removeNotification = function(userID,query){
   notifyMongoAdapter.deleteDocument("UserNotifications_"+userID,query,function(err){
       if(err)
        throw err;
   })
}
//add a notification to the db
exports.addNotification = function(sender,type,status,text,userID){
    var doc = {sender:sender,type:type,status:status,text:text}
    notifyMongoAdapter.insertDocument("UserNotifications_"+userID,doc);
}
//send notifications to users
exports.notifySingleUser = function(sender,receiver,type,msg,isReceiverOnline){
    if(isReceiverOnline){
        GLOBAL.io.sockets.socket(GLOBAL.onlineUsers[receiver].socket).emit(type,msg);
        this.addNotification(sender,type,"pending",msg,receiver);
    }else{
        this.addNotification(sender,type,"pending",msg,receiver);
    }
}
//send Map notifications on patterns
exports.notifyManyUsers = function(type,msgdata){
    for(i=0;i<GLOBAL.realTimeMapUser.length;i++){
       GLOBAL.io.sockets.socket(GLOBAL.realTimeMapUser[i].id).emit(type,msgdata);
    }

}

exports.setCurrentNotifsAsRead = function(userID,fn){
    notifyMongoAdapter.updateAllDocuments("UserNotifications_"+userID,{status:"pending"},{status:"seen"},function(error){
        if(!error){
            fn(true);
        }else{
            fn(false)
        }
    });
}