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

  # Create the new suite.
  suite = _currentSuite.add(new BDD.Suite(name))
  _currentSuite = suite

  # Configure the suite.
  if Object.isFunction(func)
    func()



  # Finish up.
  result = _currentSuite
  _currentSuite = if isRoot then null else startingSuite
  result


