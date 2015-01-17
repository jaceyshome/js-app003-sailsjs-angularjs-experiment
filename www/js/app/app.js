define(['jquery', 'angular', 'angular_sails', 'angular_ui_router', 'angular_ui_tree', 'angular_material', 'app/config', 'app/app-service', 'app/states/project/project-service', 'app/states/stage/stage-service', 'app/states/task/task-service', 'common/constants/constants', 'common/csrf/csrf', 'common/clickbtn/clickbtn', 'common/utility/utility', 'common/message/message', 'common/fieldmatch/fieldmatch', 'common/navigation/navigation', 'common/validation/validation', 'common/panelslist/panelslist', 'app/states/home/home-ctrl', 'app/states/user/user-ctrl', 'app/states/project/project-ctrl', 'app/states/login/login-ctrl', 'app/states/signup/signup-ctrl'], function() {
  var module;
  module = angular.module('app', ['ui.router', 'ui.tree', 'sails.io', 'ngAnimate', 'app.service', 'common.message.service', 'app.states.project.service', 'app.states.stage.service', 'app.states.task.service', 'common.csrf', 'common.constants', 'common.panelslist', 'common.clickbtn', 'common.utility', 'common.navigation', 'common.validation', 'common.fieldmatch', 'app.states.home', 'app.states.user', 'app.states.signup', 'app.states.login', 'app.states.project']);
  module.config(function($locationProvider, $urlRouterProvider) {
    $locationProvider.html5Mode(true);
    return $urlRouterProvider.otherwise('/');
  });
  module.controller('MainCtrl', function($scope, $rootScope, $state) {
    var init;
    $scope.ready = true;
    $scope.messages = [];
    $scope.toastOptions = {
      "close-button": true,
      "debug": false,
      "position-class": "toast-top-right",
      "onclick": null,
      "time-out": 3000,
      "extendedTimeOut": 1000,
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut"
    };
    init = function() {};
    return init();
  });
  return module;
});

//# sourceMappingURL=app.js.map
