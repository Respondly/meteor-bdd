@expect = chai.expect

# SEE: Real tests in `_tests` folder.
console.log 'Dummy Test (to ensure CI runs)'

describe 'BDD:DummyTest', ->
  it 'does nothing', ->
    expect(true).to.equal true