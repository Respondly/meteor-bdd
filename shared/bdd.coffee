#= base
#= require ./ns.js
BDD = {} unless BDD?



###
Resets the global state and clears the set of suites.
###
BDD.reset = ->
  PKG.beforeDescribe?.clear()
  PKG.beforeIt?.clear()
  PKG.suiteCreatedHandlers.clear()
  PKG.specCreatedHandlers.clear()
  BDD.suite = new BDD.Suite()



# ----------------------------------------------------------------------


###
Registers a handler to invoke each time
a [Suite] is created.
@param func: The function to invoke.
###
BDD.suiteCreated = (func) -> PKG.suiteCreatedHandlers.push(func)
PKG.suiteCreatedHandlers = new Handlers()



###
Registers a handler to invoke each time
a [Spec] is created.
@param func: The function to invoke.
###
BDD.specCreated = (func) -> PKG.specCreatedHandlers.push(func)
PKG.specCreatedHandlers = new Handlers()

