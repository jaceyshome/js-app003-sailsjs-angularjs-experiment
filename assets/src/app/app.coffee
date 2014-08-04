define [
  'angular'
  'angular_ui_router'
  'app/config'
  'bootstrap'
  'jquery'
  'common/csrf/csrf'
  'common/utility/utility'
  'common/message/message'
  'common/fieldmatch/fieldmatch'
  'common/navigation/navigation'
  'common/noteboard/noteboard'
  'common/sailssocket/sailssocket'
  'app/states/home/home-ctrl'
  'app/states/user/user-ctrl'
  'app/states/login/login-ctrl'
  'app/states/signup/signup-ctrl'
], ->
  module = angular.module 'app', [
    'ui.router'
    'common.navigation'
    'app.states.home'
    'app.states.user'
    'app.states.signup'
    'app.states.login'
    'common.fieldmatch.directive'
    'common.message.service'
    'common.noteboard'
    'common.sailssocket'
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/')

  module.controller 'MainCtrl', ($scope, $rootScope, $state, SailsSocket) ->
    #-------------------------------------------------------- public variables
    $scope.ready = true
    $scope.messages = []

    #-------------------------------------------------------private functions
    init = ->
      initSocketIO()
      registerEventListeners()

    initSocketIO = ->
      SailsSocket.init()
      .then (result)->
        registerSocketEventListeners()
      .catch ->
        handleErrorMsg({msg:"fail to connected to socketIO"})

    registerSocketEventListeners = ->
      SailsSocket.io.get('/user/subscribe')

    registerEventListeners = ->
      $scope.$on("ERR_MSG", (e, data)->
        handleErrorMsg(data)
      )

    clearMessages = ->
      if $scope.messages.length > 3
        $scope.messages.splice $scope.messages.length - 1, 1

    #-------------------------------------------------------- handlers
    handleErrorMsg = (data)->
      $scope.messages.push data
      console.log "handle errMsg", $scope.messages
      clearMessages()

    #--------------------------------------------------------- init()
    init()

  module
