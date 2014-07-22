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
          describe 'suite4-a', ->
          describe 'suite4-b', ->
          describe 'suite4-c', ->




  tests:
    'finds no matches': (test) ->
      expect(suite.find()).to.eql []
      expect(suite.find(null)).to.eql []
      expect(suite.find({})).to.eql []
      expect(suite.find({ uid:'foo' })).to.eql []


    'finds no matches (findOne)': (test) ->
      expect(suite.findOne()).to.equal null
      expect(suite.findOne(null)).to.equal null
      expect(suite.findOne({})).to.equal null
      expect(suite.findOne({ uid:'foo' })).to.equal null


    'does not match the Suite being called': (test) ->
      expect(suite.find(uid:suite.uid())).to.eql []


    'does not match a parent Suite': (test) ->
      expect(suite.find(uid:suite.parent.uid())).to.eql []


    # ----------------------------------------------------------------------


    'matches an immediate child Suite': (test) ->
      childSuite = suite.suites()[1]
      expect(suite.find(uid:childSuite.uid())).to.eql [childSuite]


    # ----------------------------------------------------------------------


    'matches a deeply descendent Suite': (test) ->
      descendentSuite = suite.suites()[2].suites()[0].suites()[1]
      expect(suite.find(uid:descendentSuite.uid())).to.eql [descendentSuite]

    'matches a deeply descendent Suite (findOne)': (test) ->
      descendentSuite = suite.suites()[2].suites()[0].suites()[1]
      expect(suite.findOne(uid:descendentSuite.uid())).to.equal descendentSuite


    # ----------------------------------------------------------------------


    'matches an immediate child Spec': (test) ->
      spec = suite.specs()[0]
      expect(suite.find(uid:spec.uid())).to.eql [spec]


    'matches a deeply descendent Spec': (test) ->
      spec = suite.suites()[2].suites()[0].specs()[1]
      expect(suite.find(uid:spec.uid())).to.eql [spec]


    'matches a deeply descendent Spec (findOne)': (test) ->
      spec = suite.suites()[2].suites()[0].specs()[1]
      expect(suite.findOne(uid:spec.uid())).to.equal spec


