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



Test.run 'Method (run synchronous)',
  tearDown: -> BDD.reset()
  tests:
    '[runs] the method function with no context': (test) ->
      count = 0
      self = undefined
      err = undefined
      fn = ->
          count += 1
          self = @
      method = new BDD.Method(fn)
      method.run(null, (e) -> err = e)
      expect(count).to.equal 1
      expect(self).to.equal method
      expect(err).to.equal null

    '[runs] the method with the given context': (test) ->
      self = undefined
      fn = -> self = @
      method = new BDD.Method(fn)
      method.run({ foo:123 })
      expect(self.foo).to.equal 123

    'returns an [AssertionError]': (test) ->
      fn = -> expect(true).to.equal false
      method = new BDD.Method(fn)
      err = undefined
      method.run(null, (e) -> err = e)
      expect(err).to.be.an.instanceOf chai.AssertionError



Test.run 'Method (run asynchronous)',
  tearDown: -> BDD.reset()
  tests:
    '[runs] the method function with no context': (test, done) ->
      self = undefined
      count = 0
      fn = (done) ->
              count += 1
              self = @
              Util.delay(20, done)
      method = new BDD.Method(fn)
      runAsync = (callback) -> method.run(null, callback)
      runAsync done ->
            expect(count).to.equal 1
            expect(self).to.equal method


    '[runs] the method with the given context': (test, done) ->
      self = undefined
      fn = (done) ->
              self = @
              Util.delay(20, done)
      method = new BDD.Method(fn)
      runAsync = (callback) -> method.run({ foo:123 }, callback)
      runAsync done ->
            expect(self.foo).to.equal 123


    'times out (error)': (test, done) ->
      self = undefined
      method = new BDD.Method((done) ->) # Callback not invoked.
      method.timeout = 200
      err = null
      runAsync = (callback) ->
          method.run null, (e) ->
              err = e
              callback()
      runAsync done ->
        expect(err.message).to.equal 'Timed out'


    'returns an [AssertionError]': (test, done) ->
      fn = (done) -> expect(true).to.equal false
      method = new BDD.Method(fn)
      err = null
      runAsync = (callback) ->
          method.run null, (e) ->
              err = e
              callback()
      runAsync done ->
        expect(err).to.be.an.instanceOf chai.AssertionError



