###
Represents a suite of specs.
###
Suite = class BDD.Suite
  ###
  Constructor.
  @param name: The name/description of the suite.
  ###
  constructor: (@name) ->
    @children   = []
    @parent     = null
    @before     = new Handlers()
    @beforeEach = new Handlers()
    @after      = new Handlers()
    @afterEach  = new Handlers()


  ###
  Destroyes the Suite.
  ###
  dispose: ->
    child.dispose() for child in @children
    @before.dispose()
    @beforeEach.dispose()
    @after.dispose()
    @afterEach.dispose()
    @isDisposed = true



  ###
  Adds a child-suite or spec.
  @param value: A [Suite] or a [Spec].
  ###
  add: (value) ->
    if (value instanceof Suite)
      value.parent = @
      @children.push(value)
      value

    # TODO - Add Spec in the same way as a Suite.

    else
      throw new Error('Type not supported.')





# ----------------------------------------------------------------------



###
Resets the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite('root')



# INITIALIZE ----------------------------------------------------------------------

BDD.reset()