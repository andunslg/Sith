/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 8/6/13
 * Time: 2:19 PM
 * To change this template use File | Settings | File Templates.
 */
eventManager=require('./eventManager.js');
mySQLConnector=require('./mySQLConnector.js');
mapReduceAnalyzer=require('./Analytics/mapReduce.js')

exports.getAllMap=function(emotion,timeRange,latmin,lngmin,latmax,lngmx,fn){
    emotion=emotion+'';
    emotion=emotion.toLowerCase();


    var dbName='test';
    var tableName='z'+timeRange+emotion;

    var query='select * from '+tableName+' where la<='+latmax+' and la>='+latmin+' and lo>='+lngmin+' and lo<='+lngmx;

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


exports.getAllCurrentEventMap=function(emotion,latmin,lngmin,latmax,lngmx, fn){

    emotion=emotion+'';
    emotion=emotion.toLowerCase();

    var dbName='test';
    var tableName=emotion+'_table';

    var query='select * from '+tableName+' where lat<='+latmax+' and lat>='+latmin+' and longi>='+lngmin+' and longi<='+lngmx;

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

    var tableName='UserPerceptions_'+userID;

    mapReduceAnalyzer.aggregateLocationSelfData(tableName,emotion,function(objects){

        var array = new Array();

        for(var i = 0; i < objects.length; i++){
            var object={};
            object.lat=objects[i]._id.lat;
            object.lo= objects[i]._id.lng;
            object.count= objects[i].value.count;
            array.push(object);
        }

        fn(array);
    });

}

exports.getEventMap=function(eventID,emotion,fn){

    var tableName='EventPerceptions_'+eventID;

    mapReduceAnalyzer.aggregateLocationSelfData(tableName,emotion,function(objects){

        var array = new Array();

        for(var i = 0; i < objects.length; i++){
            var object={};
            object.lat=objects[i]._id.lat;
            object.lo= objects[i]._id.lng;
            object.count= objects[i].value.count;
            array.push(object);
        }

        fn(array);
    });

}


exports.getLocationPerception=function(lat,longi,fn){

    //TODO implement
    var temp=new Object();
    temp.rating= Math.floor((Math.random()*10)+1);
    fn(temp);
}

