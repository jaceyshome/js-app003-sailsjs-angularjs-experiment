var HelloController, assert, sinon;

HelloController = require('../../api/controllers/HelloController');

sinon = require('sinon');

assert = require('assert');

describe("The Hello Controller", function() {
  describe("when we invoke the index action", function() {
    it("should return hello world message", function() {
      var send;
      send = sinon.spy();
      HelloController.index(null, {
        send: send
      });
      assert(send.called);
      assert(send.calledWith("Hello World"));
    });
  });
});

//# sourceMappingURL=HelloController.spec.js.map
