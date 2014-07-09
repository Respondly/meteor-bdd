Test.run '[describe] statement',
  tearDown: -> BDD.reset()
  tests:
    'does not fail if not function is specified': (test) ->
      BDD.describe 'foo'


    'adds a suite to the root': (test) ->
      BDD.describe 'my thing', ->
      children = BDD.suite.children
      expect(children.length).to.equal 1
      expect(children[0].name).to.equal 'my thing'


    'resets the root suite': (test) ->
      BDD.describe 'my thing', ->
      expect(BDD.suite.children.length).to.equal 1
      BDD.reset()
      expect(BDD.suite.children.length).to.equal 0


    'has an "Untitled" description': (test) ->
      expect(BDD.describe().name).to.equal 'Untitled'
      expect(BDD.describe('').name).to.equal 'Untitled'
      expect(BDD.describe('  ').name).to.equal 'Untitled'


    'adds a nested suite': (test) ->
      result = BDD.describe 'parent', ->
                 BDD.describe 'child1', ->
                 BDD.describe 'child2', ->
                  BDD.describe 'grandchild1', ->

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

