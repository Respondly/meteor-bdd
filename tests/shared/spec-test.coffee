describe 'Spec (class)', ->
  it 'has default values upon construction', ->
    fn = ->
    spec = new BDD.Spec('does something', fn)
    expect(spec.name).to.equal 'does something'
    expect(spec.func).to.equal fn

