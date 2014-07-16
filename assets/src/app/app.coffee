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
  ]
  module.config ($locationProvider, $urlRouterProvider)->
    $locationProvider.html5Mode(true)
    $urlRouterProvider.otherwise('/login')

  module.controller 'MainCtrl', ($scope, $rootScope, $state) ->
    $scope.ready = true

    init = ->
      registerEventListeners()

    registerEventListeners = ->
      $scope.$on("ERR_MSG", (e, data)->
        handleErrorMsg(data)
      )

    handleErrorMsg = (data)->
      console.log "handle errMsg", data

    init()

  module
