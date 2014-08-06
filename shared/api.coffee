#= base
#= require ./ns.js
BDD = {} unless BDD?


###
Resets the global state and clears the set of suites.
###
BDD.reset = ->
  BDD.suite = new BDD.Suite()
  INTERNAL.beforeDescribe?.clear()
  INTERNAL.beforeIt?.clear()


