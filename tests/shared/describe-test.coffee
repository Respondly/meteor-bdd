Test.run '[describe] statement',
  tearDown: -> BDD.reset()
  tests:
    'does not fail if not function is specified': (test) ->
      describe 'foo'


    'adds a suite to the root': (test) ->
      describe 'my thing', ->
      children = BDD.suite.suites()
      expect(children.length).to.equal 1
      expect(children[0].name).to.equal 'my thing'


    'resets the root suite': (test) ->
      describe 'my thing', ->
      expect(BDD.suite.suites().length).to.equal 1
      BDD.reset()
      expect(BDD.suite.suites().length).to.equal 0


    'has an "Untitled" description': (test) ->
      expect(describe().name).to.equal 'Untitled'
      expect(describe('').name).to.equal 'Untitled'
      expect(describe('  ').name).to.equal 'Untitled'


    'adds a nested suite': (test) ->
      result = describe 'parent', ->
                 describe 'child1', ->
                 describe 'child2', ->
                  describe 'grandchild1', ->

      parent = BDD.suite.suites()[0]
      child1 = parent.suites()[0]
      child2 = parent.suites()[1]
      grandchild1 = child2.suites()[0]

      expect(child1.name).to.equal 'child1'
      expect(child1.parent).to.equal parent
      expect(child1.suites().length).to.equal 0

      expect(child2.name).to.equal 'child2'
      expect(child2.parent).to.equal parent
      expect(child2.suites().length).to.equal 1

      expect(grandchild1.name).to.equal 'grandchild1'
      expect(grandchild1.parent).to.equal child2
      expect(grandchild1.suites().length).to.equal 0

      expect(BDD.suite.suites().length).to.equal 1
      expect(parent.suites().length).to.equal 2


    'adds to the same existing Suite': (test) ->
      suite1 = describe 'my suite', ->
        it 'foo-1', ->

      suite2 = describe 'my suite', ->
        it 'foo-2', ->

      suite3 = describe 'something else', ->

      root = BDD.suite
      expect(root.suites().length).to.equal 2
      expect(suite1).to.equal suite2
      expect(root.suites()[0].specs()[0].name).to.equal 'foo-1'
      expect(root.suites()[0].specs()[1].name).to.equal 'foo-2'


    'adds multiple identically named specs to the same existing Suite': (test) ->
      suite1 = describe 'my suite', ->
        it 'foo', ->

      suite2 = describe 'my suite', ->
        it 'foo', ->

      root = BDD.suite
      expect(root.suites().length).to.equal 1
      expect(root.suites()[0]).to.equal suite1
      expect(suite1.specs().length).to.equal 2
      expect(suite1.specs()[0].name).to.equal 'foo'
      expect(suite1.specs()[1].name).to.equal 'foo'



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



# ----------------------------------------------------------------------



Test.run '[before] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a [before] function to the root suite': (test) ->
      fn = ->
      before(fn)
      expect(BDD.suite.before[0]).to.be.an.instanceOf BDD.Method
      expect(BDD.suite.before[0].func).to.equal fn

    'adds a [before] function to a nested suite': (test) ->
      fn = ->
      describe 'my suite', ->
        before(fn)
      expect(BDD.suite.suites()[0].before[0].func).to.equal fn


# ----------------------------------------------------------------------



Test.run '[beforeEach] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a [beforeEach] function to the root suite': (test) ->
      fn = ->
      beforeEach(fn)
      expect(BDD.suite.beforeEach[0]).to.be.an.instanceOf BDD.Method
      expect(BDD.suite.beforeEach[0].func).to.equal fn

    'adds a [beforeEach] function to a nested suite': (test) ->
      fn = ->
      describe 'my suite', ->
        beforeEach(fn)
      expect(BDD.suite.suites()[0].beforeEach[0].func).to.equal fn



# ----------------------------------------------------------------------



Test.run '[after] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a [after] function to the root suite': (test) ->
      fn = ->
      after(fn)
      expect(BDD.suite.after[0]).to.be.an.instanceOf BDD.Method
      expect(BDD.suite.after[0].func).to.equal fn

    'adds a [after] function to a nested suite': (test) ->
      fn = ->
      describe 'my suite', ->
        after(fn)
      expect(BDD.suite.suites()[0].after[0].func).to.equal fn



# ----------------------------------------------------------------------



Test.run '[afterEach] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a [afterEach] function to the root suite': (test) ->
      fn = ->
      afterEach(fn)
      expect(BDD.suite.afterEach[0]).to.be.an.instanceOf BDD.Method
      expect(BDD.suite.afterEach[0].func).to.equal fn

    'adds a [afterEach] function to a nested suite': (test) ->
      fn = ->
      describe 'my suite', ->
        afterEach(fn)
      expect(BDD.suite.suites()[0].afterEach[0].func).to.equal fn









