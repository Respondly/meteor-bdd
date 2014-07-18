Test.run 'Method (class)',
  tearDown: -> BDD.reset()
  tests:
    'has default values upon construction': (test) ->
      fn = ->
      method = new BDD.Method(fn)
      expect(method.func).to.equal fn
      expect(method.isAsync).to.equal false
      expect(method.timeout).to.equal 5000

    'is async': (test) ->
      method = new BDD.Method((done) ->)
      expect(method.isAsync).to.equal true


