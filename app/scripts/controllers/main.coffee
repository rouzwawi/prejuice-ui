'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$rootScope', '$sce', '$scope', '$location', '$window','User', 'API', 'Alert', ($rootScope, $sce, $scope, $location, $window, User, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.quizState = 'ready'
    
    $scope.steps = []
    $scope.activeStepIndex = 0
    $scope.activeStep = null
    
    $scope.categoryIndex = 1
    $scope.progressPercentage = 0
    
    $scope.activeAnswerValue = 0

    answers = {}
    
    updateProgress = ()->
      percentage = ($scope.activeStepIndex / $scope.steps.length)
      $scope.progressPercentage = Number(percentage*100).toFixed(0)
      
      $scope.categoryIndex = Number(Math.floor(percentage*4+1)).toFixed(0)
    
    $scope.getIntroNextText = ()->
      if $scope.activeStepIndex < 3
        return 'Första frågan!'
      return 'Nästa fråga'
      
    $scope.getOutroNextText = ()->
      if $scope.activeStepIndex > 18
        return 'Kalkylera fördomsprofil'
      return 'Nästa fördom!'
    
    $scope.roundNumber = (num, dec)->
      Number(num).toFixed(dec)
      
    $scope.getDotPosition = (question, val)->
      result = ( (val - question.minRange) / (question.maxRange - question.minRange) ) * 100 + "%"
    
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
        question.categorySafe = $sce.trustAsHtml(question.category)

        #question intro
        steps.push
          type: 'questionIntro'
          question: question
        console.log question
        
        #sub questions
        for subQuestion in question.subQuestions
          subQuestion.questionSafe = $sce.trustAsHtml(subQuestion.question)
          subQuestion.inDepthSafe = $sce.trustAsHtml(subQuestion.inDepth)
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
      #console.log 'next step'

      #Google Analytics
      ((i, s, o, g, r, a, m) ->
        i["GoogleAnalyticsObject"] = r
        i[r] = i[r] or ->
          (i[r].q = i[r].q or []).push arguments
          return


        i[r].l = 1 * new Date()

        a = s.createElement(o)
        m = s.getElementsByTagName(o)[0]

        a.async = 1
        a.src = g
        m.parentNode.insertBefore a, m
        return
      ) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
      ga "create", "UA-50452169-1", "fordomstestet.se"
      ga "send", "pageview"

      #console.log 'Google Analytics triggered'
      
      if $scope.activeStep and $scope.activeStep.type is 'subQuestion'
        #save answer
        #Questions.registerAnswerForActiveSubQuestion($scope.activeAnswerValue)
        console.log 'SAVE: ', $scope.activeStep.coordinates, $scope.activeAnswerValue
        cs = $scope.activeStep.coordinates
        answers[cs[0]] ?= {}
        answers[cs[0]][cs[1]] = $scope.activeAnswerValue

      if ($scope.activeStepIndex + 1) < $scope.steps.length
        $scope.activeStepIndex++
        updateProgress()
        $scope.activeStep = $scope.steps[$scope.activeStepIndex]

        if $scope.activeStep.type is 'subQuestion'
          $scope.activeAnswerValue = $scope.activeStep.question.initial

        if $scope.activeStep.type is 'questionOutro'
          partialAnswers = $.extend {}, answers[$scope.activeStep.question.id]
          partialAnswers.id = $scope.activeStep.question.id
          console.log 'GET STATS: ', partialAnswers
          $scope.partialStats = API.answerStats.get partialAnswers, (res)->
            console.log $scope.activeStep
            console.log res
            
        $window.scrollTo 0, 0
      else
        API.answers.save
          userToken: User.getUserToken()
          answers: answers
        , (res)->
          $scope.showResult()
        , (err)->
          Alert.add 'error', 'Could not post answers (' + err.status + ')'
    
    $scope.showResult = ()->
      $location.path(User.getUserToken());
    
  ]
