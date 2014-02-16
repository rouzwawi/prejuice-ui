'use strict'

describe 'Directive: pjSlider', () ->

  # load the directive's module
  beforeEach module 'prejuiceUiApp'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()

  it 'should make hidden element visible', inject ($compile) ->
    element = angular.element '<pj-slider></pj-slider>'
    element = $compile(element) scope
    expect(element.text()).toBe 'this is the pjSlider directive'
