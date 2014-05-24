'use strict'

angular.module('prejuiceUiApp')
  .service 'User', ['$rootScope', '$resource', 'API', 'Alert', ($rootScope, $resource, API, Alert) ->
    
    $rootScope.isLoggedIn = false

    user = API.userToken.get (res)->
      $rootScope.isLoggedIn = true
      $rootScope.$broadcast 'LOGGED_IN'
    , (err)->
      Alert.add 'error', 'Could not login (' + err.status + ')'

    takenTest = false

    getUserToken: ()=>
      user.userToken

    setTakenTest: (b)=>
      takenTest = b

    hasTakenTest: ()=>
      takenTest
  ]
