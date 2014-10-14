var HtmlReporter = require('protractor-html-screenshot-reporter');
exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  baseUrl: 'http://localhost:1337',
  capabilities: {
    'browserName': 'chrome'
  },
  onPrepare: function() {
    jasmine.getEnv().addReporter(new HtmlReporter({
      baseDirectory: '.tmp/screenshots'
    }));
  }
};