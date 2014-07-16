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
