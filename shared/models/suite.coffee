###
Represents a suite of specs.
###
Suite = class BDD.Suite
  ###
  Constructor.
  @param name:    The name/description of the suite.
  ###
  constructor: (@name) ->
    @parent     = null
    @items      = [] # Specs and child Suites.
    @before     = []
    @beforeEach = []
    @after      = []
    @afterEach  = []


  ###
  Destroyes the Suite.
  ###
  dispose: ->
    child.dispose() for child in @suites()
    @isDisposed = true



  ###
  Creates a string representation of the Suite.
  ###
  toString: -> Suite.toString(@name, @parent)


  ###
  The unique ID of the Suite.
  ###
  uid: -> Suite.toUid(@name, @parent)



  ###
  Retrieves the array of child Suites.
  ###
  suites: -> @items.filter (item) -> item instanceof BDD.Suite


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
  Searches the suite for any matching child-suites or specs.
  @param query:
            - uid: The unique ID of the suite/spec to find.
  @returns array [Suite | Spec]
  ###
  find: (query = {}) ->
    result = []
    if uid = query.uid
      return [ findByUid(uid, @) ].compact()

    else
      [] # No matches.


  ###
  Returns the first item of a search.
  @param query: See "find" method.
  @returns a single object, or null
  ###
  findOne: (query) -> @find(query)[0] ? null


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



findByUid = (uid, suite) ->
  if suite
    for item in suite.items
      return item if item.uid() is uid
      if (item instanceof BDD.Suite)
        if resultFromChild = findByUid(uid, item) # <== RECURSION.
          return resultFromChild




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
Generates the unique ID of the suite.
@param name:   The name/description of the suite.
@param parent: (Optional) The parent Suite
###
Suite.toUid = (name, parent) -> "#{ Util.hash(Suite.toString(name, parent)) }"




###
Generates a deep string representation of the Suite.
@param name:   The name/description of the suite.
@param parent: (Optional) The parent Suite
###
Suite.toString = (name, parent) ->
    items = [name ? 'root']
    walk = (suite) ->
        if suite
          items.push(suite.name ? 'root')
          walk(suite.parent) if suite.parent?
    walk(parent)
    "[SUITE:#{ items.reverse().join('::') }]"



# ----------------------------------------------------------------------


###
Resets the set of suites.
###
BDD.reset = -> BDD.suite = new BDD.Suite()
BDD.reset() # Init.


