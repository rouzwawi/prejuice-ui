'use strict'

angular.module('prejuiceUiApp')
  .directive('pjSlider', ["$rootScope", ($rootScope) ->
    scope:
      onSliderValueUpdated: '&'
    link: (scope, elm, attrs) ->
      
      $elm = $(elm)
      $elm.slider()
      $elm.on 'slide', (slideEvt)->
        if scope.onSliderValueUpdated?
          scope.onSliderValueUpdated
            val: slideEvt.value
  ])