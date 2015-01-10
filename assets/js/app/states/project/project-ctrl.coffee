define [
  'app/states/project/project-module'
  'app/states/project/project-service'
  'app/states/project/list/list-ctrl'
  'app/states/project/new/new-ctrl'
  'app/states/project/details/details-ctrl'
], ->
  module = angular.module 'app.states.project'
  module.controller 'ProjectCtrl', ($scope, $state) ->
    