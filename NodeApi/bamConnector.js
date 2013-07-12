/**
 * Created by Prabhath on 7/12/13.
 */



exports.sendSubscriptionStreamDef=function(){

    // create the JSON object
    jsonObject = JSON.stringify(
        {
            "name":"stockquote.stream5",
            "version": "1.0.2",
            "nickName": "Stock Quote Information",
            "description": "Some Desc",
            "tags":["foo", "bar"],
            "metaData":[
                {
                    "name":"ipAdd",
                    "type":"STRING"
                }
            ],
            "payloadData":[
                {
                    "name":"symbol",
                    "type":"string"
                },
                {
                    "name":"price",
                    "type":"double"
                },
                {
                    "name":"volume",
                    "type":"int"
                },
                {
                    "name":"max",
                    "type":"double"
                },
                {
                    "name":"min",
                    "type":"double"
                }
            ]
        }
    );

    var username = 'Test';
    var password = '123';
    var auth = 'Basic ' + new Buffer(username + ':' + password).toString('base64');

// prepare the header
    var postheaders = {
        'Content-Type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization': auth,
        'Content-Length' : Buffer.byteLength(jsonObject, 'utf8')
    };

// the post options
    var optionspost = {
        host : 'localhost',
        port : 9443,
        path : '/datareceiver/1.0.0/streams/',
        method : 'POST',
        headers : postheaders
    };

    restClent.doPOSTRequest(optionspost,jsonObject);

}

exports.sendPerceptionStreamDef=function(){

}

exports.sendUserStreamDef=function(){

}