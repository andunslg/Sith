/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 7/19/13
 * Time: 3:52 PM
 * To change this template use File | Settings | File Templates.
 */
var cache = require('../cache');

exports.getCachedEvents = function(req,res){
    cache.getCachedEvents(req.query.eventID,function(err,docs){
         if(err){
             res.writeHead(404, {'Content-Type': 'application/json'});
             res.write(err.message);
             res.end();
         }else{
             res.writeHead(200, {'Content-Type': 'application/json'});
             res.write(JSON.stringify(docs));
             res.end();
         }
    });
}