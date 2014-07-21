###
Represents an executable method.
###
class BDD.Method
  ###
  Constructor.
  @param func:  The function.
                A function with no parameters is considered synchronous.
                A function with a parameter is considered an async callback, eg:

                    (done) -> # Callback.

  ###
  constructor: (@func) ->
    @parent  = null # The parent [Suite].
    @isAsync = Util.params(@func).length > 0
    @timeout = 5000



  ###
  Invokes the test function.
  @param options:     (Optional)
                         - this:    The [this] context to run the method with.
                         - throw:   Flag indicating if errors should be thrown.
                                    Default:false
  @param done(err):   (Optional) A callback to invoke upon completion.
                                 An error if one occured (including timeout).
  ###
  run: (options, done) -> BDD.Method.run(@, options, done)




# CLASS METHODS ----------------------------------------------------------------------


###
Invokes a collection of methods.
@param methods:         The set of Method objects.
@param options:         (Optional)
                         - this:    The [this] context to run the method with.
                         - throw:   Flag indicating if errors should be thrown.
                                    Default:false
@param done(result):    A callback to invoke upon completion.
                        The result is an object:
                          - errors: An array of errors that occured.

###
BDD.Method.runMany = (methods, options, done) ->
  # Setup initial conditions.
  methods = [] unless Object.isArray(methods)
  completedCount = 0
  result =
    errors:[]

  onCompleted = ->
        done?(result)
        done = null # Prevent any further callbacks (edge-case).

  return onCompleted() if methods.length is 0

  onMethodCallback = (method, err) ->
        completedCount += 1
        if err?
          result.errors.push { method:method, error:err }
          result.hasError = true

        if completedCount is methods.length
          onCompleted()

  for method in methods
    do (method) ->
      BDD.Method.run(method, options, (err) -> onMethodCallback(method, err))





###
Invokes a set of methods.
@param method:          The [Method] object.
@param options:         (Optional)
                          - this:    The [this] context to run the method with.
                          - throw:   Flag indicating if errors should be thrown.
                                     Default:false
@param done(err):       A callback to invoke upon completion.
                          - err: An error if one occured (including timeout).
###
BDD.Method.run = (method, options = {}, done) ->
  # Setup initial conditions.
  if Object.isFunction(options)
    done = options
    options = {}
  context = options.this
  context ?= method
  if not (method instanceof BDD.Method)
    throw new Error('Not a [Method] object')

  # Ensure the method is executable.
  if not Object.isFunction(method.func)
    done?(null)
    return

  onError = (err) ->
      if options.throw is true
        throw err
      else
        done?(err)

  # Run the method.
  if method.isAsync
    # Start timeout.
    timer = Util.delay method.timeout, =>
          if Object.isFunction(done)
            done(new Error('Timed out'))
            done = null # Ensure the callback cannot be invoked again.

    # Invoke async function.
    try
      method.func.call context, ->
          timer.stop()
          done?(null)
    catch e
      onError(e)

  else
    # Invoke synchronously.
    try
      method.func.call(context)
      done?(null)
    catch e
      onError(e)





