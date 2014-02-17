'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'Questions', 'API', 'Alert', ($scope, $location, User, Questions, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.quizState = 'ready'
    
    $scope.steps = []
    $scope.activeStepIndex = 0
    $scope.activeStep = null
    
    $scope.activeAnswerValue = 0
    
    $scope.onQuestionSliderValueUpdated = (val)->
      $scope.$apply ()->
        if $scope.activeAnswerValue != val
          $scope.activeAnswerValue = val
    
    $scope.$on 'GOT_QUESTIONS', ()->
      steps = []
      
      for question in Questions.getQuestions()
        #question intro
        steps.push
          type: 'questionIntro'
          introText: question.introText
          category: question.questionCategory
          source: question.source
        
        #sub questions
        for subQuestion in question.subQuestions
          steps.push
            type: 'subQuestion'
            question: subQuestion.question
            minRange: subQuestion.minRange
            maxRange: subQuestion.maxRange
            answer: subQuestion.answer
            rangeUnit: subQuestion.rangeUnit
      
        #question outro
        steps.push
          type: 'questionOutro'
          category: question.questionCategory
          source: question.source
      
      console.log steps
      $scope.steps = steps
      $scope.activeStepIndex = -1
      $scope.nextStep()
      $scope.quizReadyToStart = true
    
    $scope.$on 'QUIZ_DONE', ()->
        $scope.quizState = 'completed'
    
    $scope.startQuiz = ()->
      $scope.quizState = 'running'
      
    $scope.nextStep = ()->
      if $scope.activeStep != null and $scope.steps[$scope.activeStepIndex].type = 'subQuestion'
        #save answer
        #Questions.registerAnswerForActiveSubQuestion($scope.activeAnswerValue)
        console.log 'SAVE: ' + $scope.activeAnswerValue
      
      if ($scope.activeStepIndex + 1) < $scope.steps.length
        $scope.activeStepIndex++
        $scope.activeStep = $scope.steps[$scope.activeStepIndex]
      else
        $scope.quizState = 'completed'
    
    $scope.showResult = ()->
      $location.path('result/' + User.getUserToken());
    
  ]
