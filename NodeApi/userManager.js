/**
 * @author Sachintha
 */
mongoAdapter2 = require('./mongoAdapter.js');
var crypto = require('crypto');

exports.addAnnonymousUser = function(req,res){
	res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
	var hash = crypto.createHash('md5').update(req.body.password).digest("hex");
	document = {userName: req.body.userName,password: hash};
	mongoAdapter2.getSingleDocument({userName:req.body.userName},'Users',function(doc){
		if(doc){		
			res.write(JSON.stringify({result:false}));
			res.end();
		}else{
			mongoAdapter2.insertDocument('Users',document);
			res.write(JSON.stringify({result:true}));
			res.end();	
		}
	});
};

exports.authenticateUser = function(req,res){
	res.writeHead(200, {
		'Content-Type' : 'application/json',
		'Cache-Control' : 'no-cache',
		'Connection' : 'keep-alive'
		});
	var hash = crypto.createHash('md5').update(req.body.password).digest("hex");
	mongoAdapter2.getSingleDocument({userName:req.body.userName , password: hash},'Users',function(doc){
		if(doc){		
			res.write(JSON.stringify({result:true}));
			res.end();
		}else{
			mongoAdapter2.insertDocument('SithUsers',document);
			res.write(JSON.stringify({result:false}));
			res.end();	
		}
	});
}
