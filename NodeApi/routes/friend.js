/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 8/21/13
 * Time: 4:37 PM
 * To change this template use File | Settings | File Templates.
 */

friendManager=require("../friendMngmnt.js");


exports.getAllfriends=function(req,res){
   friendManager.getAllFriends(req.query.userID,function(doc){
       if(doc){
           res.write(JSON.stringify(doc));
           res.end();
       }else{

       }
   });
}

exports.searchFriendsToAdd=function(req,res){
    friendManager.searchFriendsToAdd(req.query.userID,req.query.query,function(doc){
        if(doc){
            res.write(JSON.stringify(doc));
            res.end();
        }else{

        }
    });
}

exports.addFriend=function(req,res){

}

exports.removeFriend=function(req,res){
    friendManager.removeFriend(req.query.userID,req.query.friendID);
    res.writeHead(200, {'Content-Type': 'application/json'});
    var result = JSON.stringify({response: true });
    res.write(result);
    res.end();
}