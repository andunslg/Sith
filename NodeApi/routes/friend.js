/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 8/21/13
 * Time: 4:37 PM
 * To change this template use File | Settings | File Templates.
 */

friendManager=require("../friendManager.js");


exports.getAllfriends=function(req,res){
   friendManager.getAllFriends(req.query.userID,function(doc){
       if(doc){
           res.writeHead(200, {'Content-Type': 'application/json'});
           res.write(JSON.stringify(doc));
           res.end();
       }else{

       }
   });
}

exports.searchFriendsToAdd=function(req,res){
    friendManager.searchFriendsToAdd(req.query.userID,req.query.query,function(doc){
        if(doc){
            res.writeHead(200, {'Content-Type': 'application/json'});
            res.write(JSON.stringify(doc));
            res.end();
        }else{

        }
    });
}

exports.addFriend = function(req,res){

}

exports.getUserNews = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    friendManager.getUserNews(req.body.userID,function(news){
        var result = JSON.stringify(news);
        res.write(result);
        res.end();
    });
}
exports.removeFriend=function(req,res){
    friendManager.removeFriend(req.body.userID,req.body.friendID);
    res.writeHead(200, {'Content-Type': 'application/json'});
    var result = JSON.stringify({response: true });
    res.write(result);
    res.end();
}