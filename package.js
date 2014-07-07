Package.describe({
  summary: 'A runnable BDD suite/spec hierarhcy from describe/it statements.'
});



Package.on_use(function (api) {
  api.use(['coffeescript', 'sugar']);
  api.use(['util']);
  api.export('BDD')

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('shared/api.coffee', ['client', 'server']);

});



Package.on_test(function (api) {
  api.use(['munit', 'coffeescript', 'chai']);
  api.use('bdd-runner');

  // Generated with: github.com/philcockfield/meteor-package-loader
  api.add_files('tests/shared/_init.coffee', ['client', 'server']);
  api.add_files('tests/shared/bdd-runner-test.coffee', ['client', 'server']);

});
