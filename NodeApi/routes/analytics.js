/**
 * @author Sachintha
 */
stats = require('../stats');
exports.getRealTimePerceptData = function(req,res){
	stats.getGraphData(req,res);
	
}
