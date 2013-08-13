/**
 * Created with IntelliJ IDEA.
 * User: prabhath
 * Date: 8/5/13
 * Time: 3:08 PM
 * To change this template use File | Settings | File Templates.
 */

locationAnalyzer= require("../locationAnalyzer.js");

exports.getAverageLocationPerceptions=function(req,res){
    locationAnalyzer.getAllMap(req.query.emotion,req.query.timelevel,function(array){
        if(array){
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

exports.getAllCurrentEventMap=function(req,res){
    locationAnalyzer.getAllCurrentEventMap(req.query.emotion,function(array){
        if(array){
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}

exports.getSelfMap=function(req,res){
    locationAnalyzer.getSelfMap(req.query.userID,req.query.emotion,function(array){
        if(array){
            res.write(JSON.stringify(array));
            res.end();
        }else{

        }
    });
}