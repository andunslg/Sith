/**
 * @author Sachintha
 */
userManager = require('../userManager');
exports.registerNewUser = function(req,res){
	//register new user by giving the information
};

exports.registerAnnonymousUser = function(req,res){
	//register new user by giving the information
	userManager.addAnnonymousUser(req,res);
	
};
exports.authenticateUser = function(req,res){
	userManager.authenticateUser(req,res);
};
