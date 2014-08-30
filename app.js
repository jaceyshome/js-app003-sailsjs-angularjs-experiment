// Start sails and pass it command line arguments
require('coffee-script'); //<-add
require('./node_modules/sails/node_modules/coffee-script');  //<-add
require('sails').lift(require('optimist').argv);
