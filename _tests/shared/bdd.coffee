Test.run 'BDD (created handlers)',
  tearDown: -> BDD.reset()

  tests:
    'invokes [BDD.suiteCreated] at construction': (test) ->
      arg = null
      BDD.suiteCreated (args...) -> arg = args[0]
      suite = new BDD.Suite('foo')
      expect(arg).to.equal suite


    'invokes [BDD.specCreated] at construction': (test) ->
      arg = null
      BDD.specCreated (args...) -> arg = args[0]
      spec = new BDD.Spec('foo', -> )
      expect(arg).to.equal spec


    'clears all handlers upon reset': (test) ->
      count = 0
      BDD.suiteCreated -> count += 1
      BDD.specCreated -> count += 1
      BDD.reset()
      new BDD.Suite('foo')
      new BDD.Spec('foo', -> )
      expect(count).to.equal 0

