#= base
#= require ./ns.js
BDD = {} unless BDD?



###
Resets the global state and clears the set of suites.
###
BDD.reset = ->
  INTERNAL.beforeDescribe?.clear()
  INTERNAL.beforeIt?.clear()
  INTERNAL.suiteCreatedHandlers.clear()
  INTERNAL.specCreatedHandlers.clear()
  BDD.suite = new BDD.Suite()



# ----------------------------------------------------------------------


###
Registers a handler to invoke each time
a [Suite] is created.
@param func: The function to invoke.
###
BDD.suiteCreated = (func) -> INTERNAL.suiteCreatedHandlers.push(func)
INTERNAL.suiteCreatedHandlers = new Handlers()



###
Registers a handler to invoke each time
a [Spec] is created.
@param func: The function to invoke.
###
BDD.specCreated = (func) -> INTERNAL.specCreatedHandlers.push(func)
INTERNAL.specCreatedHandlers = new Handlers()

