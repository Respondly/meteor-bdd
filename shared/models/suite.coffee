###
Represents a suite of specs.
###
class BDD.Suite
  ###
  Constructor.
  @param name: The name/description of the suite.
  ###
  constructor: (@name) ->
    @parent     = null
    @children   = []
    @specs      = []
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
    if (value instanceof BDD.Suite)
      value.parent = @
      @children.push(value)

    # TODO - Add Spec in the same way as a Suite.
    else if (value instanceof BDD.Spec)
      value.parent = @
      @specs.push(value)

    else
      throw new Error('Type not supported.')

    return value





# ----------------------------------------------------------------------



###
Resets the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite('root')



# INITIALIZE ----------------------------------------------------------------------

BDD.reset()