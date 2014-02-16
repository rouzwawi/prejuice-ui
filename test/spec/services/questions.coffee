'use strict'

describe 'Service: Questions', () ->

  # load the service's module
  beforeEach module 'prejuiceUiApp'

  # instantiate service
  Questions = {}
  beforeEach inject (_Questions_) ->
    Questions = _Questions_

  it 'should do something', () ->
    expect(!!Questions).toBe true
