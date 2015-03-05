Package.describe({
  name: 'respondly:bdd',
  summary: 'A runnable BDD suite/spec hierarhcy from describe/it statements.',
  version: '1.0.1',
  git: 'https://github.com/Respondly/meteor-bdd.git'
});



Package.onUse(function (api) {
  // api.versionsFrom('1.0');
  api.use('coffeescript');
  api.use('respondly:util@1.0.1');
  api.export('BDD');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('shared/ns.js', ['client', 'server']);
  api.addFiles('shared/bdd.coffee', ['client', 'server']);
  api.addFiles('shared/models/method.coffee', ['client', 'server']);
  api.addFiles('shared/models/spec.coffee', ['client', 'server']);
  api.addFiles('shared/models/suite.coffee', ['client', 'server']);
  api.addFiles('shared/describe.coffee', ['client', 'server']);

});




  /*
     NOTE: main _test folder has been commented out for now.
     need to solve naming conflict at some point (bdd and mocha both
     use it/describe)
  */



Package.onTest(function(api){
  api.use(['mike:mocha-package@0.5.6', 'coffeescript']);
  api.use(['respondly:bdd', 'respondly:util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.addFiles('tests/shared/dummy.coffee', ['client', 'server']);

});


// Package.onTest(function (api) {
//   api.use(['mike:mocha-package@0.5.6', 'coffeescript']);
//   api.use(['respondly:bdd', 'respondly:util']);