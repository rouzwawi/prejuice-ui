'use strict'

angular.module('prejuiceUiApp')
  .service 'API', ['$resource', ($resource) ->
    #return $resource('/api/questions/:id',

    questions: $resource '/api'

    ###
      {
        userToken: <string>,
        answers: [
          {
            questionId: <int>
            value: <int>
          },
          ...
        ]
      }
    ###
    answers: $resource '/api/answers/:id',
      id: '@id'
  ]
