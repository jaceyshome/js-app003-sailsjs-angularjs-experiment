/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {
  schema: true, //schema only save the attributes define below, will show others away
  //TODO encrypted password
  attributes: {
    name:{type:'string', required:true},
    email:{type:'string', email:true, required:true},
    password:{type:'string', required:true}
//    toJSON: function(){
//      var obj = this.toObject();
//      delete obj.encryptedPassword;
//      delete obj.confirmation;
//      delete obj._csrf;
//      return obj;
//    }
  }
};
