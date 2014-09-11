_currentSuite = null
beforeDescribe = PKG.beforeDescribe = new Handlers()
beforeIt = PKG.beforeIt = new Handlers()


###
Registers a handler to run immediately before the
"describe" function is run.

  Example:

      BDD.beforeDescribe (context) ->
          context.myHelper = (value) -> # A custom extension to the context.

      describe 'suite', ->
        @myHelper('foo')



@param func(context): The function to run.
                      [context] parameter is the object
                      that will be passed to the describe function.
                      Modify this object, to have custom context
                      for the describe function to use.
###
BDD.beforeDescribe = (func) -> beforeDescribe.push(func)



###
Registers a handler to run immediately before the
"it" function is run.

@param func(context): The function to run.
                      [context] parameter is the object
                      that will be passed to the describe function.
                      Modify this object, to have custom context
                      for the describe function to use.
###
BDD.beforeIt = (func) -> beforeIt.push(func)


# ----------------------------------------------------------------------


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
    suite = _currentSuite.addSuite(new BDD.Suite(name))
  _currentSuite = suite

  # Configure the suite.
  if Object.isFunction(func)
    context = { suite: suite }
    beforeDescribe.invoke(context)
    func.call(context)

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
it = (name, func) -> getSuite()?.addSpec(new BDD.Spec(name, func))


# ----------------------------------------------------------------------


###
Registers a function to run "before all" specs within the suite.
@param func: The function to run.
###
before = (func) -> getSuite()?.addBefore(func)


###
Registers a function to run "before each" spec within the suite.
@param func: The function to run.
###
beforeEach = (func) -> getSuite()?.addBeforeEach(func)


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
afterEach = (func) -> getSuite()?.addAfterEach(func)


###
Registers a function to run "after all" specs within the suite.
@param func: The function to run.
###
after = (func) -> getSuite()?.addAfter(func)




# PRIVATE ----------------------------------------------------------------------


getSuite = -> _currentSuite ? BDD.suite



