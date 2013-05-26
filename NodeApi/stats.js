/**
 * @author Sachintha
 * This file is for all statistical calculations returned by db
 */

mongoAdapter = require('./mongoAdapter');
exports.getGraphData = function(req,res){
if (req.headers.accept && req.headers.accept == 'text/event-stream') {
	if (req.url == '/stats') {
		sendSSE(req, res);
	} else {
		res.writeHead(404);
		res.end();
	}
	} else {
		console.log('header error');
		sendSSE(req, res);
		//res.render('webDashboard.html');
	}
}	


function sendSSE(req, res) {
	res.writeHead(200, {
		'Content-Type' : 'text/event-stream',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
	});

	var id = (new Date()).toLocaleTimeString();

	 //Sends a SSE every 5 seconds on a single connection.
	setInterval(function() {
		constructSSE(res, id, (new Date()).getTime(), Math.random());
	}, 5000);

	constructSSE(res, id, (new Date()).getTime(), Math.random());
}

function constructSSE(res, id, time,data) {
	var averagePerception;
	calAveragePerception(function(avg){
		this.averagePerception = avg;
	});
	res.write('event: graph\n');
	res.write('data: {\n');
	res.write('data: "id": "'+id+'",\n');
    res.write('data: "timeStamp": "'+time +'",\n');
    res.write('data: "value": "'+ this.averagePerception +'"\n');
    res.write('data: }\n\n');
}

//calculates average perception
function calAveragePerception(fn){
	mongoAdapter.getAllPerception(function(docs){
		var count = docs.length;
		var perception =0;
		for(var i=0; i<count; i++){
         perception += parseInt(docs[i].perceptionValue);
        
        }
		var avg = perception/count;
		//console.log(count);
		fn(avg);
	});
}

//count perception values under each category
exports.countPerceptions =function(fn){
	mongoAdapter.getAllPerception(function(docs){
		var count = docs.length;
		var perceptions  = [0,0,0,0,0,0];
		for(var i=0; i<count; i++){
         switch(docs[i].perceptionValue)
			{
				case "-3":
  				perceptions[0]++;
  				break;
				case "-2":
  				perceptions[1]++;
  				break;
  				case "-1":
  				perceptions[2]++;
  				break;
  				case "0":
  				perceptions[3]++;
  				break;
  				case "+1":
  				perceptions[4]++;
  				break;
  				case "+2":
  				perceptions[5]++;
  				break;
				default:
  				console.log('perception not found');
			}
        
        }
		//console.log(count);
		fn(perceptions);
	});
}

function debugHeaders(req) {
	sys.puts('URL: ' + req.url);
	for(var key in req.headers) {
		sys.puts(key + ': ' + req.headers[key]);
	}
	sys.puts('\n\n');
}