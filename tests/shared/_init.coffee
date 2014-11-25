@expect = chai.expect
@Test = {}


if Meteor.isClient
  Meteor.startup -> $('title').html('Tests: BDD')




# ###
# Runs an Munit suite.

#   NOTE: Tests are decalred using objects for [Munit] rather that
#         [describe/it] statements beause the BDD package itself
#         overrides these exported function names.

# ###
# Test.run = (name, suite = {}) ->
#   suite.name ?= name
#   try
#     Munit.run(suite)
#   catch err
#     console.error(err.stack)
#   suite
