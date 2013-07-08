/**
 * @author Sachintha
 */
var Db = require('mongodb').Db;
var Server = require('mongodb').Server;
var MongoClient = require('mongodb').MongoClient;
var config = require('./config');
var db1;
//var client = new Db('Sith', new Server('192.248.8.246', 27017, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false});
var mongoClient = new MongoClient(new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 6}));

mongoClient.open(function(err, mongoClient) {
    db1 = mongoClient.db(config.mongodb.database);
    console.log('connected to '+ db1.databaseName + ' on ' + mongoClient._db.serverConfig.host);

});
//insert a document to the specified collection
exports.insertDocument = function(collection,doc){
		db1.collection(collection, function(err, collection) {
			collection.insert(doc, {safe : true}, function(err, records) {
				if(err)
					throw err;
				console.log("Record added as " + records[0]._id);
			});
		});
};
//retireve the first object that matches the query
exports.getSingleDocument = function(query,collection,fn){
	Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
	if(err)
		throw err;
	else{
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
};

//retireve multiple documents that matches the given query
exports.getDocuments = function (query,collection,fn){
    //console.log("Connected to UoM server");
    db1.collection(collection, function(err, collection) {
        collection.find(query).toArray(function(err, doc) {
            if(err)
                throw err;
            fn(doc);
        });
    });
};

//get documents sorted ina order
exports.getSortedDocuments = function (query,collection,sortkey,fn){
    //console.log("Connected to UoM server");
    db1.collection(collection, function(err, collection) {
        collection.find(query).sort(sortkey).toArray(function(err, doc) {
            if(err)
                throw err;
            fn(doc);
        });
    });
};
//delete a specific document from a collection
exports.deleteDocument = function(collection,query,errorFunc){
    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        if(err)
            errorFunc(new Error(err.message));
        else{
            db.collection(collection, function(err, collection) {
                collection.remove(query,function(err, numberOfRemovedDocs) {
                    if(err)
                        errorFunc(new Error(err.message));
                    errorFunc(null);
                    db.close();
                });
            });
        }
    });
};
//retireve documents with projection of certain fields
exports.getProjection = function(collection,query,projection,fn){
    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        if(err)
            throw err;
        else{
            db.collection(collection, function(err, collection) {
                collection.findOne(query,projection,function(err, doc) {
                    if(err)
                        throw err;
                    fn(doc);
                    db.close();
                });
            });
        }
    });
};

//Dropping a specific collection
exports.dropCollection = function(name){
    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        db.dropCollection(name,function(err,collection){
            if(err)
                throw err;
            db.close();
        });
    });
}

exports.createCollection = function(name){
	Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
	db.createCollection(name,function(err,collection){
			if(err)
				throw err;
			db.close();
		});
	});
}
exports.updateSelectedFields = function(collection,selector,fieldSelector){
    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        db.collection(collection,function(err,collection){
            collection.update(selector,{$set:fieldSelector},function(err,result){
                if(err)
                    throw err;
                console.log('update Collection as'+result);
            });
        });
    });
}

exports.updateDocument = function(collection,selector,newDoc){
    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        db.collection(collection,function(err,collection){
          collection.update(selector,{$set:newDoc},function(err,result){
                 if(err)
                    throw err;
                  console.log('update Collection as'+result);
          });
        });
    });
}

exports.countDocuments = function(collection,fn){
    db1.collection(collection, function(err, collection) {
        collection.count(function(err,count){
            if(err)
                throw err;
            fn(count);
        });
    });
}
