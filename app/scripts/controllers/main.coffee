'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$rootScope', '$scope', '$location', 'User', 'API', 'Alert', ($rootScope, $scope, $location, User, API, Alert) ->
    
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
    
    $rootScope.$on 'LOGGED_IN', ()->
      questionsObj = API.questions.get (res)->
        createSteps questionsObj.questions
      , (err)->
        Alert.add 'error', 'Could not get questions (' + err.status + ')'
    
    createSteps = (questions)->
      steps = []
      
      for question in questions
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
        API.answers.save
          userToken: User.getUserToken()
          answers: {}
        , (res)->
          $scope.quizState = 'completed'
        , (err)->
          Alert.add 'error', 'Could not post answers (' + err.status + ')'
    
    $scope.showResult = ()->
      $location.path('result/' + User.getUserToken());
    
  ]
