'use strict'

angular.module('prejuiceUiApp')
  .directive('pjChart', ["$rootScope", ($rootScope) ->
    scope:
      data: '='
    link: (scope, elm, attrs) ->

      chartData = scope.data

      respChart = (selector, data, options) ->

        generateChart = ->
          # make chart width fit with its container
          ww = selector.attr("width", $(container).width())
          # Initiate new chart or Redraw
          new Chart(ctx).Line data, options
          return

        option =
          scaleOverlay: false
          scaleOverride: false
          scaleSteps: null
          scaleStepWidth: null
          scaleStartValue: null
          scaleLineColor: "rgba(0,0,0,.1)"
          scaleLineWidth: 0
          scaleShowLabels: false
          scaleLabel: "<%=value%>"
          scaleFontFamily: "'Oswald'"
          scaleFontSize: 12
          scaleFontStyle: "bold"
          scaleFontColor: "#909090"
          scaleShowGridLines: false
          scaleGridLineColor: "rgba(0,0,0,.05)"
          scaleGridLineWidth: 0
          bezierCurve: true
          pointDot: true
          pointDotRadius: 5
          pointDotStrokeWidth: 1
          datasetStroke: true
          datasetStrokeWidth: 3
          datasetFill: true
          animation: true
          animationSteps: 60
          animationEasing: "easeOutQuart"
          onAnimationComplete: null

        options = option if options is false or not options?
        ctx = selector.get(0).getContext("2d")
        container = $(selector).parent()
        $(window).resize generateChart
        scope.$watch generateChart

        return

      respChart $("canvas"), chartData
  ])