/**
 * Created with IntelliJ IDEA.
 * User: Prabhath
 * Date: 8/21/13
 * Time: 4:44 PM
 * To change this template use File | Settings | File Templates.
 */


exports.getAllFriends=function(userID,fn){
    mongoAdapter.getDocuments({}, 'UserFriends_'+userID, function (doc) {
        fn(doc);
    });
}

exports.searchFriendsToAdd=function(userID,searchString,fn){
    var regex = new RegExp(searchString);
    mongoAdapter.getProjection('Users',{userName:regex},{password:0,_id:0}, function (docs) {
        mongoAdapter.getDocuments({$or:[{type:"friendRequest"},{type:"requestAccepted"},{type: "friendRequestToOther"}]},'UserNotifications_'+userID,function(notifs){
                for(i=0;i<docs.length;i++){
                    //remove the self data from the suggesions
                    if(docs[i].userName == userID){
                        docs.splice(i,1);
                        i--;
                        continue;
                    }
                    //annotate the suggested list
                    for(j=0;j<notifs.length;j++){
                        if(docs[i].userName==notifs[j].sender){
                            if(notifs[j].status == "pending" && notifs[j].type== "friendRequest"){docs[i].type = "pendingRequest";}
                            else if((notifs[j].status == "friended" && notifs[j].type== "friendRequest") ||notifs[j].type == "requestAccepted"){docs[i].type = "friend";}
                            else if(notifs[j].type== "friendRequestToOther"){docs[i].type = "requestSent"}
                        }
                    }
                }
            fn(docs);
        });

    });
}

exports.getUserNews = function(userID,fn){
     var news = [];
     mongoAdapter.getDocuments({},'UserFriends_'+userID,function(friends){
        var j=0;
        friends.forEach(function(friend){
            mongoAdapter.getDocuments({},'UserPerceptions_'+friend.userName,function(perceps){
                var latestPercep = perceps[perceps.length-1];
                if(latestPercep){
                news.push({friendName:friend.userName,perception:latestPercep.perceptionValue,event:latestPercep.eventID});
                }
                j++;
                if(j==friends.length){fn(news)}
            });
        });
         if(friends.length ==0){
             fn([])
         }
     });
 }
exports.addFriend=function(userID,friendID){

}

exports.removeFriend=function(userID,friendID){
    mongoAdapter.deleteDocument('UserFriends_'+userID, {userName:friendID},function(err){
        if(err)
            console.log(err.message);
    });
    mongoAdapter.deleteDocument('UserFriends_'+friendID, {userName:userID},function(err){
        if(err)
            console.log(err.message);
    });
    mongoAdapter.deleteDocument('UserNotifications_'+userID, {sender:friendID,$or: [ { type:"friendRequest"}, {type: "requestAccepted"} ]},function(err){
        if(err)
            console.log(err.message);
    });
    mongoAdapter.deleteDocument('UserNotifications_'+friendID, {sender:userID,$or: [ { type:"friendRequest"}, {type: "requestAccepted"} ]},function(err){
        if(err)
            console.log(err.message);
    });
}