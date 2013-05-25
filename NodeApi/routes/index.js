/*
 * GET home page.
 */

var	config = require('../config'),
	fs = require('fs'),
	stats = require('../stats');

/*
 * GET home page.
 */

exports.index = function(req, res) {
	res.render('index.html');
};

exports.temp= function(req, res) {
	res.render('../vividphoto/index.html');
};
exports.percep_event = function(req, res) {
	res.render('vote.html');
};
/*
 * POST new vote via SMS
 */
exports.post_percep = function(req, res) {
	//res.render('percep_event.hjs',res.value);
	//var __vote = req.param('vote');
	
	//sqladapter.insertVote("1", req.body.userId, req.body.vote);
	//stats.sendUpdate(req,res);
	//res.render('percep_event.hjs', {
	//	vote : req.body.vote,
	//	id : req.body.userId
	//});
	res.writeHead(200, {'Content-Type': 'application/json'});
  	//res.end('Hello World\n');
	var result = JSON.stringify({vote : req.body.vote , id : req.body.userId});
	res.write(result);
	res.end();
	//socket.emit('message', { message: 'Graph data stream new data!'});
};

exports.percep_event_graph_data = function(req, res){
	stats.getGraphData(req,res);
}
exports.getWebDashboard = function(req, res) {
	res.render('webDashboard.html');
};

