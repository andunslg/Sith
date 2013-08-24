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

//add a notification to the db
addNotification = function(type,status,text,userID){
    var doc = {type:type,status:status,text:text}
    notifyMongoAdapter.insertDocument("UserNotifications_"+userID,doc);
}

exports.notifyUser = function(receiver,type,msg,isReceiverOnline){
    if(isReceiverOnline){
        GLOBAL.io.sockets.socket(GLOBAL.onlineUsers[receiver].socket).emit(type,msg);
        addNotification(type,"pending",msg,receiver);
    }else{
        addNotification(type,"pending",msg,receiver);
    }
}