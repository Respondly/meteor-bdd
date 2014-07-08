describe 'Suite (class)', ->
  it 'has default values upon construction', ->
    suite = new BDD.Suite('foo')
    expect(suite.name).to.equal 'foo'
    expect(suite.children).to.eql []

  it 'has a root [Suite] instance on the BDD namespace', ->
    expect(BDD.suite).to.be.an.instanceOf BDD.Suite
    expect(BDD.suite.name).to.equal 'root'
