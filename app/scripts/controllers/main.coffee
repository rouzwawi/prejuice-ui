'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', 'API', ($scope, API) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
    
    q = API.questions.get(
      questionId: 123
    , ()->
      console.log q
    )
  ]
