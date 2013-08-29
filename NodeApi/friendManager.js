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
        fn(docs);
    });
}

exports.addFriend=function(userID,friendID){

}

exports.removeFriend=function(userID,friendID){
    mongoAdapter.deleteDocument('UserFriends_'+userID, {userName:friendID},function(err){
        if(err)
            console.log(err.message);
    });
}