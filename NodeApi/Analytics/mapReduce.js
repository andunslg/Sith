/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 6/24/13
 * Time: 12:16 PM
 * To change this template use File | Settings | File Templates.
 */
var Db = require('mongodb').Db;
var Server = require('mongodb').Server;
var config = require('../config.js');
//var MongoClient = require('mongodb').MongoClient;

exports.aggregateLocationSelfData = function(collection,perception,fn){
    var map = function() {
        roundlat = this.latLng.lat.toFixed(4);
        roundlng = this.latLng.lng.toFixed(4);
        emit(
            {lat: roundlat, lng: roundlng},					// how to group
            {count: 1}	// associated data point (document)
        );
    };

    var reduce = function(key,values) {
        var reduced = {key:key,count:0}; // initialize a doc (same format as emitted value)

        values.forEach(function(val) {
            // reduce logic
            reduced.count += val.count;
        });

        return reduced;
    };

    Db(config.mongodb.database, new Server(config.mongodb.host, config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        if(err)
            throw err;
        else{
            db.collection(collection, function(err, collection) {
                if(err)
                    throw err;
                collection.mapReduce(map,reduce,{out : {inline: 1}, query:{perceptionValue:perception},verbose:true},function(err, results, stats){
                    if(err)
                        throw err;
                    fn(results);
                });
            });
        }
    });
}
exports.categorize = function(collection,fn){
    var start = new Date().getTime();
    // Map function
    var map = function() {
                            emit(
                            this.perceptionValue,					// how to group
                            {count: 1}	// associated data point (document)
                         );
    };
    // Reduce function
    var reduce = function(key,values) {
        var reduced = {key:key,count:0}; // initialize a doc (same format as emitted value)

        values.forEach(function(val) {
            // reduce logic
            reduced.count += val.count;
        });

        return reduced;
    };

    Db(config.mongodb.database, new Server(config.mongodb.host,config.mongodb.port, {auto_reconnect: false, poolSize: 4}), {w:0, native_parser: false}).open(function(err,db){
        if(err)
            throw err;
        else{
            db.collection(collection, function(err, collection) {
                if(err)
                    throw err;
                collection.mapReduce(map,reduce,{out : {inline: 1}, verbose:true},function(err, results, stats){
                    if(err)
                        throw err;
                    var end = new Date().getTime();
                    var time = end - start;
                    console.log('Execution time post perception categorization algo ' + time);
                    fn(results);
                });
            });
        }
    });
}