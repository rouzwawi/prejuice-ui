'use strict'

angular.module('prejuiceUiApp')
  .service 'API', ['$resource', ($resource) ->
    #return $resource('/api/questions/:id',

    hello: $resource '/api'

    ###
      {
        questions: [
          {
            question: "How old would you be if you didn’t know how old you are?",
            id: "1"
          },
          {
            question: "Which is worse, failing or never trying?",
            id: "2"
          },
          ...
        ]
      }
    ###
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
