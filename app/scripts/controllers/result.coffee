'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', ($scope, $routeParams) ->
    $scope.userId = $routeParams.userId;
    $scope.score = 16
  ]
