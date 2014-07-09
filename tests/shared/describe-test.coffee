Test.run '[describe] statement',
  tearDown: -> BDD.reset()
  tests:
    'does not fail if not function is specified': (test) ->
      describe 'foo'


    'adds a suite to the root': (test) ->
      describe 'my thing', ->
      children = BDD.suite.children
      expect(children.length).to.equal 1
      expect(children[0].name).to.equal 'my thing'


    'resets the root suite': (test) ->
      describe 'my thing', ->
      expect(BDD.suite.children.length).to.equal 1
      BDD.reset()
      expect(BDD.suite.children.length).to.equal 0


    'has an "Untitled" description': (test) ->
      expect(describe().name).to.equal 'Untitled'
      expect(describe('').name).to.equal 'Untitled'
      expect(describe('  ').name).to.equal 'Untitled'


    'adds a nested suite': (test) ->
      result = describe 'parent', ->
                 describe 'child1', ->
                 describe 'child2', ->
                  describe 'grandchild1', ->

      parent = BDD.suite.children[0]
      child1 = parent.children[0]
      child2 = parent.children[1]
      grandchild1 = child2.children[0]

      expect(child1.name).to.equal 'child1'
      expect(child1.parent).to.equal parent
      expect(child1.children.length).to.equal 0

      expect(child2.name).to.equal 'child2'
      expect(child2.parent).to.equal parent
      expect(child2.children.length).to.equal 1

      expect(grandchild1.name).to.equal 'grandchild1'
      expect(grandchild1.parent).to.equal child2
      expect(grandchild1.children.length).to.equal 0

      expect(BDD.suite.children.length).to.equal 1
      expect(parent.children.length).to.equal 2



# ----------------------------------------------------------------------



Test.run '[it] statement',
  tearDown: -> BDD.reset()
  tests:
    'adds a spec to the root suite': (test) ->
      it 'foo', ->
      expect(BDD.suite.specs[0].name).to.equal 'foo'


    'adds a spec with no function': (test) ->
      it()
      expect(BDD.suite.specs[0].func).to.equal undefined

    'adds a spec to a suite': (test) ->
      suite = BDD.describe 'foo', ->
                it 'does something', ->
      expect(suite.specs.length).to.equal 1
      expect(suite.specs[0].name).to.equal 'does something'

    'adds a deeply nested spec': (test) ->
      describe '1', ->
        describe '2', ->
          describe '3', ->
            it 'foo', ->
      expect(BDD.suite.children[0].children[0].children[0].specs[0].name).to.equal 'foo'



# ----------------------------------------------------------------------



Test.run '[before] statement',
  setup: ->
  tearDown: ->
  tests:
    'spec': (test) ->






