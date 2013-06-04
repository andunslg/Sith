/**
 * @author Sachintha
 */
var Db = require('mongodb').Db;
var Server = require('mongodb').Server;
//var client = new Db('Sith', new Server('192.248.8.246', 27017, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false});

//insert a document to the specified collection
exports.insertDocument = function(collection,doc){
	new Db('Sith', new Server('192.248.8.246', 27017, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
	if(err)
		throw err;
	else{
		console.log("Connected to UoM server");
		db.collection(collection, function(err, collection) {
			collection.insert(doc, {safe : true}, function(err, records) {
				if(err)
					throw err;
				console.log("Record added as " + records[0]._id);
				db.close();
			});
		});	
	}		
	});
}
//retireve the first object that matches the query
exports.getSingleDocument = function(query,collection,fn){
	Db('Sith', new Server('192.248.8.246', 27017, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
	if(err)
		throw err;
	else{
		console.log("Connected to UoM server");
		db.collection(collection, function(err, collection) {
			collection.findOne(query,function(err, doc) {
				if(err)
					throw err;
					fn(doc);
				db.close();
			});
		});	
	}		
	});
}

//retireve multiple documents that matches the given query
exports.getDocuments = function(query,collection,fn){
	Db('Sith', new Server('192.248.8.246', 27017, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
	if(err)
		throw err;
	else{
		console.log("Connected to UoM server");
		db.collection(collection, function(err, collection) {
			collection.find(query).toArray(function(err, doc) {
				if(err)
					throw err;
					fn(doc);
				db.close();
			});
		});	
	}		
	});
}