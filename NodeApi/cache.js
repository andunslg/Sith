/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 7/19/13
 * Time: 11:05 AM
 * To change this template use File | Settings | File Templates.
 */
var cache = require('memory-cache');

/*
loadEventsToTheCache = {
    mongoAdapter.getDocuments({}, 'EventDetails', function (docs) {
        for (var i = 0; i < docs.length; i++) {
          cache.put(docs[i].eventID,docs[i]);
        }
    });
}
*/
exports.getCachedEvents = function(eventID,fn){
   if(cache.get(eventID)){
     console.log("reading from cache");
     fn(null,cache.get(eventID));
   }else{
        mongoAdapter.getSingleDocument({eventID:eventID},'EventDetails',function(docs){
            if(docs){
                cache.put(eventID,docs);
                console.log("reading from db");
                fn(null,docs);
            }else{
                fn(new Error('Not Found'),null);
            }
        });
    }
}

exports.getCachedTokens = function(token){

}