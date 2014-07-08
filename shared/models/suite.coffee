

###
Represents a suite of specs.
###
class BDD.Suite
  constructor: (@name) ->
    @children = []
    @parent = null






# ----------------------------------------------------------------------


###
Resets the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite('root')


# INIT
BDD.reset()