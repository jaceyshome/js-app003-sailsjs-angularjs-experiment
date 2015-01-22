define(['angular', 'angular_resource', 'app/config'], function(angular, angular_resource, config) {
  var module;
  module = angular.module('common.navigation', ['common.csrf']);
  return module.directive('tntNavigation', function($http, $state, CSRF, Utility, ProjectService) {
    return {
      restrict: "A",
      scope: {},
      templateUrl: "common/navigation/navigation",
      link: function($scope, element, attrs) {
        var goToProject, handleCreatingProjectAfter, init, reset;
        $scope.projects = null;
        $scope.dropDownSettings = {
          data: null
        };
        $scope.newProjectSettings = {
          data: {
            name: ''
          },
          visible: false
        };
        init = function() {
          return ProjectService.fetchProjects().then(function(results) {
            return $scope.projects = results;
          });
        };
        handleCreatingProjectAfter = function(project) {
          return goToProject(project);
        };
        reset = function() {
          $scope.dropDownSettings = {
            data: null
          };
          return $scope.newProjectSettings = {
            data: {
              name: ''
            },
            visible: false
          };
        };
        goToProject = function(project) {
          reset();
          $state.go('project.details', {
            id: project.id,
            shortLink: project.shortLink
          });
        };
        $scope.toggleProjectsList = function(e) {
          if (!$scope.projects) {
            return;
          }
          if ($scope.dropDownSettings.data === $scope.projects) {
            $scope.dropDownSettings.data = null;
          } else {
            $scope.dropDownSettings.data = $scope.projects;
          }
          return $scope.dropDownSettings.visible = $scope.dropdownItems !== null;
        };
        $scope.selectItem = goToProject;
        $scope.toggleNewProjectPanel = function(e) {
          return $scope.newProjectSettings.visible = !$scope.newProjectSettings.visible;
        };
        $scope.createProject = function() {
          return ProjectService.createProject($scope.newProjectSettings.data).then(function(result) {
            if (result) {
              return handleCreatingProjectAfter(result);
            }
          });
        };
        $scope.logout = function() {
          return CSRF.get().then(function(data) {
            return $http.post("" + config.baseUrl + "/session/destroy", {
              _csrf: data._csrf
            }).then(function(result) {
              return $state.go("login");
            })["catch"](function(err) {
              return console.log("log out fail");
            });
          });
        };
        return init();
      }
    };
  });
});

//# sourceMappingURL=navigation.js.map
