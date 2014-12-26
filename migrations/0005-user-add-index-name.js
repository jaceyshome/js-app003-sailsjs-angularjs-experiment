
var mongodb = require('mongodb');

exports.up = function(db, next){
  mongodb.Collection(db, 'user').ensureIndex(
    { "name": 1 },
    { unique: true },
    function(err, indexName) {
      if(err){
        return err;
      }
      next();
    });
};

exports.down = function(db, next){
  next();
};
