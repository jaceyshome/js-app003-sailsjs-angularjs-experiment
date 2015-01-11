/**
 * Policy Mappings
 * (sails.config.policies)
 *
 * Policies are simple functions which run **before** your controllers.
 * You can apply one or more policies to a given controller, or protect
 * its actions individually.
 *
 * Any policy file (e.g. `api/policies/authenticated.js`) can be accessed
 * below by its filename, minus the extension, (e.g. "authenticated")
 *
 * For more information on how policies work, see:
 * http://sailsjs.org/#/documentation/concepts/Policies
 *
 * For more information on configuring policies, check out:
 * http://sailsjs.org/#/documentation/reference/sails.config/sails.config.policies.html
 */


module.exports.policies = {

  /***************************************************************************
  *                                                                          *
  * Default policy for all controllers and actions (`true` allows public     *
  * access)                                                                  *
  *                                                                          *
  ***************************************************************************/

  // '*': true,

  /***************************************************************************
  *                                                                          *
  * Here's an example of mapping some policies to run before a controller    *
  * and its actions                                                          *
  *                                                                          *
  ***************************************************************************/

  UserController : {
    '*': false,
    //-------------- socket -------------------
    'subscribe':true, //TODO subscribe to all users related to this company
    //------------------ views ----------------
    'list': true, //TODO is admin
    'details': true, //TODO is current user
    //------------------ actions --------------
    'edit': true, //TODO is current user
    'create': true,
    'all': true, //ToDO is admin
    'specify':true, //TODO is  current user
    'update': ['checkUserExistence'],
    'destroy': ['checkUserExistence']
  },

  ProjectController : {
    '*': false,
    //-------------- socket -------------------
    'subscribe':true,
    //------------------ views ----------------
    'new': true,
    'list': true,
    'details': true,
    //------------------ actions --------------
    'create': true,
    'all': true,
    'specify': true,
    'update': ['checkProjectExistence'],
    'destroy': ['checkProjectExistence']
  },

  StageController : {
    '*': false,
    //-------------- socket -------------------
    'subscribe':true,
    //------------------ views ----------------
    //------------------ actions --------------
    'create': true, //TODO authorization
    'all': ['checkProjectExistence'],
    'specify': true, //TODO authorization
    'update': ['checkStageExistence'],
    'destroy': ['checkStageExistence']
  },

  TaskController :{
    '*': false,
    //-------------- socket -------------------
    'subscribe':true,
    //------------------ views ----------------
    //------------------ actions --------------
    'create': true, //TODO authorization
    'all': ['checkProjectExistence','checkStageExistence'],
    'specify': true, //TODO authorization
    'update': ['checkTaskExistence'],
    'destroy': ['checkTaskExistence']
  }
};
