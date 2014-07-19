Test.run 'Spec (class)',
  tearDown: -> BDD.reset()
  tests:
    'is an instance of [Method]': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec).to.be.an.instanceOf BDD.Method


    'has a name (description)': (test) ->
      fn = ->
      method = new BDD.Spec('does something', fn)
      expect(method.name).to.equal 'does something'
      expect(method.func).to.equal fn


    'has a unique ID as a hash of the name/description': (test) ->
      spec = new BDD.Spec('does something', ->)
      expect(spec.id).to.equal Util.hash('does something')



Test.run 'Spec.run (beforeEach | afterEach)',
  tearDown: -> BDD.reset()
  tests:
    'runs the beforeEach/afterAfter methods around a spec': (test) ->
      items = []
      push = (key, context) -> items.push({ key:key, context:context})
      suite = describe 'my suite', ->
                beforeEach -> push('beforeEach', @)
                it 'spec', -> push('spec', @)
                afterEach -> push('afterEach', @)

      context = { foo:123 }
      suite.specs()[0].run(this:context)

      expect(items[0].key).to.equal 'beforeEach'
      expect(items[0].context).to.equal context
      expect(items[1].key).to.equal 'spec'
      expect(items[1].context).to.equal context
      expect(items[2].key).to.equal 'afterEach'
      expect(items[2].context).to.equal context



    'runs beforeEach/afterAfter methods in parent suite': (test) ->
      items = []
      gradeParentSuite = describe 'grand-parent', ->
                          beforeEach -> items.push('grand-parent:beforeEach')
                          describe 'parent', ->
                            beforeEach -> items.push('parent:beforeEach')
                            describe 'child', ->
                                  beforeEach -> items.push('child:beforeEach')
                                  it 'spec', -> items.push('child:spec')
                                  afterEach -> items.push('child:afterEach')
                            afterEach -> items.push('parent:afterEach')
                          afterEach -> items.push('grand-parent:afterEach')

      parentSuite = gradeParentSuite.children()[0]
      childSuite = parentSuite.children()[0]
      spec = childSuite.specs()[0]

      spec.run()

      expect(items[0]).to.equal 'grand-parent:beforeEach'
      expect(items[1]).to.equal 'parent:beforeEach'
      expect(items[2]).to.equal 'child:beforeEach'
      expect(items[3]).to.equal 'child:spec'
      expect(items[4]).to.equal 'child:afterEach'
      expect(items[5]).to.equal 'parent:afterEach'
      expect(items[6]).to.equal 'grand-parent:afterEach'






