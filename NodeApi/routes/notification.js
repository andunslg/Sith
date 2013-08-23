/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 8/19/13
 * Time: 10:14 PM
 * To change this template use File | Settings | File Templates.
 */
notificationManager = require("../notificationManager.js");

exports.getNotifications = function(req,res){
     notificationManager.getNotifications(req.query.type,req.query.status,req.query.userID, function(docs){
         res.writeHead(200, {'Content-Type': 'application/json'});
         var result = JSON.stringify(docs);
         res.write(result);
         res.end();
     });
}
