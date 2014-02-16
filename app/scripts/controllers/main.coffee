'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'API', ($scope, $location, User, API) ->
    
    activeQuestionIndex = -1
    
    answers = {}
    
    questions = null
    
    questionsObj = API.questions.get (res)->
      questions = questionsObj.questions
    , (err)->
      Alert.add 'error', err.message
      console.log err
    
    $scope.quizStarted = false
    $scope.activeQuestion = null
    $scope.activeAnswerValue = 0
    
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
      , (obj, success, err)->
        if (err?)
          console.log 'Error'
          console.log err
        else
          $location.path('result/' + User.getUserToken());
    
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
