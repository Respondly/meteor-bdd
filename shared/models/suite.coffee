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
    @before     = []
    @beforeEach = []
    @after      = []
    @afterEach  = []


  ###
  Destroyes the Suite.
  ###
  dispose: ->
    child.dispose() for child in @children
    @isDisposed = true



  ###
  Adds a child-suite or spec.
  @param value: A [Suite] or a [Spec].
  ###
  add: (value) ->
    # Add Suite.
    if (value instanceof BDD.Suite)
      value.parent = @
      @children.push(value)

    # Add Spec.
    else if (value instanceof BDD.Spec)
      value.parent = @
      @specs.push(value)

    else
      throw new Error('Type not supported.')

    # Finish up.
    return value





# ----------------------------------------------------------------------



###
Resets the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite('root')



# INITIALIZE ----------------------------------------------------------------------

BDD.reset()