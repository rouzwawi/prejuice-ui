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
      rounder = (value) ->
        Math.round(value * 100)/100

      q = scope.step.question
      $elm = jQuery(elm)
      slide = $elm.slider
        tooltip: 'always'
        min: q.minRange
        max: q.maxRange
        value: q.initial
        # step: if q.rangeUnit is '*' then 0.1 else 1
        step: 0.1
        formater: (value) ->
          res = rounder(value).toFixed(1)
          res += ' ' if q.rangeUnit in ['mdr', 'ggr']
          res += q.rangeUnit
          res
      $elm.on 'slide', (slideEvt)->
        update rounder slideEvt.value
  ])