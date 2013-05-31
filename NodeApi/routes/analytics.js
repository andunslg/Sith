/**
 * @author Sachintha
 */
stats = require('../stats');
exports.getRealTimePerceptData = function(req,res){
	//get realtime graph data
	stats.getGraphData(req,res);
	
};

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

exports.sendPeriodicPerceptionCount = function(req,res){
	res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});	
		//add perception counts to a json string
		//var reply = JSON.stringify({data:[perceptions[0], perceptions[1], perceptions[2], perceptions[3], perceptions[4], perceptions[5]]});								
		//create the response
		setInterval(function() {
		constructCountMessage(res);
		},3000);
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
