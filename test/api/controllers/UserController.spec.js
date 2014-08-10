var assert, request;

assert = require("assert");

request = require("supertest");

describe("User", function(done) {
  it("should be able to create a user", function(done) {
    User.create({
      name: "he232eaa12321",
      email: "a@b.c",
      password: 'asdasdasd'
    }, function(err, user) {
      assert.notEqual(user, undefined);
      done();
    });
  });
});

//# sourceMappingURL=UserController.spec.js.map
