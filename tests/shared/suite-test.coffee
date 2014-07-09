suite = null

Test.run 'Suite (class)',
  setup: -> suite = new BDD.Suite('foo')
  tests:
    'has default values upon construction': (test) ->
      expect(suite.name).to.equal 'foo'
      expect(suite.children).to.eql []
      expect(suite.specs).to.eql []

    'has a root [Suite] instance on the BDD namespace': (test) ->
      expect(BDD.suite).to.be.an.instanceOf BDD.Suite
      expect(BDD.suite.name).to.equal 'root'

    'has [before] handlers (before-all)': (test) ->
      expect(suite.before).to.be.an.instanceOf Handlers

    'has [beforeEach] handlers (before-all)': (test) ->
      expect(suite.beforeEach).to.be.an.instanceOf Handlers

    'has [after] handlers (before-all)': (test) ->
      expect(suite.after).to.be.an.instanceOf Handlers

    'has [afterEach] handlers (before-all)': (test) ->
      expect(suite.afterEach).to.be.an.instanceOf Handlers

    'adds a child suite': (test) ->
      childSuite = new BDD.Suite('child')
      result = suite.add(childSuite)
      expect(result).to.equal childSuite
      expect(childSuite.parent).to.equal suite
      expect(suite.children.length).to.equal 1
      expect(suite.children[0]).to.equal childSuite

    'adds a child spec': (test) ->
      spec = suite.add(new BDD.Spec('foo'))
      expect(spec).to.be.an.instanceOf BDD.Spec
      expect(spec.parent).to.equal suite
      expect(suite.specs).to.eql [spec]

    'disposes of a suite': (test) ->
      parent = new BDD.Suite('parent')
      child = new BDD.Suite('child')
      parent.add(child)
      parent.dispose()

      expectDisposed = (suite) ->
          expect(suite.isDisposed).to.equal true
          expect(suite.before.isDisposed).to.equal true
          expect(suite.after.isDisposed).to.equal true
          expect(suite.beforeEach.isDisposed).to.equal true
          expect(suite.afterEach.isDisposed).to.equal true

      expectDisposed(parent)
      expectDisposed(child)


