'use strict'

angular.module('prejuiceUiApp')
  .service 'API', ['$resource', ($resource) ->
    #return $resource('/api/questions/:id',

    hello: $resource '/api'

    questions: $resource '/api/questions'
    
    ###
      {
        userToken: <string>
      }
    ###
    userToken: $resource '/api/token'

    ###
      {
        userToken: <string>,
        answers: {
          <int>: <int>,
          <int>: <int>,
          ...
        ]
      }
    ###
    answers: $resource '/api/answers/:id',
      id: '@id'
  ]
