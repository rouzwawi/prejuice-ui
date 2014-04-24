'use strict'

angular.module('prejuiceUiApp').filter('iif', ()->
  (input, trueValue, falseValue) ->
    (if input then trueValue else falseValue)
)