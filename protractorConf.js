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
//  framework: 'jasmine',
//
//  // ----- Options to be passed to minijasminenode -----
//  //
//  // See the full list at https://github.com/juliemr/minijasminenode
//  jasmineNodeOpts: {
//    // onComplete will be called just before the driver quits.
//    onComplete: null,
//    // If true, display spec names.
//    isVerbose: false,
//    // If true, print colors to the terminal.
//    showColors: true,
//    // If true, include stack traces in failures.
//    includeStackTrace: true,
//    // Default time to wait in ms before a test fails.
//    defaultTimeoutInterval: 30000
//  }
};