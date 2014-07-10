Test.run 'Spec (class)',
  tearDown: -> BDD.reset()
  tests:
    'has default values upon construction': (test) ->
      fn = ->
      spec = new BDD.Spec('does something', fn)
      expect(spec.name).to.equal 'does something'
      expect(spec.func).to.equal fn
      expect(spec.isAsync).to.equal false
      expect(spec.timeout).to.equal 5000

    'is async': (test) ->
      spec = new BDD.Spec('does something', (done) ->)
      expect(spec.isAsync).to.equal true



Test.run 'Spec (run synchronous)',
  tearDown: -> BDD.reset()
  tests:
    '[runs] the spec function with no context': (test) ->
      count = 0
      self = undefined
      err = undefined
      fn = ->
          count += 1
          self = @
      spec = new BDD.Spec('foo', fn)
      spec.run(null, (e) -> err = e)
      expect(count).to.equal 1
      expect(self).to.equal spec
      expect(err).to.equal null

    '[runs] the spec with the given context': (test) ->
      self = undefined
      fn = -> self = @
      spec = new BDD.Spec('foo', fn)
      spec.run({ foo:123 })
      expect(self.foo).to.equal 123

    'returns an [AssertionError]': (test) ->
      fn = -> expect(true).to.equal false
      spec = new BDD.Spec('foo', fn)
      err = undefined
      spec.run(null, (e) -> err = e)
      expect(err).to.be.an.instanceOf chai.AssertionError



Test.run 'Spec (run asynchronous)',
  tearDown: -> BDD.reset()
  tests:
    '[runs] the spec function with no context': (test, done) ->
      self = undefined
      count = 0
      fn = (done) ->
              count += 1
              self = @
              Util.delay(20, done)
      spec = new BDD.Spec('foo', fn)
      runAsync = (callback) -> spec.run(null, callback)
      runAsync done ->
            expect(count).to.equal 1
            expect(self).to.equal spec


    '[runs] the spec with the given context': (test, done) ->
      self = undefined
      fn = (done) ->
              self = @
              Util.delay(20, done)
      spec = new BDD.Spec('foo', fn)
      runAsync = (callback) -> spec.run({ foo:123 }, callback)
      runAsync done ->
            expect(self.foo).to.equal 123


    'times out (error)': (test, done) ->
      self = undefined
      spec = new BDD.Spec('foo', (done) ->) # Callback not invoked.
      spec.timeout = 200
      err = null
      runAsync = (callback) ->
          spec.run null, (e) ->
              err = e
              callback()
      runAsync done ->
        expect(err.message).to.equal 'Timed out'


    'returns an [AssertionError]': (test, done) ->
      fn = (done) -> expect(true).to.equal false
      spec = new BDD.Spec('foo', fn)
      err = null
      runAsync = (callback) ->
          spec.run null, (e) ->
              err = e
              callback()
      runAsync done ->
        expect(err).to.be.an.instanceOf chai.AssertionError



