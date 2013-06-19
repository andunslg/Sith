/**
 * @author Sachintha
 */
var stats = require('../stats'),
analyser = require('../Analytics/PerceptionTimeAnalyser');
//send perception totals in each catelog
exports.sendPerceptionCount = function(req,res){
    eventID = req.query.eventID;
	stats.countPerceptions(eventID,function(perceptions){
		//send perceptions as a json abject
		var reply = JSON.stringify({data:[perceptions[0], perceptions[1], perceptions[2], perceptions[3]]});
		res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
		res.write(reply);
		res.end();
	});
};

exports.sendPerceptionCount2 = function(req,res){
    eventID = req.query.eventID;
    console.log(eventID);
    stats.countPerceptions2(eventID,function(perceptions){
        //send perceptions as a json abject
        var reply = JSON.stringify({data:perceptions});
        res.writeHead(200, {
            'Content-Type' : 'application/json',
            'Cache-Control' : 'no-cache',
            'Connection' : 'keep-alive'
        });
        res.write(reply);
        res.end();
    });
};
/*
exports.sendPeriodicTotalPerceptions = function(req,res){
		res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});	
		var id = (new Date()).toLocaleTimeString();
		setInterval(function() {
		constructTotPerceptionMessage(res, id, (new Date()).getTime());
		},3000);
};
*/
exports.sendPeriodicAvgPerception = function(req,res){
		res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});	
		var id = (new Date()).toLocaleTimeString();
		setInterval(function() {
		constructAvgPerceptionMessage(res, id, (new Date()).getTime());
		},3000);
};

exports.sendPeriodicPerceptionCount = function(req,res){
    eventID = req.query.eventID;
    console.log(eventID);
	res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});	
		setInterval(function() {
		constructCountMessage(eventID, res);
		},3000);
}

/*
function constructAvgPerceptionMessage(res,id,time){
	stats.calAveragePerception(function(avg){
		res.write('event: graph\n');
		res.write('data: {\n');
		res.write('data: "id": "'+id+'",\n');
   		res.write('data: "timeStamp": "'+time +'",\n');
    	res.write('data: "value": "'+avg+'"\n');
    	res.write('data: }\n\n');
	});
};
*/

function constructCountMessage(eventID,res){
//	var perceptions;
	stats.countInstantPerceptions(eventID,function(perceptions){
        perceps = JSON.stringify(perceptions);
		res.write('event: graph\n');
    	res.write('data: '+perceps+'\n\n');
});
	
};

exports.getTimeAnalysis = function(req,res){
    var collection = "EventPerceptions_"+req.query.eventID;
    //var sortfield = req.query.sortfield;
    //var sortkey = new Object(sortfield: req.query.order);
        analyser.getTimeAnalysisData(collection,{timeStamp:+1},function(result){
            dataString = JSON.stringify(result)
            res.writeHead(200, {
                'Content-Type' : 'application/json',
                'Cache-Control' : 'no-cache',
                'Connection' : 'keep-alive'
            });
            res.write(JSON.stringify(dataString));
            res.end();
        });
};

exports.getSelfAnalytics= function(req,res){
    var collection = "UserPerceptions_"+req.query.userID;
    //var sortfield = req.query.sortfield;
    //var sortkey = new Object(sortfield: req.query.order);
    analyser.getTimeAnalysisData(collection,{timeStamp:+1},function(result){
        dataString = JSON.stringify(result)
        res.writeHead(200, {
            'Content-Type' : 'application/json',
            'Cache-Control' : 'no-cache',
            'Connection' : 'keep-alive'
        });
        res.write(JSON.stringify(dataString));
        res.end();
    });
}
/*
function constructTotPerceptionMessage(res){
	stats.countTotPerceptions(function(length){
		res.write('event: Totgraph\n');
		res.write('data: {\n');
    	res.write('data: "length":'+length+'\n');
    	res.write('data: }\n\n');
	});
}*/
