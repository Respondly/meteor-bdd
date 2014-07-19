#= require ./method

###
Represents a single spec/test.
###
class BDD.Spec extends BDD.Method
  ###
  Constructor.
  @param name: The name/description of the spec.
  @param func:  The function.
                A function with no parameters is considered synchronous.
                A function with a parameter is considered an async callback, eg:

                    (done) -> # Callback.

  ###
  constructor: (@name, @func) ->
    super @func
    @id = Util.hash(@name) if Object.isString(@name)
    @parent = null # The parent Suite.



  ###
  Invokes the test function.
  @param options:     (Optional)
                         - this:    The [this] context to run the method with.
                         - throw:   Flag indicating if errors should be thrown.
                                    Default:false
  @param done(err):   (Optional) A callback to invoke upon completion.
                                 An error if one occured (including timeout).
  ###
  run: (options, done) ->
    # Setup initial conditions.
    parentSuite = @parent

    runHandlers = (action, methods, next) ->
        if Object.isArray(methods)
          BDD.Method.runMany methods, options, (result) ->
            if result.hasError
              # Invoke overall callback without continuing.
              err = new Error("#{action} resulted in error")
              err.errors = result.errors
              done?(err)
            else
              next()
        else
          next() # No methods.

    # Walk up the hierarchy of suites building the list of
    # before/after methods for the spec.
    getHandlers = (key, suite) ->
            result = []
            if suite?
              if parent = suite.parent
                result.push getHandlers(key, parent)
              result.push(suite[key])
            result.flatten()

    beforeEachHandlers = getHandlers('beforeEach', parentSuite)
    afterEachHandlers  = getHandlers('afterEach', parentSuite).reverse()

    # Run the [beforeEach] => [Spec] => [afterEach] methods.
    runHandlers 'beforeEach', beforeEachHandlers, =>
      BDD.Method.run @, options, (err) =>
          if err?
            done?(err) # Failed on spec, don't continue.
          else
            runHandlers 'afterEach', afterEachHandlers, => done?(null)



