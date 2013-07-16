/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 7/14/13
 * Time: 11:20 PM
 * To change this template use File | Settings | File Templates.
 */


var MySQLRootURL ="jdbc:mysql://localhost:3306/?user=root&password=root";
var MySQLDomain ="localhost";

var MySQLRootPassword="root";

var mysql = require('mysql');

var client = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: 'root',
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

