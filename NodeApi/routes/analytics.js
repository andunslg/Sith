/**
 * @author Sachintha
 */
stats = require('../stats');
exports.getRealTimePerceptData = function(req,res){
	//get realtime graph data
	stats.getGraphData(req,res);
	
};

exports.countPerceptions = function(req,res){
	stats.countPerceptions(function(perceptions){
		//add perception counts to a json string
		var reply = JSON.stringify({angry:perceptions[0],sad:perceptions[1],
									boring:perceptions[2],nutral:perceptions[3],
									happy:perceptions[4],excited:perceptions[5]});
									
		//create the response
		res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
		res.write(reply);
		res.end();
	});
	
}
