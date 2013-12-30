describe("Midway: Testing Controllers and Router", function() {

  var tester;
  beforeEach(function() {
    if(tester) {
      tester.destroy();
    }
    tester = ngMidwayTester('ChekhovApp');
  });

  it('should load the templates_index.html partial properly when / route is accessed', function(done) {
    tester.visit('/', function() {
      tester.path().should.eq('/');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/templates_index.html');
      tester.destroy();
      done();
    });
  });

  it('should load the templates_active.html partial when /active route is accessed', function(done) {
    tester.visit('/active', function() {
      tester.path().should.eq('/active');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/templates_active.html');
      tester.destroy();
      done();
    });
  });

  it('should load the templates_archived.html partial when /archived route is accessed', function(done) {
    tester.visit('/archived', function() {
      tester.path().should.eq('/archived');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/templates_archived.html');
      tester.destroy();
      done();
    });
  });

  it('should load the template_new.html partial when /templates/new route is accessed', function(done) {
    tester.visit('/templates/new', function() {
      tester.path().should.eq('/templates/new');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/template_new.html');
      tester.destroy();
      done();
    });
  });

  it('should load the template_edit.html partial when /templates/edit/:id route is accessed', function(done) {
    tester.visit('/templates/edit/1', function() {
      tester.path().should.eq('/templates/edit/1');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/template_edit.html');
      tester.destroy();
      done();
    });
  });

  it('should load the template_new.html partial when /templates/duplicate/:id route is accessed', function(done) {
    tester.visit('/templates/duplicate/1', function() {
      tester.path().should.eq('/templates/duplicate/1');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/template_new.html');
      tester.destroy();
      done();
    });
  });

  it('should load the checklist.html partial when /checklists/:id route is accessed', function(done) {
    tester.visit('/checklists/1', function() {
      tester.path().should.eq('/checklists/1');
      var current = tester.inject('$route').current;
      var partial = current.templateUrl;
      expect(partial).to.eql('/assets/partials/checklist.html');
      tester.destroy();
      done();
    });
  });

});