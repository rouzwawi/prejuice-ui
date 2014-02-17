'use strict'

angular.module('prejuiceUiApp')
  .controller 'TestCtrl', ['$scope', '$location', 'User', 'Questions', 'API', 'Alert', ($scope, $location, User, Questions, API, Alert) ->
    
    $scope.testVar = 'sef'
    
    $scope.article = 2
    
    $scope.increase = ()->
      $scope.article = ($scope.article+1)%5
      
    $scope.decrease = ()->
      $scope.article = ($scope.article-1)%5
  ]
