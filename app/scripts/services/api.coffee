'use strict'

angular.module('prejuiceUiApp')
  .service('API', ['$resource', ($resource) ->
      #return $resource('/api/questions/:id',
      
      Questions: $resource '/api',
        questionId: '@id'
      
    ])