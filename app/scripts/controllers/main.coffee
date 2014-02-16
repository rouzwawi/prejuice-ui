'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'API', 'Alert', ($scope, $location, User, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.quizStarted = false
    $scope.activeQuestion = null
    $scope.activeAnswerValue = 0
    
    activeQuestionIndex = -1
    
    questions = {}
    answers = {}
    
    $scope.$on 'LOGGED_IN', ()->
      questionsObj = API.questions.get (res)->
        questions = questionsObj.questions
        $scope.quizReadyToStart = true
      , (err)->
        Alert.add 'error', 'Could not get questions (' + err.status + ')'  
    
    saveCurrentQuestionAnswer = ()->
      if $scope.activeQuestion?
        answers[$scope.activeQuestion.id] = $scope.activeAnswerValue
    
    nextQuestion = ()->
      activeQuestionIndex++
      $scope.activeAnswerValue = 0
      if activeQuestionIndex < questions.length
        #go to next question
        $scope.activeQuestion = questions[activeQuestionIndex]
      else
        #go to end
        endQuiz()
        
    endQuiz = ()->
      API.answers.save
        userToken: User.getUserToken()
        answers: answers
      , (res)->
        $location.path('result/' + User.getUserToken());
      , (err)->
        Alert.add 'error', 'Could not post answers (' + err.status + ')'
    
    $scope.startQuiz = ()->
      answers = {}
      $scope.quizStarted = true
      activeQuestionIndex = -1
      $scope.activeAnswerValue = 0
      nextQuestion()
      
    $scope.goToNextQuestion = ()->
      saveCurrentQuestionAnswer()
      nextQuestion()
      
    $scope.onQuestionSliderValueUpdated = (val)->
      $scope.$apply ()->
        $scope.activeAnswerValue = val
  ]
