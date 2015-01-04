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
    @parent = null # The parent Suite.
    PKG.specCreatedHandlers.invoke(@)



  ###
  Creates a string representation of the Spec.
  ###
  toString: ->
    result = "[SPEC:#{ @name ? 'Unnamed' }]"
    if @parent?
      index = @parent.specs().indexOf(@)
      result = "#{ @parent.toString() }->#{ result }[#{ index }]"
    result


  ###
  The unique ID of the Spec within the suite.
  ###
  uid: -> "#{ Util.hash(@toString()) }"


  ###
  Invokes the test function.
  @param options:     (Optional)
                         - this:    The [this] context to run the method with.
                         - throw:   Flag indicating if errors should be thrown.
                                    Default:false
  @param done(err, result): (Optional) A callback to invoke upon completion.
                             An error if one occured (including timeout).
  ###
  run: (options = {}, done) ->
    # Setup initial conditions.
    parentSuite = @parent
    if Object.isFunction(options)
      done = options
      options = {}
    options.this ?= { spec:@ }

    # Run the global [BDD.beforeIt] handers.
    PKG.beforeIt.invoke(options.this)

    runHandlers = (action, methods, next) ->
        if Object.isArray(methods)
          BDD.runMany methods, options, (result) ->
            if result.hasError
              # Invoke overall callback without continuing.
              err = new Error("#{action} resulted in error")
              err.errors = result.errors
              done?(err)
            else
              next()
        else
          next() # No methods.

    # Retrieve the [beforeEach / afterEach] handlers for the
    # the entire suite hierarchy.
    beforeEachHandlers = parentSuite.getBeforeEach(true)
    afterEachHandlers = parentSuite.getAfterEach(true)

    # Run the [beforeEach] => [Spec] => [afterEach] methods.
    runHandlers 'beforeEach', beforeEachHandlers, =>
      BDD.run @, options, (err, result) =>
          if err?
            done?(err) # Failed on spec, don't continue.
          else
            runHandlers 'afterEach', afterEachHandlers, =>
              done?(null, result)



