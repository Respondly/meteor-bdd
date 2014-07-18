# Test.run 'run order',
#   setup: ->
#   tearDown: ->
#   tests:
#     'it runs suite: before => specs => after': (test) ->

#       console.error 'TODO - run order for suite'

#       suite = describe 'suite', ->
#                 before ->
#                 beforeEach ->

#                 it 'one', ->
#                 it 'two', ->

#                 afterEach ->
#                 after ->




Test.run 'method.run (instance)',
  tearDown: -> BDD.reset()
  tests:
    '[runs] the instnace method through the class method': (test) ->
      count = 0
      fnOriginal = BDD.Method.run
      BDD.Method.run = (m, c, done) ->
          count += 1
          expect(m).to.equal method
          expect(c).to.eql { foo:123 }
          expect(done).to.equal callback

      callback = ->
      method = new BDD.Method(->)
      method.run({ foo:123 }, callback)
      expect(count).to.equal 1

      BDD.Method.run = fnOriginal



Test.run 'Method.run (Synchronous Class Method)',
  tearDown: -> BDD.reset()
  tests:
    'runs a single method with the [Method] as the context': (test) ->
      count = 0
      self = undefined
      err = undefined
      fn = ->
          count += 1
          self = @
      method = new BDD.Method(fn)
      BDD.Method.run(method, null, (e) -> err = e)
      expect(count).to.equal 1
      expect(self).to.equal method
      expect(err).to.equal null

    'runs a single method with the given context': (test) ->
      self = undefined
      fn = -> self = @
      method = new BDD.Method(fn)
      BDD.Method.run(method, { foo:123 })
      expect(self.foo).to.equal 123

    'returns an [AssertionError]': (test) ->
      fn = -> expect(true).to.equal false
      method = new BDD.Method(fn)
      err = undefined
      BDD.Method.run(method, null, (e) -> err = e)
      expect(err).to.be.an.instanceOf chai.AssertionError



Test.run 'Method.run (Asynchronous Class Method)',
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
      runAsync = (callback) -> BDD.Method.run(method, null, callback)
      runAsync done ->
            expect(count).to.equal 1
            expect(self).to.equal method


    '[runs] the method with the given context': (test, done) ->
      self = undefined
      fn = (done) ->
              self = @
              Util.delay(20, done)
      method = new BDD.Method(fn)
      runAsync = (callback) -> BDD.Method.run(method, { foo:123 }, callback)
      runAsync done ->
            expect(self.foo).to.equal 123


    'times out (error)': (test, done) ->
      self = undefined
      method = new BDD.Method((done) ->) # Callback not invoked.
      method.timeout = 200
      err = null
      runAsync = (callback) ->
          BDD.Method.run method, null, (e) ->
              err = e
              callback()
      runAsync done ->
        expect(err.message).to.equal 'Timed out'


    'returns an [AssertionError]': (test, done) ->
      fn = (done) -> expect(true).to.equal false
      method = new BDD.Method(fn)
      err = null
      runAsync = (callback) ->
          BDD.Method.run method, null, (e) ->
              err = e
              callback()
      runAsync done ->
          expect(err).to.be.an.instanceOf chai.AssertionError



Test.run 'Method.runMany (Method)',
  tearDown: -> BDD.reset()
  tests:
    'runs multiple methods with no errors (Synchronous)': (test) ->
      context = null
      methodCount1 = 0
      methodCount2 = 0
      doneCount = 0
      result = undefined

      method1 = new BDD.Method(-> methodCount1 += 1)
      method2 = new BDD.Method(->
        methodCount2 += 1
        context = @
        )
      methods = [method1, method2]

      BDD.Method.runMany methods, {foo:123}, (r) ->
          doneCount += 1
          result = r

      expect(methodCount1).to.equal 1
      expect(methodCount2).to.equal 1
      expect(doneCount).to.equal 1
      expect(context).to.eql {foo:123}
      expect(result.errors.length).to.equal 0


    'runs multiple methods with an error (Synchronous)': (test) ->
      method1 = new BDD.Method(-> throw new Error('Foo'))
      method2 = new BDD.Method(-> )
      method3 = new BDD.Method(-> throw new Error('Bar'))
      methods = [method1, method2, method3]
      result = null

      BDD.Method.runMany methods, null, (r) -> result = r

      expect(result.errors.length).to.equal 2
      expect(result.errors[0].method).to.equal method1
      expect(result.errors[0].error.message).to.equal 'Foo'
      expect(result.errors[1].method).to.equal method3
      expect(result.errors[1].error.message).to.equal 'Bar'


    'runs multiple methods with no errors (Synchronous and Asynchronous)': (test, done) ->
      context = null
      methodCount1 = 0
      methodCount2 = 0

      method1 = new BDD.Method(-> methodCount1 += 1)
      method2 = new BDD.Method((done) ->
        methodCount2 += 1
        context = @
        Util.delay 10, -> done() # Async here.
        )
      methods = [method1, method2]

      runAsync = (callback) ->
          BDD.Method.runMany methods, {foo:123}, (result) ->
              callback()
      runAsync done ->
          expect(methodCount1).to.equal 1
          expect(methodCount2).to.equal 1
          expect(context).to.eql {foo:123}



