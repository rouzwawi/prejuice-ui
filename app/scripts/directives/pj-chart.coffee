'use strict'

angular.module('prejuiceUiApp')
  .directive 'pjChart', ["$rootScope", ($rootScope) ->
    scope:
      data: '='
    link: (scope, elm, attrs) ->

      chartData = scope.data

      chartCreated = false

      generateChart = ->
        if !chartCreated and chartData.data.main[0].data.length > 1  and chartData.data.comp[0].data.length > 1
          chartCreated = true
          myChart = new xChart('bar', chartData.data, '#result-chart', chartData.options)
          
          
      scope.$watch generateChart
  ]