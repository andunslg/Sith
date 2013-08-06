/**
 * Created with IntelliJ IDEA.
 * User: Sachintha
 * Date: 7/12/13
 * Time: 9:51 PM
 * To change this template use File | Settings | File Templates.
 */
var passport = require('passport')
    ,LocalStrategy = require('passport-local').Strategy

/**
 * LocalStrategy
 *
 * This strategy is used to authenticate users based on a username and password.
 * Anytime a request is made to authorize an application, we must ensure that
 * a user is logged in before asking them to approve the request.
 */
passport.use(new LocalStrategy(
    function(username, password, done) {
        db.users.findByUsername(username, function(err, user) {
            if (err) { return done(err); }
            if (!user) { return done(null, false); }
            if (user.password != password) { return done(null, false); }
            return done(null, user);
        });
    }
));

/*
 passport.use(new BearerStrategy(
 function(token, done) {
 User.findOne({ token: token }, function (err, user) {
 if (err) { return done(err); }
 if (!user) { return done(null, false); }
 return done(null, user, { scope: 'read' });
 });
 }
 ));
 */