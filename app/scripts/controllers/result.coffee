'use strict'

angular.module('prejuiceUiApp')
  .controller 'ResultCtrl', ['$scope', '$routeParams', 'API', 'Alert', ($scope, $routeParams, API, Alert) ->
    
    $scope.score = 16
    
    userToken = $routeParams.userToken
    
    answers = API.answers.get
      id: userToken
    , (res)->
      $scope.answers = answers.answers
      console.log $scope.answers
    , (err)->
      Alert.add 'error', 'Could not get answers (' + err.status + ')'
  ]
