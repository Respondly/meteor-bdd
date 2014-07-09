describe 'Suite (class)', ->
  suite = null
  beforeEach -> suite = new BDD.Suite('foo')

  it 'has default values upon construction', ->
    expect(suite.name).to.equal 'foo'
    expect(suite.children).to.eql []

  it 'has a root [Suite] instance on the BDD namespace', ->
    expect(BDD.suite).to.be.an.instanceOf BDD.Suite
    expect(BDD.suite.name).to.equal 'root'

  it 'has [before] handlers (before-all)', ->
    expect(suite.before).to.be.an.instanceOf Handlers

  it 'has [beforeEach] handlers (before-all)', ->
    expect(suite.beforeEach).to.be.an.instanceOf Handlers

  it 'has [after] handlers (before-all)', ->
    expect(suite.after).to.be.an.instanceOf Handlers

  it 'has [afterEach] handlers (before-all)', ->
    expect(suite.afterEach).to.be.an.instanceOf Handlers

  it 'adds a child suite', ->
    childSuite = new BDD.Suite('child')
    result = suite.add(childSuite)
    expect(result).to.equal childSuite
    expect(childSuite.parent).to.equal suite
    expect(suite.children.length).to.equal 1
    expect(suite.children[0]).to.equal childSuite



describe 'Suite (Dispose)', ->
  it 'disposes of a suite', ->
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



