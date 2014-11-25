Package.describe({
  name: 'respondly:bdd',
  summary: 'A runnable BDD suite/spec hierarhcy from describe/it statements.',
  version: '0.0.1',
  git: 'https://github.com/Respondly/meteor-bdd.git'
});



Package.on_use(function (api) {
  api.use('coffeescript');
  api.use('respondly:util');
  api.export('BDD');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/ns.js', ['client', 'server']);
  api.add_files('shared/bdd.coffee', ['client', 'server']);
  api.add_files('shared/models/method.coffee', ['client', 'server']);
  api.add_files('shared/models/spec.coffee', ['client', 'server']);
  api.add_files('shared/models/suite.coffee', ['client', 'server']);
  api.add_files('shared/describe.coffee', ['client', 'server']);

});



Package.on_test(function (api) {
  api.use(['mike:mocha-package@0.4.7', 'coffeescript']);
  api.use(['respondly:bdd', 'respondly:util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/bdd.coffee', ['client', 'server']);
  api.add_files('tests/shared/describe.coffee', ['client', 'server']);
  api.add_files('tests/shared/find.coffee', ['client', 'server']);
  api.add_files('tests/shared/it.coffee', ['client', 'server']);
  api.add_files('tests/shared/method.coffee', ['client', 'server']);
  api.add_files('tests/shared/run.coffee', ['client', 'server']);
  api.add_files('tests/shared/spec.coffee', ['client', 'server']);
  api.add_files('tests/shared/suite.coffee', ['client', 'server']);

});
