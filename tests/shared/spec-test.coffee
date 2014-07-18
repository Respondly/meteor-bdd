Test.run 'Spec (class)',
  tearDown: -> BDD.reset()
  tests:
    'is an instance of [Method]': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec).to.be.an.instanceOf BDD.Method


    'has a name (description)': (test) ->
      fn = ->
      method = new BDD.Spec('does something', fn)
      expect(method.name).to.equal 'does something'
      expect(method.func).to.equal fn


    'has a unique ID as a hash of the name/description': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec.id).to.equal Util.hash('does something')


Test.run 'Spec.run (beforeEach | afterEach)',
  tearDown: -> BDD.reset()
  tests:
    'runs the beforeEach/afterEach methods around a spec': (test) ->
      beforeEachCount = 0
      specCount = 0
      afterEachCount = 0
      beforeEachContext = null
      specContext = null
      afterEachContext = null

      suite = new BDD.Suite('My suite')
      spec = new BDD.Spec 'My spec', ->
          specCount += 1
          specContext = @
      suite.add(spec)

      # NB: Adds multiple handlers. This is an edge-case.
      suite.beforeEach.push new BDD.Method(->
        beforeEachCount += 1
        beforeEachContext = @
        )
      suite.beforeEach.push new BDD.Method(-> beforeEachCount += 1)
      suite.beforeEach.push new BDD.Method(-> beforeEachCount += 1)

      suite.afterEach.push new BDD.Method(-> afterEachCount += 1)
      suite.afterEach.push new BDD.Method(->
        afterEachCount += 1
        afterEachContext = @
        )

      spec.run({foo:123})

      expect(beforeEachCount).to.equal 3
      expect(specCount).to.equal 1
      expect(afterEachCount).to.equal 2

      expect(beforeEachContext).to.eql {foo:123}
      expect(specContext).to.eql {foo:123}
      expect(afterEachContext).to.eql {foo:123}




