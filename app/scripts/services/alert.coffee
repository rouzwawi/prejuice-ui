"use strict"

angular.module('prejuiceUiApp')
  .factory 'Alert', ['$rootScope', ($rootScope) ->

    infoAutocloseTime = 1000
    
    $rootScope.alerts = []

    closeAlertIndex = (index)->
      $rootScope.alerts.splice index, 1

      if $rootScope.$$phase != '$apply' && $rootScope.$$phase != '$digest'
        $rootScope.$apply()
    
    add = (type, msg)->
      alert =
        type: type
        msg: msg
      
      $rootScope.alerts.push alert

      if type is 'info'
        setTimeout(()->
          #iterate over messages and make sure that we havent closed it already
          for i in [0..$rootScope.alerts.length]
            if alert is $rootScope.alerts[i]
              self.closeAlertIndex i
              break
        , infoAutocloseTime)
    
    addGenericError: (code)->
      add 'error', 'Ooops!... (code ' + code + ')'
    
    add: add

    closeAlert: (index) ->
      self.closeAlertIndex index
  ]