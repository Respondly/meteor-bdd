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
  @param context:     The context within which to run (or null).
  @param done(err):   (Optional) A callback to invoke upon completion.
                                 An error if one occured (including timeout).
  ###
  run: (context, done) ->
    # Setup initial conditions.
    parentSuite = @parent

    runHandlers = (action, methods, next) ->
        if Object.isArray(methods)
          BDD.Method.runMany methods, context, (result) ->
            if result.hasError
              # Invoke overall callback without continuing.
              err = new Error("#{action} resulted in error")
              err.errors = result.errors
              done?(err)
            else
              next()
        else
          next() # No methods.

    # Run the [beforeEach] => [Spec] => [afterEach] methods.
    runHandlers 'beforeEach', parentSuite?.beforeEach, =>
      BDD.Method.run @, context, (err) =>
          if err?
            done?(err) # Failed on spec, don't continue.
          else
            runHandlers 'afterEach', parentSuite?.afterEach, => done?(null)



