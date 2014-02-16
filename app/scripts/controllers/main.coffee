'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'API', 'Alert', ($scope, $location, User, API, Alert) ->
    
    $scope.quizReadyToStart = false
    $scope.activeQuestion = null
    $scope.activeAnswerValue = 0
    $scope.quizState = 'ready'
    
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
        $scope.quizState = 'question'
        $scope.activeQuestion = questions[activeQuestionIndex]
      else
        #go to end
        endQuiz()
        
    showPostQuestion = ()->
      $scope.quizState = 'post-question'
      
    endQuiz = ()->
      API.answers.save
        userToken: User.getUserToken()
        answers: answers
      , (res)->
        $scope.quizState = 'completed'
      , (err)->
        Alert.add 'error', 'Could not post answers (' + err.status + ')'
    
    $scope.startQuiz = ()->
      answers = {}
      activeQuestionIndex = -1
      $scope.activeAnswerValue = 0
      nextQuestion()
      
    $scope.answerQuestion = ()->
      saveCurrentQuestionAnswer()
      showPostQuestion()
      
    $scope.nextQuestion = nextQuestion
    
    $scope.showResult = ()->
      $location.path('result/' + User.getUserToken());
      
    $scope.onQuestionSliderValueUpdated = (val)->
      $scope.$apply ()->
        $scope.activeAnswerValue = val
  ]
