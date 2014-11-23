var Promise;

Promise = require('bluebird');

module.exports = {
  get: function(request, reqApp) {
    return new Promise(function(resolve, reject) {
      return request(reqApp).get('/csrfToken').expect(200).end(function(err, res) {
        if (err) {
          reject();
        }
        return resolve(res);
      });
    });
  }
};

//# sourceMappingURL=csrf.js.map
