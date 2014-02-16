'use strict'

angular.module('prejuiceUiApp')
  .service 'API', ['$resource', ($resource) ->
    #return $resource('/api/questions/:id',

    questions: $resource '/api',
      questionId: '@id'
  ]