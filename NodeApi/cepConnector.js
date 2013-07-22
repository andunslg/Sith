var restClient=  require('./RestClient.js');

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
            host: '127.0.0.1',
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
            host: '127.0.0.1',
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
                }
            ]
        }
    );
    sendUpdate(jsonObject,'',false);
}

exports.sendSithPerception=function(userID,eventID,perceptionVal,comment){
    jsonObject = JSON.stringify([
        {
            "payloadData":[eventID,userID,perceptionVal,comment],
            "metadata":['127.0.0.1']
        }
    ]);
    var path="sith_Perception_Analytics"+'/1.0.0/' ;
    sendUpdate(jsonObject,path,true);
}

