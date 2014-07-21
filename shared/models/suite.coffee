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
    @items      = [] # Specs and child Suites.
    @before     = []
    @beforeEach = []
    @after      = []
    @afterEach  = []
    @id = Util.hash(@name) if Object.isString(@name)


  ###
  Destroyes the Suite.
  ###
  dispose: ->
    child.dispose() for child in @children()
    @isDisposed = true



  ###
  Retrieves the array of child Suites.
  ###
  children: -> @items.filter (item) -> item instanceof BDD.Suite


  ###
  Retrieves the array of Specs.
  ###
  specs: -> @items.filter (item) -> item instanceof BDD.Spec



  ###
  Adds a child-suite or spec.
  @param value: A [Suite] or a [Spec].
  ###
  add: (value) ->
    # Add Suite.
    if (value instanceof BDD.Suite)
      value.parent = @
      @items.push(value)

    # Add Spec.
    else if (value instanceof BDD.Spec)
      value.parent = @
      @items.push(value)

    else
      throw new Error('Type not supported.')

    # Finish up.
    return value


  ###
  Retrieves the set of [before] handlers for the entire suite heirarchy.
  ###
  getBefore: (deep = false) -> getHandlers(@, 'before', deep)

  ###
  Retrieves the set of [beforeEach] handlers for the entire suite heirarchy.
  ###
  getBeforeEach: (deep = false) -> getHandlers(@, 'beforeEach', deep)

  ###
  Retrieves the set of [afterEach] handlers for the entire suite heirarchy.
  ###
  getAfterEach: (deep = false) -> getHandlers(@, 'afterEach', deep).reverse()

  ###
  Retrieves the set of [after] handlers for the entire suite heirarchy.
  ###
  getAfter: (deep = false) -> getHandlers(@, 'after', deep).reverse()




# PRIVATE ----------------------------------------------------------------------




getHandlers = (suite, key, deep) ->
  if deep
    getHandlersDeep(suite, key)
  else
    suite[key]


getHandlersDeep = (suite, key) ->
        result = []
        if suite?
          if parent = suite.parent
            result.push getHandlersDeep(parent, key)
          result.push(suite[key])
        result.flatten()



# CLASS METHODS ----------------------------------------------------------------------



###
Resets the set of suites.
###
BDD.reset = -> BDD.suite = new BDD.Suite('root')
BDD.reset() # Init.

