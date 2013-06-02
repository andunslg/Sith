/**
 * @author Sachintha
 */
stats = require('../stats');
exports.sendPerceptionCount = function(req,res){
	stats.countPerceptions(function(perceptions){
		//send perceptions as a json abject
		var reply = JSON.stringify({data:[perceptions[0], perceptions[1], perceptions[2], perceptions[3], perceptions[4], perceptions[5]]});
		res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
		res.write(reply);
		res.end();
	});
};

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
	res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});	
		setInterval(function() {
		constructCountMessage(res);
		},3000);
}

function constructAvgPerceptionMessage(res,id,time){
	stats.calAveragePerception(function(avg){
		res.write('event: graph\n');
		res.write('data: {\n');
		res.write('data: "id": "'+id+'",\n');
   		res.write('data: "timeStamp": "'+time +'",\n');
    	res.write('data: "value": "'+avg+'"\n');
    	res.write('data: }\n\n');
	});
}


function constructCountMessage(res){
//	var perceptions;
	stats.countPerceptions(function(perceptions){		
		res.write('event: graph\n');
		res.write('data: {\n');
    	res.write('data: "data": ['+ perceptions[0]+','+perceptions[1]+','+perceptions[2]+','+perceptions[3]+','+perceptions[4]+','+perceptions[5]+']\n');
    	res.write('data: }\n\n');
	});
	
		//res.write(reply);
		//res.end();
	
}
