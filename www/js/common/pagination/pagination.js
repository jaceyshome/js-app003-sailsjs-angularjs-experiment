define(['angular'], function() {
  var module;
  module = angular.module('common.pagination', ['templates']);
  return module.directive('tntPagination', function() {
    return {
      restrict: "A",
      scope: {
        index: "=",
        limit: "=",
        max: "=",
        pageLimit: "=?"
      },
      templateUrl: "common/pagination/main",
      link: function($scope, element, attrs) {
        var update;
        update = function() {
          var displayPages, first, i, last, page, pages, _i, _j, _ref, _ref1, _ref2;
          pages = [];
          for (i = _i = 0, _ref = $scope.max, _ref1 = $scope.limit; _ref1 > 0 ? _i <= _ref : _i >= _ref; i = _i += _ref1) {
            page = {
              index: pages.length,
              first: pages.length * $scope.limit,
              last: (pages.length * $scope.limit) + ($scope.limit - 1)
            };
            page.current = (page.first <= $scope.index) && (page.last >= $scope.index);
            if (page.current) {
              $scope.current = page;
            }
            pages.push(page);
          }
          $scope.pages = pages;
          $scope.lastPage = pages[pages.length - 1];
          if (pages.length <= $scope.pageLimit) {
            return $scope.displayPages = pages;
          } else {
            first = Math.round(($scope.index / $scope.limit) - ($scope.pageLimit / 2));
            if (first < 0) {
              first = 0;
            }
            if (first >= pages.length - $scope.pageLimit) {
              first = pages.length - $scope.pageLimit;
            } else {
              last = first + ($scope.pageLimit - 1);
            }
            displayPages = [];
            for (i = _j = first, _ref2 = first + ($scope.pageLimit - 1); first <= _ref2 ? _j <= _ref2 : _j >= _ref2; i = first <= _ref2 ? ++_j : --_j) {
              displayPages.push(pages[i]);
            }
            return $scope.displayPages = displayPages;
          }
        };
        $scope.$watch("index", update);
        $scope.$watch("limit", update);
        $scope.$watch("max", update);
        $scope.$watch("pageLimit", update);
        $scope.first = function() {
          return $scope.goPage($scope.pages[0]);
        };
        $scope.previous = function() {
          return $scope.goPage($scope.pages[$scope.current.index - 1]);
        };
        $scope.next = function() {
          return $scope.goPage($scope.pages[$scope.current.index + 1]);
        };
        $scope.last = function() {
          return $scope.goPage($scope.pages[$scope.pages.length - 1]);
        };
        $scope.goPage = function(page) {
          return $scope.index = page.first;
        };
        return $scope.pageLimit = 5;
      }
    };
  });
});

//# sourceMappingURL=pagination.js.map
