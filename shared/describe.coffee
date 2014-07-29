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

  # Get the Suite.
  uid = BDD.Suite.toUid(name, _currentSuite)
  if existingSuite = BDD.suite.findOne(uid:uid)
    # An existing suite with this name/hierarchy already exists
    # Append to this suite.
    suite = existingSuite
  else
    # Create the new suite.
    suite = _currentSuite.add(new BDD.Suite(name))
  _currentSuite = suite

  # Configure the suite.
  func() if Object.isFunction(func)

  # Finish up.
  result = _currentSuite
  _currentSuite = if isRoot then null else startingSuite
  result



###
Declares a child Suite as a "section".
NOTE: This is used for display purposes in some test runners.

@param name: The name/description of the suite.
@param func: The suite function.

@returns the resulting [Suite] object.
###
describe.section = (name, func) ->
  suite = describe(name, func)
  suite.isSection = true
  suite


# ----------------------------------------------------------------------


###
Declares a "spec" (test specification).
@param name: The name/descripion of the test.
@param func: The test function.
###
it = (name, func) -> getSuite()?.add(new BDD.Spec(name, func))


# ----------------------------------------------------------------------


###
Registers a function to run "before all" specs within the suite.
@param func: The function to run.
###
before = (func) -> getSuite()?.before.push(new BDD.Method(func))


###
Registers a function to run "before each" spec within the suite.
@param func: The function to run.
###
beforeEach = (func) -> getSuite()?.beforeEach.push(new BDD.Method(func))


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
afterEach = (func) -> getSuite()?.afterEach.push(new BDD.Method(func))


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
after = (func) -> getSuite()?.after.push(new BDD.Method(func))




# PRIVATE ----------------------------------------------------------------------


getSuite = -> _currentSuite ? BDD.suite



