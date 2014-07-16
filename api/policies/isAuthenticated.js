/**
 * isAuthenticated
 *
 * @module      :: Policy
 * @description :: Simple policy to allow any authenticated user
 *                 Assumes that your login action in one of your controllers sets `req.session.authenticated = true;`
 * @docs        :: http://sailsjs.org/#!documentation/policies
 *
 */
module.exports = function(req, res, next) {

  // User is allowed, proceed to the next policy, 
  // or if this is the last policy, the controller
  if (req.session.authenticated) {
    console.log("authenticated is true");
    return next();
  }
  else{
    console.log("need to login");
    res.redirect('/signin');
  }
  // User is not allowed
  // (default res.forbidden() behavior can be overridden in `config/403.js`)
};
