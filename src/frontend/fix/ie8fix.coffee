requirejs.config
  waitSeconds: 200
  urlArgs: "bust=" + (new Date()).getTime()
  paths:
    es5_shim:"../../lib/es5-shim/es5-shim"
define [
  'es5_shim'
  ], ->