/**
 * @author Sachintha
 */
var stats = require('../stats'),
analyser = require('../Analytics/PerceptionTimeAnalyser');
mapreduceAnalyser = require('../Analytics/mapReduce');
eventManager2 = require('../eventManager');
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

exports.sendPerceptionCountMapReduce = function(req,res){
     mapreduceAnalyser.categorize("EventPerceptions_"+req.query.eventID,function(results){
         res.writeHead(200, {
             'Content-Type' : 'application/json',
             'Cache-Control' : 'no-cache',
             'Connection' : 'keep-alive'
         });
         var perceptionSchema = new Array();
         eventManager2.getEventByID(req.query.eventID,function(event){
              perceptionSchema = event.perceptionSchema.split(":");
             var perceptions = new Object();
             for(var i=0;i<results.length;i++){
                 perceptions[results[i]._id] = results[i].value.count;
             }
             if(results.length != perceptionSchema.length){
                 for(var i=0;i<perceptionSchema.length;i++){
                     if(!perceptions[perceptionSchema[i]]){
                         perceptions[perceptionSchema[i]] = 0;
                     }
                 }
             };

             res.write(JSON.stringify(perceptions));
             res.end();
         });


     });
}

exports.getAggregatedAnalyticsMapReduce = function(req,res){
   mapreduceAnalyser.aggregate("UserPerceptions_sach","Happy",function(docs){
                console.log(docs);
   });
}
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

//get the analysis data for a given user
exports.getTimeAnalysis = function(req,res){
        analyser.getEventTimeAnalysisData(req.query.eventID,function(result){
            var dataString = JSON.stringify(result)
            res.writeHead(200, {
                'Content-Type' : 'application/json',
                'Cache-Control' : 'no-cache',
                'Connection' : 'keep-alive'
            });
            res.write(dataString);
            res.end();
        });
};

//get self analytics of a user for all the events he participated
exports.getSelfAnalytics= function(req,res){
    analyser.getSelfTimeAnalysis(req.query.userID,null,function(result){
        var dataString = JSON.stringify(result)
        res.writeHead(200, {
            'Content-Type' : 'application/json',
            'Cache-Control' : 'no-cache',
            'Connection' : 'keep-alive'
        });
        res.write(dataString);
        res.end();
    });
}

exports.receiveCEPAnalytics = function(req,res){
    console.log(req.body);
    res.writeHead(200, {'Content-Type': 'application/json'});
    var result = JSON.stringify({response: true });
    res.write(result);
    res.end();
};

/*
function constructTotPerceptionMessage(res){
	stats.countTotPerceptions(function(length){
		res.write('event: Totgraph\n');
		res.write('data: {\n');
    	res.write('data: "length":'+length+'\n');
    	res.write('data: }\n\n');
	});
}*/