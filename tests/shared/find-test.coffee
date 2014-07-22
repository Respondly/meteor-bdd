suite = null


Test.run 'Find',
  tearDown: -> BDD.reset()
  setup: ->
    suite = describe 'suite-1', ->
      describe 'suite-2a', ->
      describe 'suites-2b', ->
        it 'spec-1', ->
        it 'spec-2', ->

      it 'spec-1', ->

      describe 'suites2-c', ->
        describe 'suite3', ->
          it 'spec-1', ->
          it 'spec-2', ->



  tests:
    'finds no matches': (test) ->
      expect(suite.find()).to.eql []
      expect(suite.find(null)).to.eql []
      expect(suite.find({})).to.eql []


    'does not match the Suite being called': (test) ->
      expect(suite.find(uid:suite.uid())).to.eql []


    'does not match a parent suite': (test) ->
      expect(suite.find(uid:suite.parent.uid())).to.eql []


    'matches an immediate child-suite': (test) ->


