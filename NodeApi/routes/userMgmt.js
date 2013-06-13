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

exports.registerFBUser = function(){
    res.writeHead(200, {
        'Content-Type' : 'application/json',
        'Cache-Control' : 'no-cache',
        'Connection' : 'keep-alive'
    });
    userManager.addFBUser(req.body.userName,req.body.token);
    res.write(JSON.stringify({result:true}));
    res.end();
};
exports.authenticateUser = function(req,res){
	userManager.authenticateUser(req,res);
};

exports.updateAnnonymousUser = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
     userManager.updateAnnonymousUser(req.body.oldUserName,req.body.userName,req.body.password,function(result){
         if(result){
             res.write(JSON.stringify({result:true}));
         }else{
             res.write(JSON.stringify({result:false}));
         }
            res.end();
     });
}

exports.deleteUser = function(req,res){
    res.writeHead(200, {'Content-Type': 'application/json'});
    userManager.deleteUser(req.body.userName,function(error){
        if(!error){
            res.write(JSON.stringify({result:true}));
        }else{
            res.write(JSON.stringify({result:false}));
        }
        res.end();
    })
}
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