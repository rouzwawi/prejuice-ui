'use strict'

angular.module('prejuiceUiApp')
  .directive('selectOnClick', [() ->
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.on 'click', () ->
        this.select()
  ])
