Test.run 'Spec (class)',
  tearDown: -> BDD.reset()
  tests:
    'has default values upon construction': (test) ->
      fn = ->
      spec = new BDD.Spec('does something', fn)
      expect(spec.name).to.equal 'does something'
      expect(spec.func).to.equal fn
