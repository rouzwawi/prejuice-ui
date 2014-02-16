'use strict'

angular.module('prejuiceUiApp')
  .service 'User', ['$rootScope', '$resource', 'API', ($rootScope, $resource, API) ->
    
    $rootScope.isLoggedIn = false
    
    @userId = API.userToken.get (obj, success, err)->
      if(err?)
        console.log 'Error'
        console.log err
      else
        $rootScope.isLoggedIn = true
    
    getUserId: ()=>
      return @userId
  ]