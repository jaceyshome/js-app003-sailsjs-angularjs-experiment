define [
  "should"
  "angular_mocks"
  "common/structure/main"
  ], ()->
  describe 'service', ()->
    beforeEach angular.mock.module "common.structure"
    describe "structure", ->
      it 'should have a structure service', inject (Structure)->
        (Structure).should.not.equal null
      it 'should have a load function', inject (Structure)->
        (Structure.load).should.not.equal null
      ###
      it 'should retreive structure data', (done)->
        inject (Structure)->
          Structure.load().then (data)->
            console.log "data", data
            done()
      ###