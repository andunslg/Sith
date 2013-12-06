var restClient=  require('./RestClient.js');
var cepNotificationManager= require("./notificationManager.js");
function sendUpdate(jsonObject,streamPath,isData) {
    var auth = "Basic " + new Buffer('admin:apst@sith').toString("base64");

    if(!streamPath){
        streamPath='';
    }

    // prepare the header
    var postheaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": auth
    };

    if(!isData) {
        // the stream definition post options
        var optionsDefPost = {
            host: '192.248.15.232',
            port: '9443',
            path: '/datareceiver/1.0.0/streams/'+streamPath,
            method: 'POST',
            rejectUnauthorized: 'true',
            headers: postheaders

        };
        restClient.doPOSTRequest(optionsDefPost, jsonObject);
    } else{
        // the stream definition post options
        var optionsDataPost = {
            host: '192.248.15.232',
            port: '9443',
            path: '/datareceiver/1.0.0/stream/'+streamPath,
            method: 'POST',
            rejectUnauthorized: 'true',
            headers: postheaders

        };
        restClient.doPOSTRequest(optionsDataPost, jsonObject);
    }
}

exports.sendSithPerceptionStreamDef=function(){
    jsonObject = JSON.stringify(
        {
            "name":"sith_Perception_Analytics",
            "version": "1.0.0",
            "nickName": "Sith Analytics",
            "description": "Sith_Perception_Analytics",
            "payloadData":[
                {
                    "name":"eventID","type":"STRING"
                },
                {
                    "name":"userID","type":"STRING"
                },
                {
                    "name":"perceptionValue","type":"STRING"
                },
                {
                    "name":"comment","type":"STRING"
                },
                {
                    "name":"lat","type":"STRING"
                },
                {
                    "name":"lng","type":"STRING"
                },
                {
                    "name":"location","type":"STRING"
                }
            ]
        }
    );
    sendUpdate(jsonObject,'',false);
}

exports.sendSithPerception=function(userID,eventID,perceptionVal,comment,lat,lng,location){
    jsonObject = JSON.stringify([
        {
            "payloadData":[eventID,userID,perceptionVal,'myComment',lat,lng,'CSE'],
            "metadata":['127.0.0.1']
        }
    ]);
    console.log(jsonObject);
    var path="sith_Perception_Analytics"+'/1.0.0/' ;
    sendUpdate(jsonObject,path,true);
}

exports.sendNotificationOnPatterns = function(eventID,msg){
    console.log(eventID+"  "+msg);
   mongoAdapter.getSingleDocument({eventID:eventID},"EventDetails",function(docs){
       var isAdminOnline;
       if(GLOBAL.onlineUsers[docs.eventAdmin]){
           isAdminOnline = true;
       }else{
           isAdminOnline = false;
       }
      cepNotificationManager.notifySingleUser("cep",docs.eventAdmin,"cepNotification",msg,isAdminOnline)
    })
}

exports.sendMapNotificationOnPatterns = function(lat,long,perception){
//    lat ="6.932871";
//    long ="79.8431396";
    lat = parseFloat(lat);
    long =parseFloat(long);
    var msgdata = {lat:lat , long:long , perception:perception};
    cepNotificationManager.notifyManyUsers("cepMapNotification",msgdata);
}