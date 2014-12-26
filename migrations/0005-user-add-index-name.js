
var mongodb = require('mongodb');

exports.up = function(db, next){
  var user = mongodb.Collection(db, 'user');
  user.ensureIndex( { "name": 1 }, { unique: true }, function(err, indexName) {
    if(err){
      return err
    }
    next();
  });
};

exports.down = function(db, next){
  next();
};
