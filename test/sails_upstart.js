var Sails;

Sails = require("Sails");

before(function(done) {
  return Sails.lift({
    log: {
      level: 'error'
    }
  }, function(err, sails) {
    var localAppURL, _ref;
    sails.localAppURL = localAppURL = ((_ref = sails.usingSSL) != null ? _ref : {
      'https': 'http'
    }) + '://' + sails.config.host + ':' + sails.config.port + '';
    return done(err);
  });
});

after(function() {
  return sails.lower(done);
});

describe('Users', function() {
  return describe('#list()');
});

//# sourceMappingURL=sails_upstart.js.map
