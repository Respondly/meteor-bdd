Package.describe({
  summary: 'A runnable BDD suite/spec hierarhcy from describe/it statements.'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'sugar']);
  api.use(['util']);
  api.export('BDD');
  api.export(['describe', 'it']);
  api.export(['before', 'beforeEach', 'afterEach', 'after']);

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('shared/api.coffee', ['client', 'server']);
  api.add_files('shared/models/spec.coffee', ['client', 'server']);
  api.add_files('shared/models/suite.coffee', ['client', 'server']);
  api.add_files('shared/describe.coffee', ['client', 'server']);

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use(['bdd', 'util']);

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/describe-test.coffee', ['client', 'server']);
  api.add_files('tests/shared/spec-run-test.coffee', ['client', 'server']);
  api.add_files('tests/shared/spec-test.coffee', ['client', 'server']);
  api.add_files('tests/shared/suite-test.coffee', ['client', 'server']);

});
