'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', '$location', 'User', 'API', ($scope, $location, User, API) ->
    
    activeQuestionIndex = -1
    
    answers = []
    
    questions = [
      id: 1
      question: 'How old would you be if you didn’t know how old you are?'
    ,
      id: 2
      question: 'Which is worse, failing or never trying?'
    ,
      id: 3
      question: 'If life is so short, why do we do so many things we don’t like and like so many things we don’t do?'
    ,
      id: 4
      question: 'When it’s all said and done, will you have said more than you’ve done?'
    ,
      id: 5
      question: 'What is the one thing you’d most like to change about the world?'
    ,
      id: 6
      question: 'If happiness was the national currency, what kind of work would make you rich?'
    ,
      id: 7
      question: 'Are you doing what you believe in, or are you settling for what you are doing?'
    ]
    
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
        userToken: User.getUserId()
        answers: answers
      , (obj, success, err)->
        if (err?)
          console.log 'Error'
          console.log err
        else
          $location.path('result/' + User.getUserId());
    
    $scope.startQuiz = ()->
      answers = []
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
