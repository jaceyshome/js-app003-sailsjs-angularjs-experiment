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
  'common/sailssocket/sailssocket'
  'common/validation/validation'
  'app/states/home/home-ctrl'
  'app/states/user/user-ctrl'
  'app/states/login/login-ctrl'
  'app/states/signup/signup-ctrl'
], ->
  module = angular.module 'app', [
    'ui.router'
    'ngAnimate'
    'common.navigation'
    'app.states.home'
    'app.states.user'
    'app.states.signup'
    'app.states.login'
    'common.fieldmatch.directive'
    'common.message.service'
    'common.sailssocket'
    'common.validation'
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/')

  module.controller 'MainCtrl', ($scope, $rootScope, $state, SailsSocket, MessageService) ->
    $scope.ready = true
    $scope.messages = []
    #toaster show duration and hide duration is set on global.less
    $scope.toastOptions =
      "close-button": true
      "debug": false
      "position-class": "toast-top-right"
      "onclick": null
      "time-out": 3000
      "extendedTimeOut": 1000
      "showEasing": "swing"
      "hideEasing": "linear"
      "showMethod": "fadeIn"
      "hideMethod": "fadeOut"

    init = ->
      initSocketIO()
      registerEventListeners()

    initSocketIO = ->
      SailsSocket.init()
      .then (result)->
        registerSocketEventListeners()
      .catch ->
        MessageService.showError("fail to connected to socketIO")

    registerSocketEventListeners = ->
      SailsSocket.io.get('/user/subscribe')

    registerEventListeners = ->
      undefined

    init()

  module
