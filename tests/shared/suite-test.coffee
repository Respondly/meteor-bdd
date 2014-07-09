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


