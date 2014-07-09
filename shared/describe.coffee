###
###

_currentSuite = null



###
Declares a test Suite.  For example:

      describe 'my suite name', ->
        it 'does something', ->
          expect(true).to.equal true


@param name: The name/description of the suite.
@param func: The suite function.

@returns the resulting [Suite] object.
###
describe = BDD.describe = (name, func) ->
  # Setup initial conditions.
  isRoot = not _currentSuite?
  startingSuite = _currentSuite ?= BDD.suite
  name = 'Untitled' if Util.isBlank(name)

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



###
Declares a "spec" (test specification).
@param name: The name/descripion of the test.
@param func: The test function.
###
it = (name, func) ->
  suite = _currentSuite ? BDD.suite
  spec = suite.add(new BDD.Spec(name, func))
  spec



