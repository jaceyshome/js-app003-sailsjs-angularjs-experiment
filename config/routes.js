/**
 * Route Mappings
 * (sails.config.routes)
 *
 * Your routes map URLs to views and controllers.
 *
 * If Sails receives a URL that doesn't match any of the routes below,
 * it will check for matching files (images, scripts, stylesheets, etc.)
 * in your assets directory.  e.g. `http://localhost:1337/images/foo.jpg`
 * might match an image file: `/assets/images/foo.jpg`
 *
 * Finally, if those don't match either, the default 404 handler is triggered.
 * See `api/responses/notFound.js` to adjust your app's 404 logic.
 *
 * Note: Sails doesn't ACTUALLY serve stuff from `assets`-- the default Gruntfile in Sails copies
 * flat files from `assets` to `.tmp/public`.  This allows you to do things like compile LESS or
 * CoffeeScript for the front-end.
 *
 * For more information on configuring custom routes, check out:
 * http://sailsjs.org/#/documentation/concepts/Routes/RouteTargetSyntax.html
 */

module.exports.routes = {

  /***************************************************************************
  *                                                                          *
  * Make the view located at `views/homepage.ejs` (or `views/homepage.jade`, *
  * etc. depending on your default view engine) your home page.              *
  *                                                                          *
  * (Alternatively, remove this and add an `index.html` file in your         *
  * `assets` directory)                                                      *
  *                                                                          *
  ***************************************************************************/



  '/': {
    view: 'app'
  },
  //----------------- main ----------------------------
  '/login':{view:'app'},
  '/signup':{view:'app'},
  '/home':{view:'app'},

  //----------------- User -----------------------------
  //------------------- views --------------------------
  '/user':{view:'app'},
  '/user/details/:shortLink': 'UserController.details',
  //-------------------- actions------------------------
  '/user/edit/:shortLink':'UserController.edit',
  '/user/specifics/:shortLink': 'UserController.specifics',

  //------------------ Project -------------------------
  //-------------------- views -------------------------
  '/project':{view:'app'},
  '/project/details/:id/s/:shortLink': 'ProjectController.details',
  //--------------------- actions -----------------------
  '/project/specifics/:id/s/:shortLink': 'ProjectController.specifics',

  //-------------------- Stage ---------------------------
  //---------------------- actions -----------------------
  '/stage/specifics/:id/p/:idProject':'StageController.specifics',
  '/stage/all/p/:idProject/s/:shortLink':'StageController.all',

  //--------------------- Task ----------------------------
  '/task/specifics/:id/sg/:idStage/p/:idProject': 'TaskController.specifics',
  '/task/all/p/:idProject/s/:shortLink/sg/:idStage':'TaskController.all'
};
