'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'Questions', 'API', 'Alert', ($scope, $location, User, Questions, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.quizState = 'ready'
    
    $scope.$on 'GOT_QUESTIONS', ()->
        $scope.quizReadyToStart = true
    
    $scope.$on 'QUIZ_DONE', ()->
        $scope.quizState = 'completed'
    
    $scope.startQuiz = ()->
      $scope.quizState = 'running'
    
    $scope.showResult = ()->
      $location.path('result/' + User.getUserToken());
    
  ]
