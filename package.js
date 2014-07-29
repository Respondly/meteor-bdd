Package.describe({
  summary: 'A runnable BDD suite/spec hierarhcy from describe/it statements.'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'sugar']);
  api.use(['util']);
  api.export('BDD');
  api.export(['describe', 'it', 'before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('shared/api.coffee', ['client', 'server']);
  api.add_files('shared/models/method.coffee', ['client', 'server']);
  api.add_files('shared/models/spec.coffee', ['client', 'server']);
  api.add_files('shared/models/suite.coffee', ['client', 'server']);
  api.add_files('shared/describe.coffee', ['client', 'server']);

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use(['bdd', 'util']);

  // Generated with: github.com/philcockfield/meteor-package-paths
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/describe.coffee', ['client', 'server']);
  api.add_files('tests/shared/find.coffee', ['client', 'server']);
  api.add_files('tests/shared/method.coffee', ['client', 'server']);
  api.add_files('tests/shared/run.coffee', ['client', 'server']);
  api.add_files('tests/shared/spec.coffee', ['client', 'server']);
  api.add_files('tests/shared/suite-section.coffee', ['client', 'server']);
  api.add_files('tests/shared/suite.coffee', ['client', 'server']);

});
