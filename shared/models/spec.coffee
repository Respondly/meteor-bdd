#= require ./method

###
Represents a single spec/test.
###
class BDD.Spec extends BDD.Method
  constructor: (@name, @func) ->
    super
