'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$rootScope', '$scope', '$location', 'User', 'API', 'Alert', ($rootScope, $scope, $location, User, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.quizState = 'ready'
    
    $scope.steps = []
    $scope.activeStepIndex = 0
    $scope.activeStep = null
    
    $scope.activeAnswerValue = 0

    answers = {}
    
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
          question: question
        console.log question
        
        #sub questions
        for subQuestion in question.subQuestions
          steps.push
            type: 'subQuestion'
            question: subQuestion
            coordinates: [question.id, subQuestion.id]

        #question outro
        steps.push
          type: 'questionOutro'
          question: question
      
      $scope.steps = steps
      $scope.activeStepIndex = -1
      $scope.nextStep()
      $scope.quizReadyToStart = true
    
    $scope.startQuiz = ()->
      $scope.quizState = 'running'
      
    $scope.nextStep = ()->
      console.log 'next step'
      if $scope.activeStep and $scope.activeStep.type is 'subQuestion'
        #save answer
        #Questions.registerAnswerForActiveSubQuestion($scope.activeAnswerValue)
        console.log 'SAVE: ', $scope.activeStep.coordinates, $scope.activeAnswerValue
        cs = $scope.activeStep.coordinates
        answers[cs[0]] ?= {}
        answers[cs[0]][cs[1]] = $scope.activeAnswerValue

      if ($scope.activeStepIndex + 1) < $scope.steps.length
        $scope.activeStepIndex++
        $scope.activeStep = $scope.steps[$scope.activeStepIndex]

        if $scope.activeStep.type is 'subQuestion'
          $scope.activeAnswerValue = $scope.activeStep.question.initial

        if $scope.activeStep.type is 'questionOutro'
          partialAnswers = $.extend {}, answers[$scope.activeStep.question.id]
          partialAnswers.id = $scope.activeStep.question.id
          console.log 'GET STATS: ', partialAnswers
          $scope.partialStats = API.answerStats.get partialAnswers, (res)->
            console.log res
      else
        console.log answers
        API.answers.save
          userToken: User.getUserToken()
          answers: answers
        , (res)->
          $scope.quizState = 'completed'
          console.log res
        , (err)->
          Alert.add 'error', 'Could not post answers (' + err.status + ')'
    
    $scope.showResult = ()->
      $location.path(User.getUserToken());
    
  ]
