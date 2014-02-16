'use strict'

angular.module('prejuiceUiApp')
  .controller 'MainCtrl', ['$scope', 'API', ($scope, API) ->
    
    $scope.getQuestions = ()->
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
  ]
