_currentSuite = null




###
Declares a test Suite.
@param name: The name/description of the suite.
@param func: The test function.
###
BDD.describe = (name, func) ->

  # Setup initial conditions.
  isRoot = not _currentSuite?
  startingSuite = _currentSuite ?= BDD.suite

  # console.log '_currentSuite', _currentSuite

  # Create the new suite.
  suite = new BDD.Suite(name)
  suite.parent = _currentSuite
  _currentSuite.children.push(suite)
  _currentSuite = suite

  # Configure the suite.
  if Object.isFunction(func)
    func()



  # Finish up.
  result = _currentSuite
  _currentSuite = if isRoot then null else startingSuite
  result


