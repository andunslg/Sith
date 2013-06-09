/**
 * @author Sachintha
 */
userManager = require('../userManager');
exports.registerNewUser = function(req,res){
	//register new user by giving the information and email verification
};


exports.registerAnnonymousUser = function(req,res){
	//register new user by giving the information
	userManager.addAnnonymousUser(req,res);
	
};
exports.authenticateUser = function(req,res){
	userManager.authenticateUser(req,res);
};

exports.registerUserForEvent = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    userManager.addUserToEvent(req.query.eventID,req.query.userID,function(error){
         if(error){
             console.log(error);
             res.write(JSON.stringify({result:error.message}));
             res.end();
         }else{
             res.write(JSON.stringify({result:true}));
             res.end();
          }
    });
}

exports.removeUserFromEvent = function(eventID,userID){

};