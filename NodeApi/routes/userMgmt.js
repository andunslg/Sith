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
    userManager.addUserToEvent(req.query.eventID,req.query.userID,req.query.status,function(error){
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

exports.removeUserFromEvent = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    userManager.removeUserFromEvent(req.query.userID,req.query.eventID,function(err){
          if(err){
              res.write(JSON.stringify({result:err.message}));
              res.end();
          }
        res.write(JSON.stringify({result:true}));
        res.end();
    });

};

exports.getUserById = function(req,res){
  userManager.getUserById(req.query.userID,function(docs){
      res.writeHead(200, {'Content-Type': 'application/json'});
      res.write(JSON.stringify(docs));
      res.end();
  });
};

exports.getSubscribedEvents = function(req,res){
    userManager.getSubscribedEvents(req.query.userID,function(docs){
        res.writeHead(200, {'Content-Type': 'application/json'});
        res.write(JSON.stringify(docs));
        res.end();
    });
}