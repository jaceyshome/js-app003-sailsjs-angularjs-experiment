exports.config = {
  seleniumAddress: 'http://localhost:4444/wd/hub',
  baseUrl: 'http://localhost:1337',
  capabilities: {
    'browserName': 'chrome'
  }
};