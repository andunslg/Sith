/**
 * @author Sachintha
 * This file is for all statistical calculations returned by db
 */

percepManager = require('./perceptionManager');

//calculates average perception
exports.calAveragePerception = function(fn){
	percepManager.getAllPerception(function(docs){
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
	percepManager.getAllPerception(function(docs){
		var count = docs.length;
		var perceptions  = [0,0,0,0,count];
		for(var i=0; i<count; i++){
         switch(docs[i].perceptionValue)
			{
				case "+2":
  				perceptions[0]++;
  				break;
  				case "+1":
  				perceptions[1]++;
  				break;
  				case "-1":
  				perceptions[2]++;
  				break;
  				case "-2":
  				perceptions[3]++;
  				break;
				default:
  				//console.log('perception not found');
			}
        
        }
		//console.log(count);
		fn(perceptions);
	});
}

//this counts the total perception count
exports.countTotPerceptions = function(fn){
	percepManager.getAllPerception(function(docs){
		fn(docs.length);
	});	
}

function debugHeaders(req) {
	sys.puts('URL: ' + req.url);
	for(var key in req.headers) {
		sys.puts(key + ': ' + req.headers[key]);
	}
	sys.puts('\n\n');
}