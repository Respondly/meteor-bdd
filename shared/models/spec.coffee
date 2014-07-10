
window?.onerror = (msg, url, line) -> console.log 'error', args


###
Represents a single spec/test.
###
class BDD.Spec
  ###
  Constructor.
  @param name: The name/description of the spec.
  @param func:  The test function.
                A function with no parameters is considered synchronous.
                A function with a parameter is considered an async callback, eg:

                    (done) -> # Callback.

  ###
  constructor: (@name, @func) ->
    @parent  = null # The parent [Suite].
    @isAsync = Util.params(@func).length > 0
    @timeout = 5000



  ###
  Invokes the test function.
  @param context:     (Optional) The context within which to run.
  @param done(err):   (Optional) A callback to invoke upon completion.
                                 An error if one occured (including timeout).
  ###
  run: (context, done) ->
    # Setup initial conditions.
    return unless Object.isFunction(@func)
    context ?= @

    if @isAsync
      # Start timeout.
      Util.delay @timeout, =>
            if Object.isFunction(done)
              done(new Error('Timed out'))
              done = null # Ensure the callback cannot be invoked again.

      # Invoke async function.
      try
        @func.call context, -> done?(null)
      catch e
        console?.error(e)
        done?(e)

    else
      # Invoke synchronously.
      try
        @func.call(context)
        done?(null)
      catch e
        console?.error(e)
        done?(e)















