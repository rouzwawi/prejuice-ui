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
       
      minIndicator = '<div class="slider-handle round min-range"><div class="tooltip in min-range"><div class="tooltip-arrow"></div><div class="tooltip-inner"><div class="span tooltip-help-text">' + q.minRange + '</div>' + q.rangeUnit + '</div></div></div>' 
      $elm.before(minIndicator)
      
      maxIndicator = '<div class="slider-handle round max-range"><div class="tooltip in max-range"><div class="tooltip-arrow"></div><div class="tooltip-inner"><div class="span tooltip-help-text">' + q.maxRange + '</div>' + q.rangeUnit + '</div></div></div>'
      $elm.after(maxIndicator)
  ])