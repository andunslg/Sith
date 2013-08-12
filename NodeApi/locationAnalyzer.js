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


exports.getAllCurrentEventMap=function(emotion, fn){

    var dbName='test';
    var tableName=emotion+'_table';

    var query='select * from '+tableName;

    mySQLConnector.getQueryResults("test",query,function(rows){

        var array = new Array();

        for(var i = 0; i < rows.length; i++){
            var object={};
            object.subid=rows[i].name;
            object.count= rows[i].count;
            object.lat=rows[i].lat;
            object.lo= rows[i].longi;
            object.location= rows[i].locationName;
            array.push(object);
        }

        fn(array);
    });

}

exports.getSelfMap=function(userID,emotion, fn){

    var dbName='test';
    var tableName='self_'+emotion+'_table';

    var query='select * from '+tableName+' where userID='+userID;

    mySQLConnector.getQueryResults("test",query,function(rows){

        var array = new Array();

        for(var i = 0; i < rows.length; i++){
            var object={};
            object.subid=rows[i].name;
            object.count= rows[i].count;
            object.lat=rows[i].lat;
            object.lo= rows[i].longi;
            object.location= rows[i].locationName;
            array.push(object);
        }

        fn(array);
    });

}


