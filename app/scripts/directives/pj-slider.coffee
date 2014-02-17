'use strict'

angular.module('prejuiceUiApp')
  .directive('pjSlider', ["$rootScope", ($rootScope) ->
    scope:
      step: '='
      onSliderValueUpdated: '&'
    link: (scope, elm, attrs) ->
      update = (value) ->
        if scope.onSliderValueUpdated?
          scope.onSliderValueUpdated
            val: value
      formater = (value) ->
        Math.round(value * 100)/100

      q = scope.step.question
      $elm = $(elm)
      slide = $elm.slider
        min: q.minRange
        max: q.maxRange
        value: q.initial
        # step: if q.rangeUnit is '*' then 0.1 else 1
        step: 0.1
        formater: formater
      $elm.on 'slide', (slideEvt)->
        update formater slideEvt.value
  ])