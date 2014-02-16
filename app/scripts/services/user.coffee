'use strict'

angular.module('prejuiceUiApp')
  .service 'User', ['$rootScope', '$resource', 'API', 'Alert', ($rootScope, $resource, API, Alert) ->
    
    $rootScope.isLoggedIn = false
    
    user = API.userToken.get (res)->
      $rootScope.isLoggedIn = true
    , (err)->
      Alert.add 'error', err.message
    
    getUserToken: ()=>
      return user.userToken
  ]