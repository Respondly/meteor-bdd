###
Represents a suite of specs.
###
class BDD.Suite
  constructor: (@name) ->
    @children   = []
    @parent     = null
    @before     = new Handlers()
    @beforeEach = new Handlers()
    @after      = new Handlers()
    @afterEach  = new Handlers()






# ----------------------------------------------------------------------



###
Resets the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite('root')



# INITIALIZE ----------------------------------------------------------------------

BDD.reset()