/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 8/6/13
 * Time: 2:19 PM
 * To change this template use File | Settings | File Templates.
 */
eventManager=require('./eventManager.js');
mySQLConnector=require('./mySQLConnector.js');

exports.getAllMap=function(emotion,timeRange, fn){

    var dbName='test';
    var tableName='z'+timeRange+emotion;

    var query='select * from '+tableName;

    mySQLConnector.getQueryResults("test",query,function(rows){

        var array = new Array();

        for(var i = 0; i < rows.length; i++){
            var object={};
            object.lat=rows[i].la;
            object.lo= rows[i].lo;
            object.count=rows[i].count;
            array.push(object);

        }

        fn(array);
    });



}
