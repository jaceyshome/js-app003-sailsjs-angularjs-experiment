Sails = require "Sails"

#global before
before((done)->
  Sails.lift({
      log:{
        level: 'error'
      }
    },(err, sails)->
    sails.localAppURL = localAppURL = ( sails.usingSSL ? 'https' : 'http' ) + '://' + sails.config.host + ':' + sails.config.port + ''
    done(err)
  )
)

after(()->
  sails.lower(done)
)

describe('Users', ()->
  describe('#list()')
)