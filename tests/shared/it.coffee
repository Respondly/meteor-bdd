Test.run '[beforeIt]',
  tearDown: -> BDD.reset()
  tests:
    'runs the [beforeDescribe] handlers': (test) ->
      count = 0
      BDD.beforeIt (context) -> count += 1
      BDD.beforeIt (context) -> count += 1
      spec = it 'does', ->
      spec.run()
      expect(count).to.equal 2

    'passes the mutatable context to the [beforeDescribe] handler': (test) ->
      context = null
      BDD.beforeIt (c) ->
          context = c
          context.foo = 123
      spec = it 'does', ->
      spec.run()
      expect(context.spec).to.equal spec
      expect(context.foo).to.equal 123


# ----------------------------------------------------------------------


Test.run '[it] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a spec to the root suite': (test) ->
      it 'foo', ->
      expect(BDD.suite.specs()[0]).to.be.an.instanceOf BDD.Spec
      expect(BDD.suite.specs()[0].name).to.equal 'foo'


    'adds a spec with no function': (test) ->
      it()
      expect(BDD.suite.specs()[0].func).to.equal undefined

    'adds a spec to a suite': (test) ->
      suite = BDD.describe 'foo', ->
                it 'does something', ->
      expect(suite.specs().length).to.equal 1
      expect(suite.specs()[0].name).to.equal 'does something'

    'adds a deeply nested spec': (test) ->
      describe '1', ->
        describe '2', ->
          describe '3', ->
            it 'foo', ->
      expect(BDD.suite.suites()[0].suites()[0].suites()[0].specs()[0].name).to.equal 'foo'
