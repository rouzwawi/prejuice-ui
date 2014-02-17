"use strict"

angular.module('prejuiceUiApp')
  .factory 'Questions', ['$rootScope', 'User', 'API', 'Alert', ($rootScope, User, API, Alert) ->

    questionKeys = []
    activeQuestionIndex = -1
    activeQuestion = null
    
    activeSubQuestionIndex = -1
    activeSubQuestion = null
    
    activeState = 'question'
    
    answers = {} 
    questions = {}
    
    $rootScope.$on 'LOGGED_IN', ()->
      questionsObj = API.questions.get (res)->
        questions = questionsObj.questions
        questionKeys = Object.keys(questions)
        nextQuestionOrSubQuestion()
        $rootScope.$broadcast 'GOT_QUESTIONS'
      , (err)->
        Alert.add 'error', 'Could not get questions (' + err.status + ')'

    nextQuestionOrSubQuestion = ()->
      if questions? and questionKeys?
        if activeQuestionIndex == -1 or (activeQuestion? and activeSubQuestionIndex >= activeQuestion.subQuestions.length)
          nextQuestion()
        else if activeQuestion?
          nextSubQuestion()
          
      else
        Alert.add 'error', 'No questions to show'
    
    nextQuestion = ()->
      activeQuestionIndex++
      if activeQuestionIndex < questionKeys.length
        activeQuestion = questions[questionKeys[activeQuestionIndex]]
        nextSubQuestion()
      else 
        endQuiz()
        
    nextSubQuestion = ()->
      activeSubQuestionIndex++
      if activeSubQuestionIndex < activeQuestion.subQuestions.length
        activeSubQuestion = activeQuestion.subQuestions[activeSubQuestionIndex]
      else if activeSubQuestionIndex != -1
        activeState = 'post-question'
      else
        nextQuestion()
    
    endQuiz = ()->
      
    
    
    
    
    getQuestions: ()->
      return questions
    
    getActiveQuestion: ()->
      return activeQuestion
      
    getActiveSubQuestion: ()->
      return activeSubQuestion
      
    getQuestionState: ()->
      return activeState
      
    registerAnswerForActiveSubQuestion: (answer)->
      if activeQuestion? and activeSubQuestion?
        if !(answers[activeQuestion.id]?)
          answers[activeQuestion.id] = {}
        (answers[activeQuestion.id])[activeSubQuestion.id] = answer
        nextQuestionOrSubQuestion()
      
    nextQuestion: ()->
      nextQuestionOrSubQuestion()
  ]