/**
 * @author Sachintha
 */
var config = {};
config.mysql = {};
config.mongodb = {};

//configuration for mysql database
config.mysql.host = 'localhost';
config.mysql.username = 'root';
config.mysql.password = '';

//configurations for mongodb
/*
config.mongodb.host = 'alex.mongohq.com';
config.mongodb.username = 'nodejitsu';
config.mongodb.pwd = '818332f0d160e9026e3d99f63427bb04';
config.mongodb.port = '10052';
config.mongodb.database = 'nodejitsudb3588429100';
*/
config.mongodb.host = '192.248.15.233';
config.mongodb.username = '';
config.mongodb.pwd = '';
config.mongodb.port = '27017';
config.mongodb.database = 'Sith';

module.exports = config;