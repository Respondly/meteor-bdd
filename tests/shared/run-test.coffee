Test.run 'run order',
  setup: ->
  tearDown: ->
  tests:
    'it runs suite: before => specs => after': (test) ->

      suite = describe 'suite', ->
                before ->
                beforeEach ->

                it 'one', ->
                it 'two', ->

                afterEach ->
                after ->



