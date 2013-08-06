/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 7/14/13
 * Time: 11:20 PM
 * To change this template use File | Settings | File Templates.
 */


var MySQLRootURL ="jdbc:mysql://192.248.8.246:3306/test?user=sithuser&password=mysqlsith2";
var MySQLDomain ="192.248.8.246";

var MySQLRootPassword="mysqlsith2";

var mysql = require('mysql');

var client = mysql.createConnection({
    host: '192.248.8.246',
    user: 'sithuser',
    password: 'mysqlsith2',
    port: 3306
});

exports.createMySQLDB=function(userID,password){
    var dbName= userID+"_result_db";
    // create database
    client.query('CREATE DATABASE '+dbName, function(err) {
        if (err) { console.log(err); }
    });

    client.query('USE '+dbName);

    client.query("GRANT ALL PRIVILEGES ON "+dbName+".* To '"+userID+"'@'"+MySQLDomain +"' IDENTIFIED BY '"+password+"';");
}


exports.getQueryResults=function(dbName,query,fn){
    client.query('USE '+dbName);
    client.query(query, function(err, rows, fields) {
        if (err) {
            console.log('Error ocuured',err);
        };
        fn(rows);

    });
}

exports.getEventPerceptionCurrent =function(){
    var currentEvents=eventManager.getLiveEvents();

}

exports.createUserTable=function(){

}


