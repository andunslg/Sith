/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 8/5/13
 * Time: 3:08 PM
 * To change this template use File | Settings | File Templates.
 */

locationAnalyzer= require("../locationAnalyzer.js");

exports.getAverageLocationPerceptions=function(req,res){
    locationAnalyzer.getAllMap(req.query.emotion,req.query.timelevel,req.query.latmin,req.query.lngmin,req.query.latmax,req.query.lngmx,function(array){
        if(array){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

exports.getAllCurrentEventMap=function(req,res){
    locationAnalyzer.getAllCurrentEventMap(req.query.emotion,req.query.latmin,req.query.lngmin,req.query.latmax,req.query.lngmx,function(array){
        if(array){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

exports.getSelfMap=function(req,res){
    locationAnalyzer.getSelfMap(req.query.userID,req.query.emotion,function(array){
        if(array){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

exports.getEventMap=function(req,res){
    locationAnalyzer.getSelfMap(req.query.eventID,req.query.emotion,function(array){
        if(array){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

/**
 * Returns a numerical value for a location. Positive means people usually feels good here. Negative means people usually feels bad here.
 * @param req
 * @param res
 */
exports.getLocationValue=function(req,res){
    locationAnalyzer.getLocationPerception(req.query.lat,req.query.lng,function(value){
        if(value){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(value));
            res.end();
        }else{

        }
    });
}



