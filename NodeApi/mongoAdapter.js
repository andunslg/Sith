/**
 * @author Sachintha
 * This is the abstraction layer for mongodb. This contian all CRUD operations done to mongo db data
 */

var MongoClient = require('mongodb').MongoClient, Server = require('mongodb').Server, database;
var url = "mongodb://nodejitsu:818332f0d160e9026e3d99f63427bb04@alex.mongohq.com:10052/nodejitsudb3588429100";

MongoClient.connect(url, function(err, db) {
	if(err)
		throw err;
	console.log("Connected to Database");
	database = db;

});

exports.insertPerception = function(userID,eventID,perceptionVal) {
	var time = (new Date()).getTime();
	doc = { eventID: eventID, userID: userID, perceptionValue: perceptionVal, timeStamp: time };
	database.collection("Sith", function(err, collection) {
		collection.insert(doc, {safe : true}, function(err, records) {
			if(err)
				throw err;
			console.log("Record added as " + records[0]._id)
		});
	});
}
exports.getPerceptionForEvent = function(eventID){
	//code for filter based on events
}

exports.getPerceptionForUser = function(userID){
	//code for filter based on users
}
exports.getAllPerception = function(fn){
	//var count=0;
	if(!database){
		console.log(database);
		MongoClient.connect(url, function(err, db) {
			if(err)
				throw err;
			console.log("Connected to Database");
			db.collection("Sith", function(err,collection){
				collection.find({}).toArray(function(err,docs){
				if(err){throw err; return;}
				fn(docs);
			
				});
			});	
		});
	}else{
		database.collection("Sith", function(err,collection){
			collection.find({}).toArray(function(err,docs){
				if(err){throw err; return;}
				fn(docs);
			
			});
		});
	}
}
