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
    var re = new RegExp(searchString);
    mongoAdapter.getDocuments({userName:re}, 'Users', function (docs) {
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