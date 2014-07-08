describe 'Spec (class)', ->
  it 'has default values upon construction', ->
    spec = new BDD.Spec('does something')
    expect(spec.name).to.equal 'does something'
