var restClient=  require('./RestClient.js');

function sendUpdate(jsonObject,streamPath) {
    var auth = "Basic " + new Buffer('admin:admin').toString("base64");

    if(!streamPath){
        streamPath='';
    }

// prepare the header
    var postheaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "Authorization": auth
    };

// the post options
    var optionspost = {
        host: '127.0.0.1',
        port: '9443',
        path: '/datareceiver/1.0.0/streams/'+streamPath,
        method: 'POST',
        rejectUnauthorized: 'false',
        headers: postheaders

    };

    restClient.doPOSTRequest(optionspost, jsonObject);
}


exports.sendPerceptionStreamDef=function(userID,password,eventID,eventName,eventDescription){

    // create the JSON object
    jsonObject = JSON.stringify(
        {
            "name":eventID+"_perception_stream",
            "version": "1.0.0",
            "nickName": eventName,
            "description": eventDescription,
//            "metaData":[
//                {
//                    "name":"ipAdd"
//                }
//            ],
            "payloadData":[
                {
                    "name":"subcriptionID",
                    "type":"string"
                },
                {
                    "name":"userID",
                    "type":"double"
                },
                {
                    "name":"emotion",
                    "type":"int"
                },
                {
                    "name":"locationName",
                    "type":"double"
                },
                {
                    "name":"latitude",
                    "type":"double"
                },
                {
                    "name":"longitude",
                    "type":"double"
                },
                {
                    "name":"time",
                    "type":"double"
                }
            ]
        }
    );
    sendUpdate(jsonObject);
}

exports.sendSubscriptionStreamDef=function(userID,password,eventID,eventName,eventDescription,timeVarientPms){
    jsonObject = JSON.stringify(
        {
            "name":eventID+"_info_stream",
            "version": "1.0.0",
            "nickName": eventName+"_subcriptionInfo",
            "description": eventDescription,
            "payloadData":[
                {
                    "name":"subcriptionID",
                    "type":"string"
                },
                {
                    "name":"subcriptionName",
                    "type":"String"
                },
                {
                    "name":"subcriptionLocation",
                    "type":"String"
                },
                {
                    "name":"subcriptionLat",
                    "type":"double"
                },
                {
                    "name":"subcriptionLong",
                    "type":"double"
                },
                {
                    "name":"timeVarient1",
                    "type":"double"
                },
                {
                    "name":"timeVarient2",
                    "type":"double"
                },
                {
                    "name":"time",
                    "type":"double"
                }
            ]
        }
    );
    sendUpdate(jsonObject);
}

exports.sendUserStreamDef=function(userID,password,eventID,eventName,eventDescription){
    jsonObject = JSON.stringify(
        {
            "name":eventID+"_participant_stream",
            "version": "1.0.0",
            "nickName": eventName+"_participantInfo",
            "description": eventDescription,
            "payloadData":[
                {
                    "name":"subcriptionID",
                    "type":"string"
                },
                {
                    "name":"userID",
                    "type":"String"
                },
                {
                    "name":"userName",
                    "type":"String"
                },
                {
                    "name":"isMale",
                    "type":"string"
                },
                {
                    "name":"birthday",
                    "type":"string"
                }

            ]
        }
    );
    sendUpdate(jsonObject);
}

exports.sendPercept=function(userID,password,subcriptionID,emotion,location,latitude,longitude,time,ipadress){
    jsonObject = JSON.stringify(
        {
            "payloadData":[subcriptionID,userID,emotion,location,latitude,longitude,time],
            "metadata":[ipadress]
        }

    );
    var path=subcriptionID+"_perception_stream"+'/1.0.0/' ;
    sendUpdate(jsonObject,path);
}

exports.sendEventUpdate=function(userID,password,subscriptionID,subscriptionName,subscriptionLocation,latitude,longitude,time,timeVarientpms){
    var t='';
    for(temp in timeVarientpms){
        t+=temp+',';
    }
    var s="["+t+"]";
    jsonObject = JSON.stringify(
        {
            "payloadData":[subscriptionID,subscriptionName,subscriptionLocation,latitude,longitude,time,,s]
        }
    );
    var path=subcriptionID+"_participant_stream"+'/1.0.0/' ;
    sendUpdate(jsonObject,path);
}

exports.sendUserUpdate=function(userID,password,subcriptionID,userName,isMale,birthday){
    jsonObject = JSON.stringify(
        {
            "payloadData":[subcriptionID,userID,userName,isMale,birthday]
        }
    );
    var path=subcriptionID+"_participant_stream"+'/1.0.0/'  ;
    sendUpdate(jsonObject,path);
}
