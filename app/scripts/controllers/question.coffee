'use strict'

angular.module('prejuiceUiApp')
  .controller 'QuestionCtrl', ['$scope', '$location', 'User', 'API', 'Questions', 'Alert', ($scope, $location, User, API, Questions, Alert) ->
    
    ###
    saveCurrentQuestionAnswer = ()->
      if $scope.activeQuestion?
        answers[$scope.activeQuestion.id] = $scope.activeAnswerValue
    
    $scope.answerQuestion = ()->
      saveCurrentQuestionAnswer()
      showPostQuestion()
    ###
    
    $scope.activeAnswerValue = 0
    
    $scope.onQuestionSliderValueUpdated = (val)->
      $scope.$apply ()->
        if $scope.activeAnswerValue != val
          $scope.activeAnswerValue = val
                
    $scope.getActiveQuestion = ()->
      return Questions.getActiveQuestion()
      
    $scope.getActiveSubQuestion = ()->
      return Questions.getActiveSubQuestion()
      
    $scope.getQuestionState = ()->
      return Questions.getQuestionState()
    
    $scope.registerAnswerForActiveSubQuestion = ()->
      Questions.registerAnswerForActiveSubQuestion($scope.activeAnswerValue)
      
    $scope.nextQuestion = ()->
      Questions.nextQuestion()
  ]
