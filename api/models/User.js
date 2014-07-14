/**
 * User
 *
 * @module      :: Model
 * @description :: A short summary of how this model works and what it represents.
 * @docs		:: http://sailsjs.org/#!documentation/models
 */

module.exports = {
  tableName: 'bd_user', //point to tableName
  migrate: 'safe',
  attributes: {
    name:{type:'string', required:true, maxLength: 100},
    email:{type:'string', email:true, required:true, maxLength: 100},
    password:{type:'string', required:true, maxLength: 256}
//    toJSON: function(){
//      var obj = this.toObject();
//      delete obj.encryptedPassword;
//      delete obj.confirmation;
//      delete obj._csrf;
//      return obj;
//    }
  }
};
